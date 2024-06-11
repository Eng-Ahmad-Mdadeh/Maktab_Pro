// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/classes/numerical_range_formatter.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/offer/offer_model.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/offer/offer_bloc.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/offer/widgets/price_select_box.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({super.key, this.offer, this.unit});

  final Offer? offer;
  final Office? unit;

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  late TextEditingController offerNameController;
  late TextEditingController offerDepositController;
  late TextEditingController offerDateRangeController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  late List<Office> units;
  DateTimeRange? range;

  final List<Map<String, dynamic>> disCountTypes = [
    {'title': 'سعر ثابت', 'type': DiscountTypes.price},
    {'title': 'نسبة مئوية', 'type': DiscountTypes.percentage},
  ];

  @override
  void initState() {
    OfferState offerState = context.read<OfferBloc>().state;
    units = List.from(context.read<OfficesCubit>().state.offers.expand(
          (office) => office.units,
        ));
    offerNameController = TextEditingController(text: widget.offer?.name);
    offerDepositController = TextEditingController(text: widget.offer?.discount.toString());
    offerDateRangeController = TextEditingController(
        text: widget.offer != null
            ? '${DateFormatterHelper.getFormated(widget.offer!.startDate)} - ${DateFormatterHelper.getFormated(widget.offer!.endDate)}'
            : '${DateFormatterHelper.getFormated(offerState.startDate)} - ${DateFormatterHelper.getFormated(offerState.endDate)}');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _offerBloc = BlocProvider.of<OfferBloc>(context);
  }

  late OfferBloc _offerBloc;

  @override
  void dispose() {
    _offerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferBloc, OfferState>(
      listener: (context, state) {
        if (state.offerApiCallState == OfferApiCallState.success) {
          context.read<OfficesCubit>().getAllOffers(isUpdate: true);
          context.pop();
          if (widget.offer != null) {
            context.read<OfficesCubit>().getOfficeById(widget.unit!.id, isUpdate: true);
          }
        } else if (state.offerApiCallState == OfferApiCallState.failure) {
          MaktabSnackbar.showError(context, 'حدث خطأ ${state.name}');
        }
      },
      builder: (context, state) => state.isInitialized
          ? Scaffold(
              appBar: MaktabAppBar(title: widget.offer != null ? 'تعديل العرض' : 'إنشاء عرض'),
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
                                controller: offerNameController,
                                title: 'اسم العرض:',
                                hintText: 'اكتب اسم العرض',
                                textInputType: TextInputType.name,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'الرجاء ادخال اسم العرض';
                                  } else if (value.trim().length < 4) {
                                    return 'الاسم يجب على الاقل ان يكون مؤلف من 4 أحرف';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  context.read<OfferBloc>().add(SetOfferNameEvent(value!));
                                },
                              ),
                              SizedBox(height: 20.v),
                              const SectionTitle(title: 'الوحدات التي تريد أن يطبق عليها العرض:'),
                              SizedBox(height: 5.v),
                              DropdownButtonFormField2(
                                value: context.read<OfferBloc>().state.unit?.id,
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
                                              title:
                                              unit.title ?? '',
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
                                  context.read<OfferBloc>().add(
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
                                        offerDepositController.clear();
                                        context.read<OfferBloc>().add(SelectDiscountTypeEvent(value!));
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.h),
                                  Expanded(
                                    flex: 4,
                                    child: BlocBuilder<OfferBloc, OfferState>(
                                      builder: (context, state) {
                                        return MaktabTextFormField(
                                          controller: offerDepositController,
                                          hintText: state.discountType == DiscountTypes.percentage
                                              ? 'نسبة الخصم'
                                              : 'قيمة الخصم',
                                          textInputType: TextInputType.number,
                                          errorStyle: TextStyle(height: 0.v),
                                          suffix: SizedBox(
                                            width: 50.h,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: BodyText(
                                                  text: state.discountType == DiscountTypes.percentage
                                                      ? '%'
                                                      : 'ريال'),
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
                                              context
                                                  .read<OfferBloc>()
                                                  .add(const ChangeDiscountAmountEvent(''));
                                              return '';
                                            } else {
                                              context
                                                  .read<OfferBloc>()
                                                  .add(ChangeDiscountAmountEvent(value.trim()));
                                            }
                                            return null;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.v),
                              BlocBuilder<OfferBloc, OfferState>(
                                builder: (context, state) {
                                  return state.discountAmount == -1
                                      ? const BodyText(
                                    text:  'يجب ادخال قيمة الخصم',textColor: AppColors.cherryRed,

                                        )
                                      : state.prices.values.isNotEmpty
                                          ? state.discountType == DiscountTypes.price &&
                                                  state.prices.values.min < state.discountAmount
                                              ? BodyText(
                                                  text:
                                                      'يجب أن يكون الخصم أقل من  ${state.prices.values.min}',
                                                  textColor: AppColors.cherryRed,
                                                )
                                              : const SizedBox.shrink()
                                          : const SizedBox.shrink();
                                },
                              ),
                              SizedBox(height: 20.v),
                              const SectionTitle(title: 'تاريخ تطبيق العرض:'),
                              SizedBox(height: 5.v),
                              const BodyText(text: 'العرض سيطبق على تاريخ الوصول وليس تاريخ الحجز'),
                              SizedBox(height: 5.v),
                              BlocBuilder<OfferBloc, OfferState>(
                                builder: (context, state) {
                                  return MaktabTextFormField(
                                    controller: offerDateRangeController,
                                    readOnly: true,
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      if (state.startDate == state.endDate) {
                                        return 'الرجاء ادخال تاريخ صحيح';
                                      }
                                      if (!state.isValidOfferDateRange) {
                                        return 'يوجد حجز مسبق من تاريخ ${DateFormatterHelper.getFormated(context.read<OfferBloc>().state.selectedOffer!.startDate)} الى ${DateFormatterHelper.getFormated(context.read<OfferBloc>().state.selectedOffer!.endDate)}';
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      range = await showDateRangePicker(
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
                                      );
                                      if (range != null) {
                                        context.read<OfferBloc>().add(SelectOfferDateRangeEvent(range!));
                                        offerDateRangeController.value = TextEditingValue(
                                            text:
                                                '${DateFormatterHelper.getFormated(range!.start)} - ${DateFormatterHelper.getFormated(range!.end)}');
                                      }
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 20.v),
                              BlocBuilder<OfferBloc, OfferState>(
                                builder: (context, state) {
                                  return state.unit != null
                                      ? Column(
                                          children: [
                                            const SectionTitle(title: 'أنواع الاسعار التي يطبق العرض عليها:'),
                                            SizedBox(height: 20.v),
                                            SizedBox(
                                              height: 60.v,
                                              child: BlocBuilder<OfferBloc, OfferState>(
                                                builder: (context, state) {
                                                  return ListView(
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    children: [
                                                      if (state.unit != null && state.unit!.prices.isNotEmpty)
                                                        PriceSelectBox(
                                                          title: 'الكل',
                                                          isSelected: state.prices.length ==
                                                              state.unit!.prices.length,
                                                          onTap: () {
                                                            context
                                                                .read<OfferBloc>()
                                                                .add(SelectAllUnitPricesEvent());
                                                          },
                                                        ),
                                                      if (state.unit != null &&
                                                          state.unit!.prices.firstWhereOrNull(
                                                                  (price) => price.typeResId == 4) !=
                                                              null)
                                                        PriceSelectBox(
                                                          title: 'سنوي',
                                                          isSelected: state.priceTypes.contains(4),
                                                          onTap: () {
                                                            context
                                                                .read<OfferBloc>()
                                                                .add(const SelectUnitPriceEvent(4));
                                                          },
                                                        ),
                                                      if (state.unit != null &&
                                                          state.unit!.prices.firstWhereOrNull(
                                                                  (price) => price.typeResId == 3) !=
                                                              null)
                                                        PriceSelectBox(
                                                          title: 'شهري',
                                                          isSelected: state.priceTypes.contains(3),
                                                          onTap: () {
                                                            context
                                                                .read<OfferBloc>()
                                                                .add(const SelectUnitPriceEvent(3));
                                                          },
                                                        ),
                                                      if (state.unit != null &&
                                                          state.unit!.prices.firstWhereOrNull(
                                                                  (price) => price.typeResId == 2) !=
                                                              null)
                                                        PriceSelectBox(
                                                          title: 'يومي',
                                                          isSelected: state.priceTypes.contains(2),
                                                          onTap: () {
                                                            context
                                                                .read<OfferBloc>()
                                                                .add(const SelectUnitPriceEvent(2));
                                                          },
                                                        ),
                                                      if (state.unit != null &&
                                                          state.unit!.prices.firstWhereOrNull(
                                                                  (price) => price.typeResId == 1) !=
                                                              null)
                                                        PriceSelectBox(
                                                          title: 'ساعة',
                                                          isSelected: state.priceTypes.contains(1),
                                                          onTap: () {
                                                            context
                                                                .read<OfferBloc>()
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
                              BlocBuilder<OfferBloc, OfferState>(
                                builder: (context, state) {
                                  return state.pricesCount == 0
                                      ? const BodyText(
                                    text:
                                    'يرجى اختيار سعر',textColor: AppColors.cherryRed,

                                        )
                                      : const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                      child: BlocBuilder<OfferBloc, OfferState>(
                        builder: (context, state) {
                          return MaktabButton(
                            height: 70.v,
                            text: widget.offer != null ? 'تحديث' : 'إضافة',
                            isBordered: true,
                            isLoading: state.offerApiCallState == OfferApiCallState.loading,
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  state.pricesCount > 0 &&
                                  state.isValidOfferDateRange) {
                                _formKey.currentState!.save();
                                context.read<OfferBloc>().add(CreateOfferEvent(
                                    isUpdate: widget.offer != null ? true : false,
                                    offerId: widget.offer?.id));
                              } else if (state.pricesCount == -1) {
                                context.read<OfferBloc>().add(ClearPriceCountEvent());
                              } else if (!state.isValidOfferDateRange) {
                                context.read<OfferBloc>().add(SelectOfferDateRangeEvent(range!));
                              }
                            },
                          );
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
