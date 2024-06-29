// ignore_for_file: must_be_immutables, body_might_complete_normally_nullable
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/classes/numerical_range_formatter.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeDepositFormField extends StatefulWidget {
  const OfficeDepositFormField({super.key});

  @override
  State<OfficeDepositFormField> createState() => _OfficeDepositFormFieldState();
}

class _OfficeDepositFormFieldState extends State<OfficeDepositFormField> {
  late TextEditingController _depositController;
  final GlobalKey<FormState> _depositFormKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> depositTypes = [
    {'title': 'سعر', 'type': DepositTypes.price},
    {'title': 'نسبة', 'type': DepositTypes.percentage},
  ];

  @override
  void initState() {
    _depositController = TextEditingController(
        text: context.read<OfficeBloc>().state.depositAmount > -1
            ? context.read<OfficeBloc>().state.depositAmount.toString()
            : '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(flex: 2, child: SectionTitle(title: 'العربون')),
            SizedBox(width: 10.h),
            Expanded(
              flex: 3,
              child: BlocBuilder<OfficeBloc, OfficeState>(
                builder: (context, state) {
                  return DropdownButtonFormField2(
                    value: state.depositType,
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: AppColors.slateGray,
                        size: 25,
                      ),
                      openMenuIcon: Icon(
                        Icons.keyboard_arrow_up_sharp,
                        color: AppColors.slateGray,
                        size: 25,
                      ),
                    ),
                    items: depositTypes.map((format) {
                      return DropdownMenuItem<DepositTypes>(
                        value: format['type'],
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: BodyText(
                            text: format['title'],
                          ),
                        ),
                      );
                    }).toList(),
                    decoration:
                        (const InputDecoration()).applyDefaults(Theme.of(context).inputDecorationTheme),
                    onChanged: (value) {
                      _depositController.clear();
                      context.read<OfficeBloc>().add(SelectDepositTypeEvent(value!));
                    },
                  );
                },
              ),
            ),
            SizedBox(width: 10.h),
            Expanded(
              flex: 4,
              child: Form(
                key: _depositFormKey,
                child: BlocBuilder<OfficeBloc, OfficeState>(
                  builder: (context, state) {
                    return MaktabTextFormField(
                      controller: _depositController,
                      textInputType: TextInputType.number,
                      errorStyle: TextStyle(height: 0.v),
                      suffix: SizedBox(
                        width: 50.h,
                        child: Align(
                          alignment: Alignment.center,
                          child: BodyText(
                            text: state.depositType == DepositTypes.price ? 'ريال' : '%',
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        state.depositType == DepositTypes.percentage
                            ? NumericalRangeFormatter(min: 0, max: 100)
                            : NumericalRangeFormatter(min: 0, max: double.infinity)
                      ],
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          context.read<OfficeBloc>().add(ChangeDepositAmountEvent(''));
                          return '';
                        } else {
                          context.read<OfficeBloc>().add(ChangeDepositAmountEvent(value.trim()));
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.v),
        BlocBuilder<OfficeBloc, OfficeState>(
          builder: (context, state) {
            return state.depositAmount == -1
                ? const BodyText(
                    text: 'يجب ادخال العربون',
                    textColor: AppColors.cherryRed,
                  )
                /*: state.selectedUnitPrices.values.isNotEmpty
                    ? state.depositType == DepositTypes.price &&
                            state.selectedUnitPrices.values.min < state.depositAmount
                        ? BodyText(
                            text:
                                'يجب أن يكون العربون أقل من أصغر سعر ${state.selectedUnitPrices.values.min}',
                            textColor: AppColors.cherryRed,
                          )
                        : const SizedBox.shrink()*/
                    : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
