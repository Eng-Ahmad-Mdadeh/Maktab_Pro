import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../../domain/contracts/contract/add/contract_state.dart';
import '../../../../../../../../../resources/app_colors.dart';
import '../contract_image_widget.dart';
import '../contract_input_widget.dart';
import '../contract_select_widget.dart';

class TenantInfoWidget extends StatelessWidget {
  const TenantInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.v),
      child: ExpansionTile(
        // backgroundColor: AppColors.deepBlue,
        initiallyExpanded: true,
        collapsedBackgroundColor: AppColors.deepBlue,
        collapsedTextColor: AppColors.white,
        textColor: AppColors.black,
        title: const Text(
          "معلومات المستأجر",
          // textColor: AppColors.white,
          // fontSize: 15.0,
        ),
        children: [
          ContractInputWidget(
            title: "الاسم",
            hint: "الاسم الثلاثي لممثل المؤسسة",
            onChanged: context.read<ContractCubit>().settenantFullName,
            validator: (value){
              if((value??'').length < 4){
                return 'ادخل اسمك الكامل';
              }
              return null;
            },
            controller: context.read<ContractCubit>().tenantFullName,
          ),
          ContractInputWidget(
            title: "الهوية / الإقامة",
            hint: "رقم هوية ممثل المؤسسة",
            numberMode: true,
            onChanged: context.read<ContractCubit>().settenantIdentityNum,
            controller: context.read<ContractCubit>().tenantIdentityNum,
          ),
          BlocBuilder<ContractCubit, ContractEntity>(
            builder: (context, state) {
              return ContractSelectWidget<IdentityType>(
                title: "نوع الهوية",
                // items: const ["هوية وطنية", "هوية اقامة"],
                value: state.tenantIdentityType,
                children: [
                  context.read<ContractCubit>().getName(IdentityType.national),
                  context.read<ContractCubit>().getName(IdentityType.residence)
                ],
                items: const [IdentityType.national, IdentityType.residence],
                onChanged: context.read<ContractCubit>().settenantIdentityType,
              );
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
            validator: (value){
              final regex = RegExp('^(009665|9665|\\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})\$');
              if(!regex.hasMatch(value??'')){
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
          ContractInputWidget(
            title: "رقم السجل التجاري",
            hint: "رقم السجل التجاري للمنشأة",
            req: false,
            numberMode: true,
            onChanged: context.read<ContractCubit>().setrecordNumber,
            controller: context.read<ContractCubit>().recordNumber,
          ),
          BlocBuilder<ContractCubit, ContractEntity>(
            builder: (context, state) {
              return ContractImageWidget(
                selectedPath: state.recordFile,
                onImageSelected: context.read<ContractCubit>().setrecordFile,
              );
            },
          )
        ],
      ),
    );
  }
}
