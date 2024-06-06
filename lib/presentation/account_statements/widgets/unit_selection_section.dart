import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/account_summary/account_summary_bloc.dart';
import '../../widgets/maktab_text_form_field.dart';

class UnitSelectionSection extends StatelessWidget {
  const UnitSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaktabTextFormField(
      title: 'ابحث بحسب رقم الجوال',
      onChanged: (value){
        context.read<AccountSummaryBloc>().add(FilterAccountSummary(value??'', true));
      },
    );
  }
}
