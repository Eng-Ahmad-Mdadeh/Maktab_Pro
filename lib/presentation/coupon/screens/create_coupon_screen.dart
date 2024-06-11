import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/coupon/coupon_model.dart';
import 'package:maktab/domain/coupon/coupon_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

import '../../../core/classes/numerical_range_formatter.dart';
import '../../../core/helpers/date_formatter_helper.dart';
import '../../../data/models/office/office_model.dart';
import '../../../domain/offices/offices_cubit.dart';
import '../../offer/widgets/price_select_box.dart';
import '../../widgets/maktab_snack_bar.dart';

class CreateCouponScreen extends StatefulWidget {
  const CreateCouponScreen({super.key, this.coupon, this.unit});

  final Coupon? coupon;
  final Office? unit;

  @override
  State<CreateCouponScreen> createState() => _CreateCouponScreenState();
}

class _CreateCouponScreenState extends State<CreateCouponScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  DateTimeRange? range;

  final List<Map<String, dynamic>> disCountTypes = [
    {'title': 'سعر ثابت', 'type': DiscountTypes.price},
    {'title': 'نسبة مئوية', 'type': DiscountTypes.percentage},
  ];
  late TextEditingController couponNameController;
  late TextEditingController couponCodeController;
  late TextEditingController useTimesController;

  late TextEditingController couponDepositController;
  late TextEditingController couponDateRangeController;

  late List<Office> units;

  @override
  void initState() {
    CouponState offerState = context.read<CouponBloc>().state;
    units = List.from(context.read<OfficesCubit>().state.coupons.expand(
          (office) => office.units,
        ));
    couponNameController = TextEditingController(text: widget.coupon?.name);
    couponCodeController = TextEditingController(text: widget.coupon?.code);
    useTimesController = TextEditingController(text: widget.coupon?.numberUsed.toString());
    couponDepositController = TextEditingController(text: widget.coupon?.discount.toString());
    couponDateRangeController = TextEditingController(
        text: widget.coupon != null
            ? '${DateFormatterHelper.getFormated(widget.coupon!.startDate)} - ${DateFormatterHelper.getFormated(widget.coupon!.endDate)}'
            : '${DateFormatterHelper.getFormated(offerState.startDate)} - ${DateFormatterHelper.getFormated(offerState.endDate)}');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _couponBloc = BlocProvider.of<CouponBloc>(context);
  }

  late CouponBloc _couponBloc;

  @override
  void dispose() {
    _couponBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponBloc, CouponState>(
      listener: (context, state) {
        if (state.couponApiCallState == OfferApiCallState.loading) {
          // LoadingDialog.show(context);
        } else if (state.couponApiCallState == OfferApiCallState.success) {
          MaktabSnackbar.showSuccess(context, state.message);
          //LoadingDialog.hide(context);
          context.pop();

          context.read<OfficesCubit>().getAllCoupons(isUpdate: true);
          if (widget.coupon != null) {
            context.read<OfficesCubit>().getOfficeById(widget.unit!.id, isUpdate: true);
          }
        } else if (state.couponApiCallState == OfferApiCallState.failure) {
          // LoadingDialog.hide(context);
          MaktabSnackbar.showError(context, state.message);
        }
      },
      builder: (context, state) => state.isInitialized
          ? Scaffold(
              appBar: MaktabAppBar(title: widget.coupon != null ? 'تعديل كود الخصم' : 'إنشاء كود خصم'),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MaktabTextFormField(
                                controller: couponNameController,
                                title: 'الاسم:',
                                hintText: 'اكتب اسم الكود',
                                textInputType: TextInputType.name,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'الرجاء ادخال اسم الكود';
                                  } else if (value.trim().length < 4) {
                                    return 'الاسم يجب على الاقل ان يكون مؤلف من 4 أحرف';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  context.read<CouponBloc>().add(SetCouponNameEvent(value!));
                                },
                              ),
                              SizedBox(height: 20.v),
                              MaktabTextFormField(
                                controller: couponCodeController,
                                title: 'الكود:',
                                hintText: 'اكتب الكود',
                                textInputType: TextInputType.name,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'الرجاء ادخال الكود';
                                  } else if (value.trim().length < 4) {
                                    return 'الكود يجب على الاقل ان يكون مؤلف من 4 أحرف';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  context.read<CouponBloc>().add(SetCouponCodeEvent(value!));
                                },
                              ),
                              SizedBox(height: 20.v),
                              MaktabTextFormField(
                                controller: useTimesController,
                                title: 'مرات الاستخدام:',
                                hintText: '1',
                                textInputType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'الرجاء اختيار قيمة';
                                  }
                                  if (int.parse(value) > 100 || int.parse(value) < 1) {
                                    return 'الرجاء اختيار قيمة بين 1 و 100';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  context.read<CouponBloc>().add(SetCouponUseTimesEvent(int.parse(value!)));
                                },
                              ),
                              SizedBox(height: 20.v),
                              const SectionTitle(title: 'الوحدات التي تريد أن يطبق عليها العرض:'),
                              SizedBox(height: 5.v),
                              DropdownButtonFormField2(
                                value: context.read<CouponBloc>().state.unit?.id,
                                isDense: true,
                                isExpanded: true,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColors.slateGray,
                                    size: 25.adaptSize,
                                  ),
                                ),
                                items: units
                                    .map(
                                      (unit) => DropdownMenuItem<int>(
                                        value: unit.id,
                                        child: SizedBox(
                                          width: SizeHelper.width,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: SectionTitle(
                                              title: unit.title ?? '',
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'الرجاء اختيار الوحدة';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  context.read<CouponBloc>().add(
                                      SelectUnitEvent(units.firstWhereOrNull((unit) => unit.id == value)!));
                                },
                              ),
                              SizedBox(height: 20.v),
                              const SectionTitle(title: 'قيمة الخصم:'),
                              SizedBox(height: 5.v),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: DropdownButtonFormField2(
                                      value: state.discountType,
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
                                      items: disCountTypes.map((format) {
                                        return DropdownMenuItem<DiscountTypes>(
                                          value: format['type'],
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: BodyText(
                                              text: format['title'],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      decoration: (const InputDecoration())
                                          .applyDefaults(Theme.of(context).inputDecorationTheme),
                                      onChanged: (value) {
                                        couponDepositController.clear();
                                        context.read<CouponBloc>().add(SelectDiscountTypeEvent(value!));
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.h),
                                  Expanded(
                                    flex: 4,
                                    child: MaktabTextFormField(
                                      controller: couponDepositController,
                                      hintText: 'قيمة الخصم',
                                      textInputType: TextInputType.number,
                                      errorStyle: TextStyle(height: 0.v),
                                      suffix: SizedBox(
                                        width: 50.h,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: BodyText(
                                              text: state.discountType.name == 'percentage' ? '%' : 'ريال'),
                                        ),
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        state.discountType == DiscountTypes.percentage
                                            ? NumericalRangeFormatter(min: 0, max: 100)
                                            : NumericalRangeFormatter(min: 0, max: double.infinity)
                                      ],
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          context.read<CouponBloc>().add(const ChangeDiscountAmountEvent(''));
                                          return '';
                                        } else {
                                          context
                                              .read<CouponBloc>()
                                              .add(ChangeDiscountAmountEvent(value.trim()));
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.v),
                              const SectionTitle(title: 'تاريخ تطبيق الخصم:'),
                              SizedBox(height: 5.v),
                              const BodyText(text: 'الخصم سيطبق على تاريخ الوصول وليس تاريخ الحجز'),
                              SizedBox(height: 5.v),
                              MaktabTextFormField(
                                controller: couponDateRangeController,
                                readOnly: true,
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (state.startDate == state.endDate) {
                                    return 'الرجاء ادخال تاريخ صحيح';
                                  }
                                  if (!state.isValidOfferDateRange) {
                                    return 'يوجد حجز مسبق من تاريخ ${DateFormatterHelper.getFormated(context.read<CouponBloc>().state.selectedOffer!.startDate)} الى ${DateFormatterHelper.getFormated(context.read<CouponBloc>().state.selectedOffer!.endDate)}';
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  await showDateRangePicker(
                                    context: context,
                                    locale: const Locale('ar'),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: AppColors.lightCyan,
                                            onPrimary: AppColors.white,
                                            surface: AppColors.white,
                                            onSurface: AppColors.lightBlack,
                                            primaryContainer: AppColors.lightCyan,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  ).then((range) {
                                    if (range != null) {
                                      context.read<CouponBloc>().add(SelectOfferDateRangeEvent(range));
                                      couponDateRangeController.value = TextEditingValue(
                                          text:
                                              '${DateFormatterHelper.getFormated(range.start)} - ${DateFormatterHelper.getFormated(range.end)}');
                                    }
                                    return range;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.v),
                    BlocBuilder<CouponBloc, CouponState>(
                      builder: (context, state) {
                        return state.unit != null
                            ? Column(
                                children: [
                                  const SectionTitle(title: 'أنواع الاسعار التي يطبق الخصم عليها:'),
                                  SizedBox(height: 20.v),
                                  SizedBox(
                                    height: 60.v,
                                    child: BlocBuilder<CouponBloc, CouponState>(
                                      builder: (context, state) {
                                        return ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            if (state.unit != null && state.unit!.prices.isNotEmpty)
                                              PriceSelectBox(
                                                title: 'الكل',
                                                isSelected: state.prices.length == state.unit!.prices.length,
                                                onTap: () {
                                                  context.read<CouponBloc>().add(SelectAllUnitPricesEvent());
                                                },
                                              ),
                                            if (state.unit != null &&
                                                state.unit!.prices
                                                        .firstWhereOrNull((price) => price.typeResId == 4) !=
                                                    null)
                                              PriceSelectBox(
                                                title: 'سنوي',
                                                isSelected: state.priceTypes.contains(4),
                                                onTap: () {
                                                  context
                                                      .read<CouponBloc>()
                                                      .add(const SelectUnitPriceEvent(4));
                                                },
                                              ),
                                            if (state.unit != null &&
                                                state.unit!.prices
                                                        .firstWhereOrNull((price) => price.typeResId == 3) !=
                                                    null)
                                              PriceSelectBox(
                                                title: 'شهري',
                                                isSelected: state.priceTypes.contains(3),
                                                onTap: () {
                                                  context
                                                      .read<CouponBloc>()
                                                      .add(const SelectUnitPriceEvent(3));
                                                },
                                              ),
                                            if (state.unit != null &&
                                                state.unit!.prices
                                                        .firstWhereOrNull((price) => price.typeResId == 2) !=
                                                    null)
                                              PriceSelectBox(
                                                title: 'يومي',
                                                isSelected: state.priceTypes.contains(2),
                                                onTap: () {
                                                  context
                                                      .read<CouponBloc>()
                                                      .add(const SelectUnitPriceEvent(2));
                                                },
                                              ),
                                            if (state.unit != null &&
                                                state.unit!.prices
                                                        .firstWhereOrNull((price) => price.typeResId == 1) !=
                                                    null)
                                              PriceSelectBox(
                                                title: 'ساعة',
                                                isSelected: state.priceTypes.contains(1),
                                                onTap: () {
                                                  context
                                                      .read<CouponBloc>()
                                                      .add(const SelectUnitPriceEvent(1));
                                                },
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ).animate().fade(),
                                ],
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 10.v),
                    BlocBuilder<CouponBloc, CouponState>(
                      builder: (context, state) {
                        return state.pricesCount == 0
                            ? const BodyText(
                                text: 'يرجى اختيار سعر',
                                textColor: AppColors.cherryRed,
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                      child: MaktabButton(
                        height: 70.v,
                        text: widget.coupon != null ? 'تحديث' : 'إضافة',
                        isLoading: state.couponApiCallState == OfferApiCallState.loading,
                        isBordered: true,
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              state.pricesCount > 0 &&
                              state.isValidOfferDateRange) {
                            _formKey.currentState!.save();
                            context.read<CouponBloc>().add(
                                  CreateCouponEvent(
                                    isUpdate: widget.coupon != null ? true : false,
                                    couponId: widget.coupon?.id,
                                  ),
                                );
                          } else if (state.pricesCount == -1) {
                            context.read<CouponBloc>().add(ClearPriceCountEvent());
                          } else if (!state.isValidOfferDateRange) {
                            context.read<CouponBloc>().add(SelectOfferDateRangeEvent(range!));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
