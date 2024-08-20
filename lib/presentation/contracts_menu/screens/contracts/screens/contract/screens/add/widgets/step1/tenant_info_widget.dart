import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import '../../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../../domain/contracts/contract/add/contract_state.dart';
import '../../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../../widgets/body_text.dart';
import '../contract_image_widget.dart';
import '../contract_input_widget.dart';
import '../contract_select_widget.dart';

class TenantExpansionStatusCubit extends Cubit<bool> {
  TenantExpansionStatusCubit() : super(true);

  void toggleStatus(bool v) => emit(v);
}

class TenantInfoWidget extends StatelessWidget {
  const TenantInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TenantExpansionStatusCubit(),
      child: Padding(
        padding: EdgeInsets.only(top: 20.0.v),
        child: BlocBuilder<TenantExpansionStatusCubit, bool>(
          builder: (context, state) {
            return BlocBuilder<ContractCubit, ContractEntity>(
              builder: (context, contractState) {
                return ExpansionTile(
                  // backgroundColor: AppColors.deepBlue,
                  initiallyExpanded: true,
                  collapsedBackgroundColor: AppColors.deepBlue,
                  collapsedTextColor: AppColors.white,
                  textColor: AppColors.black,
                  onExpansionChanged: context.read<TenantExpansionStatusCubit>().toggleStatus,
                  shape: Border.all(width: 0, color: AppColors.white),
                  title: BodyText(
                    text: "معلومات المستأجر",
                    textColor: !state ? AppColors.white : AppColors.black,
                    // fontSize: 15.0,
                  ),
                  children: [
                    ContractSelectWidget<TenantType>(
                      title: "نوع المؤجر",
                      // items: const ["هوية وطنية", "هوية اقامة"],
                      value: contractState.tenantType,
                      children: [
                        context.read<ContractCubit>().getName(TenantType.personally),
                        context.read<ContractCubit>().getName(TenantType.organisation)
                      ],
                      items: const [TenantType.personally, TenantType.organisation],
                      onChanged: context.read<ContractCubit>().settenantType,
                    ),
                    ContractInputWidget(
                      title: "الاسم",
                      hint: contractState.tenantType == TenantType.organisation ? "الاسم الثلاثي لممثل المؤسسة" : "الاسم الثلاثي",
                      onChanged: context.read<ContractCubit>().settenantFullName,
                      validator: (value) {
                        if ((value ?? '').length < 4) {
                          return 'ادخل اسمك الكامل';
                        }
                        return null;
                      },
                      controller: context.read<ContractCubit>().tenantFullName,
                    ),
                    ContractSelectWidget<IdentityType>(
                      title: "نوع الهوية",
                      // items: const ["هوية وطنية", "هوية اقامة"],
                      value: contractState.tenantIdentityType,
                      children: [
                        context.read<ContractCubit>().getName(IdentityType.national),
                        context.read<ContractCubit>().getName(IdentityType.residence)
                      ],
                      items: const [IdentityType.national, IdentityType.residence],
                      onChanged: context.read<ContractCubit>().settenantIdentityType,
                    ),
                    ContractInputWidget(
                      title: "الهوية / الإقامة",
                      hint: "رقم هوية ممثل المؤسسة",
                      numberMode: true,
                      onChanged: context.read<ContractCubit>().settenantIdentityNum,
                      controller: context.read<ContractCubit>().tenantIdentityNum,
                      validator: (value) {
                        if ((value ?? '').length < 10) return 'يجب ان يكون أكبر من 10 ارقام';
                        return null;
                      },
                    ),
                    ContractInputWidget(
                      title: "الجنسية",
                      hint: "جنسية المستأجر",
                      onChanged: context.read<ContractCubit>().settenantNationality,
                      controller: context.read<ContractCubit>().tenantNationality,
                    ),
                    ContractInputWidget(
                      title: "رقم الجوال",
                      hint: "رقم جوال المستأجر",
                      phoneMode: true,
                      onChanged: context.read<ContractCubit>().settenantPhone,
                      controller: context.read<ContractCubit>().tenantPhone,
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
                      hint: " عنوان المستأجر",
                      onChanged: context.read<ContractCubit>().settenantAddress,
                      controller: context.read<ContractCubit>().tenantAddress,
                    ),
                    ContractInputWidget(
                      title: "تاريخ ميلاد المستأجر",
                      hint: "يوم / شهر  سنة",
                      onDatePressed: context.read<ContractCubit>().settenantDateBirthDT,
                      birthDate: true,
                      disabled: true,
                      onChanged: context.read<ContractCubit>().settenantDateBirth,
                      controller: context.read<ContractCubit>().tenantDateBirth,
                    ),




                    if(contractState.tenantType == TenantType.organisation)
                    ...{
                      ContractInputWidget(
                        title: "اسم المنشأة",
                        hint: "اسم المنشأة",
                        onChanged: context.read<ContractCubit>().settenantOrgName,
                        req: true,
                        controller: context.read<ContractCubit>().tenantOrgName,
                      ),
                      ContractInputWidget(
                        title: "نوع المنشأة",
                        hint: "نوع المنشأة",
                        req: true,
                        onChanged: context.read<ContractCubit>().settenantOrgType,
                        controller: context.read<ContractCubit>().tenantOrgType,
                      ),
                      ContractInputWidget(
                        title: "الرقم الموحد",
                        hint: "الرقم الموحد",
                        numberMode: true,
                        req: true,
                        onChanged: context.read<ContractCubit>().settenantOrgNumber,
                        controller: context.read<ContractCubit>().tenantOrgNumber,
                      ),
                      ContractInputWidget(
                        title: " تاريخ السجل التجاري",
                        hint: "يوم / شهر  سنة",
                        onDatePressed: context.read<ContractCubit>().setrecordDateDT,
                        req: true,
                        disabled: true,
                        onChanged: context.read<ContractCubit>().setrecordDate,
                        controller: context.read<ContractCubit>().recordDate,
                      ),
                      ContractInputWidget(
                        title: "رقم السجل التجاري",
                        hint: "رقم السجل التجاري للمنشأة",
                        req: true,
                        numberMode: true,
                        onChanged: context.read<ContractCubit>().setrecordNumber,
                        controller: context.read<ContractCubit>().recordNumber,
                      ),
                      ContractImageWidget(
                        selectedPath: contractState.recordFile,
                        onImageSelected: context.read<ContractCubit>().setrecordFile,
                      ),
                    }
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
