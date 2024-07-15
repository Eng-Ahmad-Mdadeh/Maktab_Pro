import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class StcPolicySection extends StatelessWidget {
  const StcPolicySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.paleBlue,
              padding: EdgeInsets.symmetric(vertical: 10.v, horizontal: 10.h),
              child: const SectionTitle(
                title:
                    'ابتداءً من تاريخ 28 مايو 2023 سوف يتم تطبيق رسوم %0.5 (غير شامل ضريبة القيمة المضافة) من مبلغ الحوالة على الحوالات عند اختيار طريقة الدفع STC Pay وستطبق على الحوالات القادمة بعد هذا التاريخ',
                textAlign: TextAlign.right,
                textColor: AppColors.skyBlue,
              ),
            ),
            SizedBox(height: 20.v),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () {
                context
                    .read<ReceivingMethodBloc>()
                    .add(ToggleStcPayPolicyEvent());
              },
              leading: BlocBuilder<ReceivingMethodBloc, ReceivingMethodState>(
                builder: (context, state) {
                  return Checkbox(
                    fillColor: const WidgetStatePropertyAll(AppColors.gray),
                    value: state.acceptStcPayPolicy,
                    onChanged: (bool? value) {
                      context
                          .read<ReceivingMethodBloc>()
                          .add(ToggleStcPayPolicyEvent());
                    },
                  );
                },
              ),
              title: const BodyText(
                text: 'لقد قرأت واطلعت على السياسة الجديدة',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
