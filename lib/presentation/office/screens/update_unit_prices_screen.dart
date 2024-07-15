import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_price_form_field.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';

class UpdateUnitPricesScreen extends StatefulWidget {
  const UpdateUnitPricesScreen({super.key, required this.unit});

  final Office unit;

  @override
  State<UpdateUnitPricesScreen> createState() => _UpdateUnitPricesScreenState();
}

class _UpdateUnitPricesScreenState extends State<UpdateUnitPricesScreen> {
  late TextEditingController _hourlyUnitPriceController;
  late TextEditingController _dailyUnitPriceController;
  late TextEditingController _monthlyUnitPriceController;
  late TextEditingController _yearlyUnitPriceController;
  final GlobalKey<FormState> _unitPricesFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _hourlyUnitPriceController = TextEditingController(
        text: widget.unit.prices
                    .firstWhereOrNull((price) => price.typeResId == 1) !=
                null
            ? widget.unit.prices
                .firstWhereOrNull((price) => price.typeResId == 1)!
                .price
                .toString()
            : '');
    _dailyUnitPriceController = TextEditingController(
        text: widget.unit.prices
                    .firstWhereOrNull((price) => price.typeResId == 2) !=
                null
            ? widget.unit.prices
                .firstWhereOrNull((price) => price.typeResId == 2)!
                .price
                .toString()
            : '');
    _monthlyUnitPriceController = TextEditingController(
        text: widget.unit.prices
                    .firstWhereOrNull((price) => price.typeResId == 3) !=
                null
            ? widget.unit.prices
                .firstWhereOrNull((price) => price.typeResId == 3)!
                .price
                .toString()
            : '');
    _yearlyUnitPriceController = TextEditingController(
        text: widget.unit.prices
                    .firstWhereOrNull((price) => price.typeResId == 4) !=
                null
            ? widget.unit.prices
                .firstWhereOrNull((price) => price.typeResId == 4)!
                .price
                .toString()
            : '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<UnitBloc>()
        ..add(InitialUnitEvent(
            widget.unit, null, context.read<OfficesCubit>().state.searchData)),
      child: BlocConsumer<UnitBloc, UnitState>(
        listener: (context, state) {
          if (state.unitApiCallState == UnitApiCallState.noCall) {
            context.pop();
          } else if (state.unitApiCallState == UnitApiCallState.success) {
            context.read<OfficesCubit>().getAllPrices(isUpdate: true);
            context.pop();
            MaktabSnackbar.showSuccess(context, 'تم تعديل أسعار الوحدة بنجاح');
          } else if (state.unitApiCallState == UnitApiCallState.failure) {
            MaktabSnackbar.showError(context, 'فشل تعديل الأسعار');
          }
        },
        builder: (context, state) => state.isInitialized
            ? Scaffold(
                appBar: const MaktabAppBar(title: 'تعديل أسعار الوحدة'),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
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
                          child: Column(children: [
                            UnitPriceFormField(
                              title: 'ساعة',
                              option: UnitPriceOptions.hourly,
                              controller: _hourlyUnitPriceController,
                            ),
                            SizedBox(height: 10.v),
                            UnitPriceFormField(
                              title: 'يومي',
                              option: UnitPriceOptions.daily,
                              controller: _dailyUnitPriceController,
                            ),
                            SizedBox(height: 10.v),
                            UnitPriceFormField(
                              title: 'شهري',
                              option: UnitPriceOptions.monthly,
                              controller: _monthlyUnitPriceController,
                            ),
                            SizedBox(height: 10.v),
                            UnitPriceFormField(
                              title: 'سنوي',
                              option: UnitPriceOptions.yearly,
                              controller: _yearlyUnitPriceController,
                            ),
                          ]),
                        ),
                        SizedBox(height: 20.v),
                        Container(
                          height: 100.v,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 20.v),
                          child: MaktabButton(
                            text: 'حفظ التغييرات',
                            isLoading: state.unitApiCallState ==
                                UnitApiCallState.loading,
                            backgroundColor: AppColors.mintTeal,
                            onPressed: () {
                              context
                                  .read<UnitBloc>()
                                  .add(UpdateUnitPricesEvent());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
