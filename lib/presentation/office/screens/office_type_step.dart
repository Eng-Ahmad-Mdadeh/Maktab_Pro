import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/adding_licensed_office_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/adding_marketing_request_section.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

import '../../widgets/maktab_button.dart';

class OfficeTypeStep extends StatefulWidget {
  const OfficeTypeStep({super.key});

  @override
  State<OfficeTypeStep> createState() => _OfficeTypeStepState();
}

class _OfficeTypeStepState extends State<OfficeTypeStep> {
  late OfficeState state;

  bool _isMarketingLicenseMismatchError(String message) {
    if (message.isEmpty) return false;
    return message.contains('MARKETING_LICENSE_MISMATCH');
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
                  child: const Icon(Icons.close, color: AppColors.steelGray),
                ),
              ),
              SizedBox(height: 8.v),
              const Text(
                'لا يمكن التحقق من الرخصة قبل إكمال رقم رخصة\nالوساطة في بيانات الحساب',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: AppColors.steelGray),
              ),
              SizedBox(height: 24.v),
              Text(
                licenseNumber,
                style: const TextStyle(fontSize: 28, color: AppColors.black, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 28.v),
              Row(
                children: [
                  Expanded(
                    child: MaktabButton(
                      title: 'تعديل',
                      buttonColor: AppColors.emeraldTeal,
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ),
                  SizedBox(width: 12.h),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.black,
                        side: const BorderSide(color: AppColors.steelGray),
                        minimumSize: Size(double.infinity, 54.v),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
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
          previous.imagesErrorMessage != current.imagesErrorMessage &&
          _isMarketingLicenseMismatchError(current.imagesErrorMessage),
      listener: (context, state) {
        _showMarketingLicenseMismatchDialog(context, state.licenseNumber);
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
