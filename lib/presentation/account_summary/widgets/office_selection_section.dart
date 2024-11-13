
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';

import '../../../domain/account_summary/account_summary_bloc.dart';

class OfficeSelectionSection extends StatelessWidget {
  const OfficeSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaktabSolidTextFormField(
      title: 'ابحث بحسب رقم الحجز',
      keyboardType: TextInputType.number,
      onChanged: (value){
        context.read<AccountSummaryBloc>().add(FilterAccountSummary(value, false));
      },
    );
  }
}
