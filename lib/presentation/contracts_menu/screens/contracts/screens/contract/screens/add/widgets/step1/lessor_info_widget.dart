import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/contracts/contract/add/contract_state.dart';

import '../../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../../widgets/body_text.dart';
import '../../../../../../../../../widgets/section_title.dart';
import '../contract_input_widget.dart';
import '../contract_select_widget.dart';

class LessorExpansionStatusCubit extends Cubit<bool> {
  LessorExpansionStatusCubit() : super(true);

  void toggleStatus(bool v) => emit(v);
}

class LessorInfoWidget extends StatelessWidget {
  const LessorInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.v),
      child: BlocProvider(
        create: (context) => LessorExpansionStatusCubit(),
        child: BlocBuilder<LessorExpansionStatusCubit, bool>(
          builder: (context, state) {
            return ExpansionTile(
              initiallyExpanded: true,
              // backgroundColor: AppColors.deepBlue,
              collapsedBackgroundColor: AppColors.deepBlue,
              collapsedTextColor: AppColors.white,
              shape: Border.all(width: 0, color: AppColors.white),
              textColor: AppColors.black,
              onExpansionChanged: context.read<LessorExpansionStatusCubit>().toggleStatus,
              title: BodyText(
                text: "معلومات المؤجر",
                textColor: state ? AppColors.black : AppColors.white,
                // fontSize: 15.0,
              ),
              children: [
                ContractInputWidget(
                  title: "الاسم",
                  hint: "ادخل الاسم الثلاثي",
                  validator: (value) {
                    if ((value ?? '').length < 4) {
                      return 'ادخل اسمك الكامل';
                    }
                    return null;
                  },
                  onChanged: context.read<ContractCubit>().setlessorFullName,
                  controller: context.read<ContractCubit>().lessorFullName,
                ),
                ContractInputWidget(
                  title: "الهوية / الإقامة",
                  hint: "رقم هوية المؤجر",
                  numberMode: true,
                  onChanged: context.read<ContractCubit>().setlessorIdentityNum,
                  controller: context.read<ContractCubit>().lessorIdentityNum,
                ),
                BlocBuilder<ContractCubit, ContractEntity>(
                  builder: (context, state) {
                    return ContractSelectWidget<IdentityType>(
                      title: "نوع الهوية",
                      // items: const ["هوية وطنية", "هوية اقامة"],
                      value: state.lessorIdentityType,
                      children: [
                        context.read<ContractCubit>().getName(IdentityType.national),
                        context.read<ContractCubit>().getName(IdentityType.residence)
                      ],
                      items: const [IdentityType.national, IdentityType.residence],
                      onChanged: context.read<ContractCubit>().setlessorIdentityType,
                    );
                  },
                ),
                ContractInputWidget(
                  title: "الجنسية",
                  hint: "جنسية المؤجر",
                  onChanged: context.read<ContractCubit>().setlessorNationality,
                  controller: context.read<ContractCubit>().lessorNationality,
                ),
                ContractInputWidget(
                  title: "رقم الجوال",
                  hint: "رقم جوال المؤجر",
                  phoneMode: true,
                  onChanged: context.read<ContractCubit>().setlessorPhone,
                  controller: context.read<ContractCubit>().lessorPhone,
                  validator: (value) {
                    final regex = RegExp('^(009665|9665|\\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})\$');
                    if (!regex.hasMatch(value ?? '')) {
                      return "ادخل رقم هاتف صحيح";
                    }
                    return null;
                  },
                ),
                ContractInputWidget(
                  title: "العنوان",
                  hint: " عنوان المؤجر",
                  onChanged: context.read<ContractCubit>().setlessorAddress,
                  controller: context.read<ContractCubit>().lessorAddress,
                ),
                ContractInputWidget(
                  title: "تاريخ ميلاد المؤجر",
                  hint: "يوم / شهر  سنة",
                  onDatePressed: context.read<ContractCubit>().setlessorDateBirthDT,
                  onChanged: context.read<ContractCubit>().setlessorDateBirth,
                  disabled: true,
                  birthDate: true,
                  controller: context.read<ContractCubit>().lessorDateBirth,
                ),
                ContractInputWidget(
                  title: "رقم البيان",
                  hint: "رقم البيان",
                  // inputFormatters: [
                  //   // FilteringTextInputFormatter.allow(RegExp("\\d{2}[a-zA-Z0-9]{18}")),
                  // ],
                  suffix: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SectionTitle(
                        title: "SA",
                      ),
                    ],
                  ),
                  validator: (value) {
                    final regex = RegExp("\\d{2}[a-zA-Z0-9]{18}");

                    if (!regex.hasMatch(value ?? '')) {
                      return 'ادخل رقم ايبان صحيح';
                    }

                    // if ((value ?? '').length < 14) {
                    //   return 'يجب ان يكون رقم الايبان اكبر من 14';
                    // }

                    return null;
                  },
                  numberMode: true,
                  onChanged: context.read<ContractCubit>().setlessorIban,
                  controller: context.read<ContractCubit>().lessorIban,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
