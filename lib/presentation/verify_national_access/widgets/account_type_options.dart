import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/domain/national_access/national_access_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';

class AccountTypeOptions extends StatelessWidget {
  const AccountTypeOptions({
    super.key,
    required this.type,
  });

  final AccountTypes type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaktabButton(
            text: 'هوية وطنية',
            color: AppColors.white,
            backgroundColor: type == AccountTypes.identity
                ? AppColors.mintTeal
                : AppColors.mintGreen,
            isBordered: true,
            borderRadius: BorderRadius.circular(0),
            onPressed: () {
              context
                  .read<NationalAccessBloc>()
                  .add(SelectAccountTypeEvent(AccountTypes.identity));
            },
          ),
        ),
        Expanded(
          child: MaktabButton(
            text: 'إقامة',
            color: AppColors.white,
            backgroundColor: type == AccountTypes.residence
                ? AppColors.mintTeal
                : AppColors.mintGreen,
            isBordered: true,
            borderRadius: BorderRadius.circular(0),
            onPressed: () {
              context
                  .read<NationalAccessBloc>()
                  .add(SelectAccountTypeEvent(AccountTypes.residence));
            },
          ),
        ),
      ],
    );
  }
}
