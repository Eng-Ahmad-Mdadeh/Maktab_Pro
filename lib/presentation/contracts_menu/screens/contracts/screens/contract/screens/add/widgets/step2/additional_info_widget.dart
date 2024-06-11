import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../../domain/contracts/contract/add/contract_state.dart';
import '../../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../../widgets/body_text.dart';
import '../contract_group_button.dart';
import '../contract_input_widget.dart';
import '../contract_switch_widget.dart';

class AdditionalInfoWidget extends StatelessWidget {
  const AdditionalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.v),
      child: BlocBuilder<ContractCubit, ContractEntity>(
        builder: (context, state) {
          return ExpansionTile(
            title: const BodyText(text: "معلومات إضافية"),
            initiallyExpanded: true,
            collapsedBackgroundColor: AppColors.deepBlue,
            textColor: AppColors.black,
            collapsedTextColor: AppColors.white,
            children: [
              Column(
                children: [
                  ContractSwitchWidget(
                    title: "هل يوجد مكيفات ؟",
                    onSwitch: context.read<ContractCubit>().setisConditions,
                    value: state.isConditions ?? false,
                  ),
                  if (state.isConditions ?? false)
                    Column(
                      children: [
                        ContractInputWidget(
                          title: "عدد المكيفات",
                          onChanged: context.read<ContractCubit>().setconditionsCount,
                          controller: context.read<ContractCubit>().conditionsCount,
                          numberMode: true,
                        ),
                        ContractGroupButton<ConditionsType>(
                          title: "",
                          onButtonSelected: context.read<ContractCubit>().setconditionsType,
                          // items: const ["مركزي", "شباك", "إسبيلت"],
                          items: const [ConditionsType.central, ConditionsType.window, ConditionsType.split],
                          itemsText: [
                            context.read<ContractCubit>().getName(ConditionsType.central),
                            context.read<ContractCubit>().getName(ConditionsType.window),
                            context.read<ContractCubit>().getName(ConditionsType.split),
                          ],
                          value: state.conditionsType ?? ConditionsType.central,
                        ),
                      ],
                    ),
                ],
              ),
              ContractGroupButton<WaterElectricityType>(
                title: "الماء",
                // items: const ["حسب قراءة العداد", "مبلغ ثابت"],
                items: const [WaterElectricityType.sameWithCounter, WaterElectricityType.amount],
                itemsText: [
                  context.read<ContractCubit>().getName(WaterElectricityType.sameWithCounter),
                  context.read<ContractCubit>().getName(WaterElectricityType.amount),
                ],
                onButtonSelected: context.read<ContractCubit>().setwaterType,
                onTextChanged: context.read<ContractCubit>().setwaterConstAmount,
                value: state.waterType ?? WaterElectricityType.sameWithCounter,
                controller: context.read<ContractCubit>().waterConstAmount,
              ),
              ContractGroupButton<WaterElectricityType>(
                title: "الكهرباء",
                // items: const ["حسب قراءة العداد", "مبلغ ثابت"],
                items: const [WaterElectricityType.sameWithCounter, WaterElectricityType.amount],
                itemsText: [
                  context.read<ContractCubit>().getName(WaterElectricityType.sameWithCounter),
                  context.read<ContractCubit>().getName(WaterElectricityType.amount),
                ],
                onButtonSelected: context.read<ContractCubit>().setelectricityType,
                onTextChanged: context.read<ContractCubit>().setelectricityConstAmount,
                value: state.electricityType ?? WaterElectricityType.sameWithCounter,
                controller: context.read<ContractCubit>().electricityConstAmount,
              ),
              ContractGroupButton<PaymentCycleType>(
                title: "دورة سداد الإيجار",
                // items: const ["شهري", "ربع سنوي", "نصف سنوي ", "سنوي"],
                items: const [PaymentCycleType.monthly, PaymentCycleType.quarterlyYearly, PaymentCycleType.midYearly, PaymentCycleType.yearly],
                itemsText: [
                  context.read<ContractCubit>().getName(PaymentCycleType.monthly),
                  context.read<ContractCubit>().getName(PaymentCycleType.quarterlyYearly),
                  context.read<ContractCubit>().getName(PaymentCycleType.midYearly),
                  context.read<ContractCubit>().getName(PaymentCycleType.yearly),
                ],
                onButtonSelected: context.read<ContractCubit>().setrentPaymentCycle,
                value: state.rentPaymentCycle ?? PaymentCycleType.monthly,
              ),
              ContractGroupButton<TypeReservationType>(
                title: "نوع الإيجار",
                // items: const ["شهري", "سنوي"],
                items: const [TypeReservationType.monthly, TypeReservationType.yearly],
                itemsText: [
                  context.read<ContractCubit>().getName(TypeReservationType.monthly),
                  context.read<ContractCubit>().getName(TypeReservationType.yearly),
                ],
                onButtonSelected: context.read<ContractCubit>().setidTypeReservation,
                value: state.idTypeReservation ?? TypeReservationType.monthly,
              ),
              ContractInputWidget(
                title: "تاريخ بداية العقد ( المباشرة الفعلية )",
                hint: "يوم / شهر  سنة",
                disabled: true,
                onDatePressed: context.read<ContractCubit>().setcontractStartDateDT,
                onChanged: context.read<ContractCubit>().setcontractStartDate,
                controller: context.read<ContractCubit>().contractStartDate,
              ),
              ContractInputWidget(
                title: "تاريخ بداية العقد",
                hint: "يوم / شهر  سنة",
                disabled: true,
                onDatePressed: context.read<ContractCubit>().setactionDateDT,
                onChanged: context.read<ContractCubit>().setactionDate,
                controller: context.read<ContractCubit>().actionDate,
              ),
              ContractInputWidget(
                title: "تاريخ نهاية العقد",
                hint: "يوم / شهر  سنة",
                disabled: true,
                onDatePressed: context.read<ContractCubit>().setcontractEndDateDT,
                onChanged: context.read<ContractCubit>().setcontractEndDate,
                controller: context.read<ContractCubit>().contractEndDate,
              ),
              ContractInputWidget(
                title: "المدة المحددة بالأيام لافتتاح ومباشرة النشاط",
                hint: "حدد الأيام",
                numberMode: true,
                onChanged: context.read<ContractCubit>().setdurationDaysOpenContract,
                controller: context.read<ContractCubit>().durationDaysOpenContract,
              ),
              ContractInputWidget(
                title: "المدة بالأيام لفسخ العقد في حال تأخر الافتتاح",
                hint: "حدد الأيام",
                numberMode: true,
                onChanged: context.read<ContractCubit>().setdurationDaysCancelContract,
                controller: context.read<ContractCubit>().durationDaysCancelContract,
              ),
              ContractInputWidget(
                title: "هل لديك ملاحظات إضافية  ؟",
                hint: "إضافة ملاحظة ",
                maxLines: 5,
                req: false,
                onChanged: context.read<ContractCubit>().setnotes,
                controller: context.read<ContractCubit>().notes,
              ),
            ],
          );
        },
      ),
    );
  }
}

enum ConditionsType { central, window, split }

enum WaterElectricityType { sameWithCounter, amount }

// 'Monthly','Quarterly Yearly','Mid Yearly','Yearly'
enum PaymentCycleType { monthly, quarterlyYearly, midYearly, yearly }

// monthly: 3, yearly: 4
enum TypeReservationType { monthly, yearly }

