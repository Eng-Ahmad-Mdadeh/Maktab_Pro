
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/confirm_alert_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_radio_list_tile.dart';

class ReceivingMethodOption extends StatelessWidget {
  ReceivingMethodOption({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    this.selectedOnChanged,
  });

  final String title;
  final ReceivingMoneyMethods value;
  final ReceivingMoneyMethods groupValue;
  void Function(ReceivingMoneyMethods?)? selectedOnChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaktabRadioListTile(
            title: title,
            value: value,
            groupValue: groupValue,
            onChanged: selectedOnChanged,
          ),
        ),
        if (context.read<ReceivingMethodBloc>().state.receivingMoneyMethod !=
                ReceivingMoneyMethods.none &&
            context.read<ReceivingMethodBloc>().state.receivingMoneyMethod ==
                value)
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context
                      .read<ReceivingMethodBloc>()
                      .add(ShowEditReceivingMoneyMethodEvent());
                },
                icon: Icon(
                  FontAwesomeIcons.penToSquare,
                  color: AppColors.slateGray,
                  size: 35.fSize,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmAlertDialog(
                        alertText: 'سوف يتم الحذف',
                        confirmOnPressed: () {
                          context
                              .read<ReceivingMethodBloc>()
                              .add(DeleteReceivingMoneyMethodEvent());
                        },
                        cancelOnPressed: () => context.pop(),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: AppColors.cherryRed,
                  size: 35.fSize,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
