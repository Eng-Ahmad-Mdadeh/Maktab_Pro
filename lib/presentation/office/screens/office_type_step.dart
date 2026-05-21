import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/adding_licensed_office_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/adding_marketing_request_section.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

import '../../widgets/maktab_button.dart';

class OfficeTypeStep extends StatefulWidget {
  const OfficeTypeStep({super.key});

  @override
  State<OfficeTypeStep> createState() => _OfficeTypeStepState();
}

class _OfficeTypeStepState extends State<OfficeTypeStep> {
  late OfficeState state;

  bool _isMarketingLicenseMismatchError(OfficeState state) {
    if (state.errorKeyMessage.isNotEmpty) {
      return state.errorKeyMessage == 'MARKETING_LICENSE_MISMATCH';
    }
    if (state.imagesErrorMessage.isEmpty) return false;
    return state.imagesErrorMessage.contains('MARKETING_LICENSE_MISMATCH');
  }

  void _showMarketingLicenseMismatchDialog(BuildContext context, String licenseNumber) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 18.v),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () => Navigator.of(dialogContext).pop(),
                  child: const Icon(Icons.close, color: AppColors.gray),
                ),
              ),
              SizedBox(height: 8.v),
              const BodyText(
                textAlign: TextAlign.center,
                text: 'لا يمكن التحقق من الرخصة قبل إكمال رقم رخصة الوساطة في بيانات الحساب',
                textColor: AppColors.black2,
              ),
              SizedBox(height: 24.v),
              SectionTitle(
                title: licenseNumber,
              ),
              SizedBox(height: 28.v),
              Row(
                children: [
                  Expanded(
                    child: MaktabButton(
                      text: 'تعديل',
                      backgroundColor: AppColors.emeraldTeal,
                      color: AppColors.white,
                      onPressed: () {
                        context.pushNamed(AppRoutes.editProfileScreen, extra: true);
                        context.pop();
                      },
                    ),
                  ),
                  SizedBox(width: 12.h),
                  Expanded(
                    child: MaktabButton(
                      text: 'رجوع',
                      isBordered: true,
                      backgroundColor: AppColors.white,
                      borderColor: AppColors.black,
                      color: AppColors.black,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    state = context.read<OfficeBloc>().state;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if ((state.licenseNumber.isEmpty || state.licenseNumber == '') && state.createdUnit != null) {
      context.read<OfficeBloc>().add(const SetOfficeTypesEvent(OfficeTypes.request));
      print('!!!!!!');
      print(state.officeType);
      print('!!!!!!');
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OfficeBloc, OfficeState>(
      listenWhen: (previous, current) =>
          (previous.imagesErrorMessage != current.imagesErrorMessage ||
              previous.errorKeyMessage != current.errorKeyMessage) &&
          _isMarketingLicenseMismatchError(current),
      listener: (context, state) {
        if (state.errorKeyMessage == "MARKETING_LICENSE_MISMATCH") {
          _showMarketingLicenseMismatchDialog(context, state.licenseNumber);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<OfficeBloc, OfficeState>(
              builder: (context, state) {
                return SectionTitle(
                  title: state.officeType == OfficeTypes.none
                      ? 'يرجى اختيار نوع الإعلان (النوع اجباري)'
                      : state.createdOffice != null
                          ? 'لا يمكنك تعديل هذه الخطوة بعد حفظها'
                          : 'يرجى اختيار نوع الإعلان ',
                  textColor: state.officeType == OfficeTypes.none
                      ? AppColors.cherryRed
                      : state.createdOffice != null
                          ? AppColors.cherryRed
                          : AppColors.black,
                );
              },
            ),
            SizedBox(height: 30.v),
            const AddingLicensedOfficeSection(),
            SizedBox(height: 25.v),
            const Divider(color: AppColors.softAsh, thickness: 1),
            SizedBox(height: 25.v),
            const AddingMarketingRequestSection(),
          ],
        ),
      ),
    );
  }
}
