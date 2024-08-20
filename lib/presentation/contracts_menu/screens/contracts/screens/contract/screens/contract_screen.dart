import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/data/repositories/settings_repository.dart';
import 'package:maktab_lessor/presentation/widgets/loading_widget.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../../../../core/services/service_locator.dart';
import '../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../core/network/api_endpoints.dart';
import '../../../../../../../data/models/contract/contract_model.dart';
import '../../../../../../../domain/contracts/contract/contract_bloc.dart';
import '../../../../../../../domain/contracts/contracts_bloc.dart';
import '../../../../../../../domain/contracts/contracts_event.dart';
import '../../../../../../../domain/contracts/contracts_step_cubit.dart';
import '../../../../../../widgets/body_text.dart';
import '../../../../../../resources/app_assets.dart';
import '../../../../../../resources/app_colors.dart';
import '../../../../../../widgets/confirm_alert_dialog.dart';
import '../widgets/step1/contract_button.dart';
import '../widgets/step1/contract_step1.dart';
import '../widgets/step2/contract_step2.dart';
import '../widgets/step3/contract_step3.dart';
import '../widgets/step4/contract_step4.dart';
import '../widgets/steps_widget.dart';

import 'print/contract_print_screen_first_page.dart';
import 'print/contract_print_screen_second_page.dart';
import 'print/contract_print_screen_third_page.dart';

class PrintingContractCubit extends Cubit<bool> {
  PrintingContractCubit() : super(false);

  void setPrinting() => emit(true);

  void setIdle() => emit(false);
}

class ContractScreen extends StatefulWidget {
  final bool cancelContract;

  const ContractScreen({super.key, required this.cancelContract});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  late final PageController _controller;
  late ContractStepCubit _contractStepCubit;

  @override
  void initState() {
    _contractStepCubit = ContractStepCubit();
    _controller = PageController(initialPage: 0)
      ..addListener(() {
        final i = _controller.page?.round() ?? 0;
        _contractStepCubit.changeStep(i + 1);
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _contractStepCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _contractStepCubit,
        ),
        BlocProvider(
          create: (context) => PrintingContractCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: AppColors.white,
          actions: [
            BlocBuilder<PrintingContractCubit, bool>(
              builder: (context, state) {
                if (state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.h),
                    child: LoadingWidget(
                      1,
                      size: 30.0.h,
                    ),
                  );
                }
                return IconButton(
                  onPressed: () {
                    final contract = (context.read<ContractBloc>().state as ContractSuccess).contract;
                    _print(contract, context);
                  } /*_print(contract)*/,
                  icon: MaktabImageView(
                    imagePath: AppAssets.printer,
                    color: AppColors.darkGreen,
                    width: 25.0.h,
                    height: 25.0.h,
                  ),
                );
              },
            ),
            SizedBox(width: 10.0.h),
          ],
        ),
        body: BlocConsumer<ContractBloc, ContractState>(
          listener: (context, state){
            if(state is ContractDeletedSuccess){
              context.read<ContractsBloc>().add(GetContractsEvent());
            }
          },
          builder: (context, state) {
            if (state is ContractFailure) {
              if (state.message.contains('غير موجود')) {
                return const Center(child: BodyText(text: "هذا العقد غير موجود ربما يكون قد تم حذفه"));
              }
              return Center(child: BodyText(text: state.message));
            }
            if (state is ContractLoading) {
              return const LoadingWidget(1);
            }
            if (state is ContractSuccess) {
              final contract = state.contract;
              print(contract.contractType);
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                    child: StepsWidget(
                      onPressed: (int i) {
                        _controller.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      children: [
                        ContractStep1(contract: contract),
                        ContractStep2(contract: contract),
                        ContractStep3(contract: contract),
                        ContractStep4(contract: contract),
                      ],
                    ),
                  ),
                  if(!(contract.tenantApproved ?? false) || !(contract.lessorApproved ?? false))
                  SizedBox(
                    width: SizeHelper.width * .5,
                    child: ContractButton(
                      onPressed: !(contract.tenantApproved ?? false) && (contract.lessorApproved ?? false)
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (context2) {
                                  return ConfirmAlertDialog(
                                    alertText: 'سوف يتم الغاء العقد',
                                    confirmOnPressed: () {
                                      context.read<ContractBloc>().add(DeleteContractEvent(contract.id!));
                                      context.pop();
                                    },
                                    cancelOnPressed: () => context.pop(),
                                  );
                                },
                              );
                            },
                      text: !(contract.tenantApproved ?? false) && (contract.lessorApproved ?? false) ? 'بانتظار الطرف الاخر' : 'الغاء',
                      color: !(contract.tenantApproved ?? false) && (contract.lessorApproved ?? false) ? AppColors.gray : AppColors.cherryRed,
                      icon: !(contract.tenantApproved ?? false) && (contract.lessorApproved ?? false) ? null : AppAssets.deleteContract,
                    ),
                  ),
                  SizedBox(
                    height: 7.0.v,
                  ),
                ],
              );
            }
            return const Center(
              child: BodyText(text: "محتوى العقد غير متوفر"),
            );
          },
        ),
      ),
    );
  }

  Future<void> _print(ContractModel contract, BuildContext context) async {
    context.read<PrintingContractCubit>().setPrinting();
    log("////////////////////////////");
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.tajawalMedium();
    final materialFont = await PdfGoogleFonts.materialIcons();
    final generalSettings = await locator<SettingsRepository>().getGeneralSettings();
    var logoURL = '';
    generalSettings.fold((l) {}, (r) => logoURL = r.logo ?? '');

    final logo = await networkImage(ApiEndpoints.siteUrl + logoURL);

    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) => ContractPrintFirstPageScreen(
          contract,
          font: font,
          materialFont: materialFont,
          logo: logo,
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) => ContractPrintSecondPageScreen(
          contract,
          font: font,
          materialFont: materialFont,
          logo: logo,
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) => ContractPrintThirdPageScreen(
          contract,
          font: font,
          materialFont: materialFont,
          logo: logo,
        ),
      ),
    );
    final path = await getDownloadsDirectory();

    final file = File('${path?.path}/contract ${contract.actionDate}.pdf');

    await file.writeAsBytes(await pdf.save());
    //   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    Share.shareXFiles([XFile(file.path)]).then((e) {
      context.read<PrintingContractCubit>().setIdle();
    });
  }
}
