import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/office/widgets/adding_licensed_office_section.dart';
import 'package:maktab/presentation/office/widgets/adding_marketing_request_section.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeTypeStep extends StatefulWidget {
  const OfficeTypeStep({super.key});

  @override
  State<OfficeTypeStep> createState() => _OfficeTypeStepState();
}

class _OfficeTypeStepState extends State<OfficeTypeStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
