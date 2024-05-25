import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/office/widgets/office_deposit_form_field.dart';
import 'package:maktab/presentation/office/widgets/office_price_form_field.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/phone_text_field.dart';

class OfficeUnitPricesStep extends StatefulWidget {
  const OfficeUnitPricesStep({super.key});

  @override
  State<OfficeUnitPricesStep> createState() => _OfficeUnitPricesStepState();
}

class _OfficeUnitPricesStepState extends State<OfficeUnitPricesStep> {
  late TextEditingController _hourlyUnitPriceController;
  late TextEditingController _dailyUnitPriceController;
  late TextEditingController _monthlyUnitPriceController;
  late TextEditingController _yearlyUnitPriceController;
  late TextEditingController _viewerNameController;
  late TextEditingController _viewerPhoneController;
  final GlobalKey<FormState> _unitPricesFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    OfficeState state = context.read<OfficeBloc>().state;
    _hourlyUnitPriceController = TextEditingController(
        text: state.selectedUnitPrices[UnitPriceOptions.hourly] != null
            ? state.selectedUnitPrices[UnitPriceOptions.hourly].toString()
            : '');
    _dailyUnitPriceController = TextEditingController(
        text: state.selectedUnitPrices[UnitPriceOptions.daily] != null
            ? state.selectedUnitPrices[UnitPriceOptions.daily].toString()
            : '');
    _monthlyUnitPriceController = TextEditingController(
        text: state.selectedUnitPrices[UnitPriceOptions.monthly] != null
            ? state.selectedUnitPrices[UnitPriceOptions.monthly].toString()
            : '');
    _yearlyUnitPriceController = TextEditingController(
        text: state.selectedUnitPrices[UnitPriceOptions.yearly] != null
            ? state.selectedUnitPrices[UnitPriceOptions.yearly].toString()
            : '');
    _viewerNameController = TextEditingController(text: state.viewerName);
    _viewerPhoneController = TextEditingController(text: state.viewerPhone);
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
          const BodyText(
              text:
                  'اكتب أسعار عقارك الأساسية تقدر تعدل الأسعار ونضيف عروض وخصومات لاحقا'),
          SizedBox(height: 20.v),
          Form(
            key: _unitPricesFormKey,
            child: Column(
              children: [
                OfficePriceFormField(
                  title: 'ساعة',
                  option: UnitPriceOptions.hourly,
                  controller: _hourlyUnitPriceController,
                ),
                SizedBox(height: 10.v),
                OfficePriceFormField(
                  title: 'يومي',
                  option: UnitPriceOptions.daily,
                  controller: _dailyUnitPriceController,
                ),
                SizedBox(height: 10.v),
                OfficePriceFormField(
                  title: 'شهري',
                  option: UnitPriceOptions.monthly,
                  controller: _monthlyUnitPriceController,
                ),
                SizedBox(height: 10.v),
                OfficePriceFormField(
                  title: 'سنوي',
                  option: UnitPriceOptions.yearly,
                  controller: _yearlyUnitPriceController,
                ),
                SizedBox(height: 20.v),
                const Divider(color: AppColors.softAsh),
                SizedBox(height: 20.v),
                BlocBuilder<OfficeBloc, OfficeState>(
                  builder: (context, state) {
                    return state.selectedUnitPriceOptions
                            .contains(UnitPriceOptions.yearly)
                        ? Column(
                            children: [
                              const OfficeDepositFormField(),
                              SizedBox(height: 20.v),
                            ],
                          ).animate().fade()
                        : const SizedBox.shrink();
                  },
                ),
                MaktabTextFormField(
                  controller: _viewerNameController,
                  title: 'اسم المعاين',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء ادخال اسم المعاين';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context
                        .read<OfficeBloc>()
                        .add(SetViewerNameEvent(value!.trim()));
                  },
                ),
                SizedBox(height: 20.v),
                PhoneTextfield(
                  controller: _viewerPhoneController,
                  onChanged: (value) {
                    context
                        .read<OfficeBloc>()
                        .add(SetViewerPhoneEvent(value!.trim()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
