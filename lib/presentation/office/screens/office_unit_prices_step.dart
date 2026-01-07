import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_deposit_form_field.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_price_form_field.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';
import 'package:maktab_lessor/presentation/widgets/phone_text_field.dart';

import '../../widgets/section_title.dart';

class OfficeUnitPricesStep extends StatefulWidget {
  const OfficeUnitPricesStep({super.key});

  @override
  State<OfficeUnitPricesStep> createState() => _OfficeUnitPricesStepState();
}

class _OfficeUnitPricesStepState extends State<OfficeUnitPricesStep> {
  // late TextEditingController _hourlyUnitPriceController;
  // late TextEditingController _dailyUnitPriceController;
  // late TextEditingController _monthlyUnitPriceController;
  // late TextEditingController _yearlyUnitPriceController;
  late TextEditingController _officePriceController;
  late TextEditingController _viewerNameController;
  late TextEditingController _viewerPhoneController;
  final GlobalKey<FormState> _unitPricesFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    OfficeState state = context.read<OfficeBloc>().state;

    if (state.verifyLicenseNumberModel != null) {
      context
          .read<OfficeBloc>()
          .add(SetViewerNameEvent(state.verifyLicenseNumberModel?.viewerName ?? state.createdUnit?.viewerName ?? ''));
      context
          .read<OfficeBloc>()
          .add(SetViewerPhoneEvent(state.verifyLicenseNumberModel?.viewerPhone ?? state.createdUnit?.viewerName ?? ''));
      context.read<OfficeBloc>().add(ChangeUnitPriceEvent(
          state.verifyLicenseNumberModel?.adsPrices != null && state.verifyLicenseNumberModel!.adsPrices.isNotEmpty
              ? state.verifyLicenseNumberModel!.adsPrices.first.price
              : state.adsPrices.first.price));
    }
    // _hourlyUnitPriceController = TextEditingController(
    //     text: state.selectedUnitPrices[UnitPriceOptions.hourly] != null
    //         ? state.selectedUnitPrices[UnitPriceOptions.hourly].toString()
    //         : '');
    // _dailyUnitPriceController = TextEditingController(
    //     text: state.selectedUnitPrices[UnitPriceOptions.daily] != null
    //         ? state.selectedUnitPrices[UnitPriceOptions.daily].toString()
    //         : '');
    // _monthlyUnitPriceController = TextEditingController(
    //     text: state.selectedUnitPrices[UnitPriceOptions.monthly] != null
    //         ? state.selectedUnitPrices[UnitPriceOptions.monthly].toString()
    //         : '');
    // _yearlyUnitPriceController = TextEditingController(
    //     text: state.selectedUnitPrices[UnitPriceOptions.yearly] != null
    //         ? state.selectedUnitPrices[UnitPriceOptions.yearly].toString()
    //         : '');
    // _viewerNameController = TextEditingController(text: state.viewerName);
    // _viewerPhoneController = TextEditingController(text: state.viewerPhone);

    _officePriceController = TextEditingController(
        text: state.verifyLicenseNumberModel?.adsPrices != null && state.verifyLicenseNumberModel!.adsPrices.isNotEmpty
            ? state.verifyLicenseNumberModel!.adsPrices.first.price.toString()
            : state.adsPrices.isNotEmpty
                ? state.adsPrices.first.price.toString()
                : null);
    _viewerNameController = TextEditingController(
      text: state.verifyLicenseNumberModel != null
          ? (state.verifyLicenseNumberModel?.viewerName)
          : state.createdUnit?.viewerName ?? '',
    );
    _viewerPhoneController = TextEditingController(
      text: state.verifyLicenseNumberModel != null
          ? (state.verifyLicenseNumberModel?.viewerPhone)
          : state.createdUnit?.viewerPhone ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'أسعار الوحدة'),
          SizedBox(height: 30.v),
          const BodyText(text: 'اكتب أسعار عقارك الأساسية تقدر تعدل الأسعار ونضيف عروض وخصومات لاحقا'),
          // SizedBox(height: 20.v),
          // BlocBuilder<OfficeBloc, OfficeState>(
          //   builder: (context, state) => state.licenseOfficeState != VisibilityStates.hide
          //       ? Row(
          //           children: [
          //             Expanded(
          //               child: MaktabButton(
          //                 text: 'للبيع',
          //                 color: state.transactionType == TransactionType.sell
          //                     ? AppColors.white
          //                     : AppColors.black,
          //                 backgroundColor:
          //                     state.transactionType == TransactionType.sell
          //                         ? AppColors.lightCyan
          //                         : AppColors.white,
          //                 isBordered: true,
          //                 borderRadius: BorderRadius.circular(0),
          //                 onPressed: () {
          //                   context.read<OfficeBloc>().add(const SelectTransactionTypeEvent(
          //                       TransactionType.sell));
          //                 },
          //               ),
          //             ),
          //             Expanded(
          //               child: MaktabButton(
          //                 text: 'للإيجار',
          //                 color: state.transactionType == TransactionType.rent
          //                     ? AppColors.white
          //                     : AppColors.black,
          //                 backgroundColor:
          //                     state.transactionType == TransactionType.rent
          //                         ? AppColors.lightCyan
          //                         : AppColors.white,
          //                 isBordered: true,
          //                 borderRadius: BorderRadius.circular(0),
          //                 onPressed: () {
          //                   context
          //                       .read<OfficeBloc>()
          //                       .add(const SelectTransactionTypeEvent(TransactionType.rent));
          //                 },
          //               ),
          //             ),
          //           ],
          //         )
          //       : const SizedBox(),
          // ),
          SizedBox(height: 20.v),
          // Form(
          //   key: _unitPricesFormKey,
          //   child: Column(
          //     children: [
          //       OfficePriceFormField(
          //         title: 'ساعة',
          //         option: UnitPriceOptions.hourly,
          //         controller: _hourlyUnitPriceController,
          //       ),
          //       SizedBox(height: 10.v),
          //       OfficePriceFormField(
          //         title: 'يومي',
          //         option: UnitPriceOptions.daily,
          //         controller: _dailyUnitPriceController,
          //       ),
          //       SizedBox(height: 10.v),
          //       OfficePriceFormField(
          //         title: 'شهري',
          //         option: UnitPriceOptions.monthly,
          //         controller: _monthlyUnitPriceController,
          //       ),
          //       SizedBox(height: 10.v),
          //       OfficePriceFormField(
          //         title: 'سنوي',
          //         option: UnitPriceOptions.yearly,
          //         controller: _yearlyUnitPriceController,
          //       ),
          //       SizedBox(height: 20.v),
          //       const Divider(color: AppColors.softAsh),
          //       SizedBox(height: 20.v),
          //       BlocBuilder<OfficeBloc, OfficeState>(
          //         builder: (context, state) {
          //           return state.selectedUnitPriceOptions.contains(UnitPriceOptions.yearly)
          //               ? Column(
          //                   children: [
          //                     const OfficeDepositFormField(),
          //                     SizedBox(height: 20.v),
          //                   ],
          //                 ).animate().fade()
          //               : const SizedBox.shrink();
          //         },
          //       ),
          //       MaktabTextFormField(
          //         controller: _viewerNameController,
          //         title: 'اسم المعاين',
          //         validator: (value) {
          //           if (value!.isEmpty) {
          //             return 'الرجاء ادخال اسم المعاين';
          //           }
          //           return null;
          //         },
          //         onChanged: (value) {
          //           context.read<OfficeBloc>().add(SetViewerNameEvent(value.trim()));
          //         },
          //       ),
          //       SizedBox(height: 20.v),
          //       PhoneTextfield(
          //         controller: _viewerPhoneController,
          //         onChanged: (value) {
          //           context.read<OfficeBloc>().add(SetViewerPhoneEvent(value.trim()));
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          Form(
            key: _unitPricesFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OfficePriceFormField(
                  title: 'سعر',
                  readOnly: context.read<OfficeBloc>().state.officeType == OfficeTypes.license,
                  // option: UnitPriceOptions.yearly,
                  controller: _officePriceController,
                ),
                SizedBox(height: 20.v),
                OfficeDepositFormField(),
                SizedBox(height: 20.v),
              ],
            ),
          ),
          BlocBuilder<OfficeBloc, OfficeState>(builder: (context, state) {
            print(state.createdUnit?.viewerName ?? '');
            return state.licenseOfficeState == VisibilityStates.show
                ? MaktabTextFormField(
                    controller: _viewerNameController,
                    title: 'اسم المعاين',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخال اسم المعاين';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<OfficeBloc>().add(SetViewerNameEvent(value.trim()));
                    },
                  )
                : const SizedBox();
          }),
          SizedBox(height: 20.v),
          BlocBuilder<OfficeBloc, OfficeState>(builder: (context, state) {
            return state.licenseOfficeState == VisibilityStates.show
                ? PhoneTextfield(
                    controller: _viewerPhoneController,
                    onChanged: (value) {
                      context.read<OfficeBloc>().add(SetViewerPhoneEvent(value.trim()));
                    },
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
