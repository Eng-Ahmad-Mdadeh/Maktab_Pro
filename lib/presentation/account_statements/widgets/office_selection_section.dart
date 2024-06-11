// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';

import '../../../domain/account_summary/account_summary_bloc.dart';

class OfficeSelectionSection extends StatelessWidget {
  const OfficeSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaktabTextFormField(
      title: 'ابحث بحسب رقم الحجز',
      onChanged: (value){
        context.read<AccountSummaryBloc>().add(FilterAccountSummary(value, false));
      },
    );
  }
}
