import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/widgets/confirm_alert_dialog.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';

class AdditionalServiceForm extends StatefulWidget {
  const AdditionalServiceForm({super.key});

  @override
  State<AdditionalServiceForm> createState() => _AdditionalServiceFormState();
}

class _AdditionalServiceFormState extends State<AdditionalServiceForm> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _serviceEnglishNameController =
      TextEditingController();
  final TextEditingController _servicePricwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: widget.key,
      initiallyExpanded: true,
      maintainState: true,
      collapsedBackgroundColor: AppColors.palePlatinum,
      backgroundColor: AppColors.palePlatinum,
      title: const SizedBox.shrink(),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            FontAwesomeIcons.minus,
            color: AppColors.royalPurple,
          ),
          SizedBox(width: 10.h),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context2) {
                  return ConfirmAlertDialog(
                    alertText: 'سوف يتم الحذف',
                    confirmOnPressed: () {
                      context
                          .read<OfficeBloc>()
                          .add(RemoveAdditionalServiceEvent(widget.key!));
                      context.pop();
                    },
                    cancelOnPressed: () => context.pop(),
                  );
                },
              );
            },
            child: const Icon(
              FontAwesomeIcons.xmark,
              color: AppColors.cherryRed,
            ),
          ),
        ],
      ),
      children: [
        Container(
          padding: EdgeInsets.only(top: 15.v),
          color: AppColors.white,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 15.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.softAsh),
            ),
            child: Form(
              key: context
                  .read<OfficeBloc>()
                  .state
                  .additionalServiceKeys[widget.key],
              child: Column(
                children: [
                  MaktabTextFormField(
                    controller: _serviceNameController,
                    title: 'الاسم',
                    hintText: 'أدخل الاسم',
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'من فضلك أدخل اسم الخدمة بالعربية';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      context
                          .read<OfficeBloc>()
                          .add(SetServiceNameEvent(widget.key!, value!));
                    },
                  ),
                  SizedBox(height: 20.v),
                  MaktabTextFormField(
                    controller: _serviceEnglishNameController,
                    title: 'الاسم باللغة الانكليزية',
                    hintText: 'أدخل الاسم باللغة الانكليزية',
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'من فضلك أدخل اسم الخدمة بالإنكليزي';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      context
                          .read<OfficeBloc>()
                          .add(SetServiceEnglishNameEvent(widget.key!, value!));
                    },
                  ),
                  SizedBox(height: 20.v),
                  MaktabTextFormField(
                    controller: _servicePricwController,
                    title: 'السعر',
                    hintText: 'أدخل السعر',
                    textInputType: TextInputType.number,
                    suffix: SizedBox(
                      width: 50.h,
                      child: const Align(
                        alignment: Alignment.center,
                        child: BodyText(text: 'ريال'),
                      ),
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'من فضلك أضف السعر';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      context
                          .read<OfficeBloc>()
                          .add(SetServicePriceEvent(widget.key!, value!));
                    },
                  ),
                  SizedBox(height: 20.v),
                  Row(
                    children: [
                      BlocBuilder<OfficeBloc, OfficeState>(
                        builder: (context, state) {
                          return MaktabSwitch(
                            value:
                                state.additionalServices[widget.key]!['status'],
                            theme:
                                ThemeData(switchTheme: const SwitchThemeData()),
                            // activeColor: AppColors.emeraldTeal,
                            // activeTrackColor: AppColors.mintGreen,
                            onChanged: (value) => context
                                .read<OfficeBloc>()
                                .add(ToggleServiceStateEvent(widget.key!)),
                          );
                        },
                      ),
                      SizedBox(width: 10.h),
                      const BodyText(
                        text: 'هل الخدمة إجبارية عند الحجز ؟ ',
                        textColor: AppColors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
