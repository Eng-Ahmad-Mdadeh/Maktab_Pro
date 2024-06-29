// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class LicenseNumberForm extends StatefulWidget {
  const LicenseNumberForm({super.key});

  @override
  State<LicenseNumberForm> createState() => _LicenseNumberFormState();
}

class _LicenseNumberFormState extends State<LicenseNumberForm> {
  late TextEditingController _licenseNumberController;
  late GlobalKey<FormState> _licenseNumberFormKey;

  @override
  void initState() {
    _licenseNumberController = TextEditingController(
        text: context.read<OfficeBloc>().state.licenseNumber);
    _licenseNumberFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.v),
      child: Column(
        children: [
          const SectionTitle(
            title:
                'بناء على نظام الوساطة العقارية لا يمكن الاعلان في المنصات العقارية الا بوجود رخصة اعلان',
          ),
          SizedBox(height: 25.v),
          const BodyText(
            text: ' ماهي رخصة الإعلان وكيفية الحصول عليها؟',
            textColor: AppColors.skyBlue,
          ),
          SizedBox(height: 25.v),
          Form(
            key: _licenseNumberFormKey,
            child: MaktabTextFormField(
              controller: _licenseNumberController,
              title: 'رقم الرخصة:',
              hintText: 'يرجى ادخال رقم رخصة اعلان صحيح يبدأ برقم 7',
              textInputType: TextInputType.number,
              readOnly: context.read<OfficeBloc>().state.createdOffice != null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(7),
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'الرجاء ادخال رقم الرخصة';
                } else if (value.length < 7) {
                  return 'يجب أن يكون سبع أرقام';
                }
                return null;
              },
              onChanged: (value) {
                context
                    .read<OfficeBloc>()
                    .add(SetLicenseNumberEvent(_licenseNumberController.text));
              },
            ),
          ),
        ],
      ),
    );
  }
}
