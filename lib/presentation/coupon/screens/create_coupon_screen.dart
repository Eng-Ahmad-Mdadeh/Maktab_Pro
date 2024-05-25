import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/coupon/coupon_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class CreateCouponScreen extends StatefulWidget {
  const CreateCouponScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'إنشاء كود خصم'),
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
                        //controller: offerNameController,
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
                          // context
                          //     .read<OfferBloc>()
                          //     .add(SetOfferNameEvent(value!));
                        },
                      ),
                      SizedBox(height: 20.v),
                      MaktabTextFormField(
                        //controller: offerNameController,
                        title: 'الكود:',
                        hintText: 'اكتب الكود',
                        textInputType: TextInputType.name,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'الرجاء ادخال الكود';
                          } else if (value.trim().length < 4) {
                            return 'الاسم يجب على الاقل ان يكون مؤلف من 4 أحرف';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // context
                          //     .read<OfferBloc>()
                          //     .add(SetOfferNameEvent(value!));
                        },
                      ),
                      SizedBox(height: 20.v),
                      MaktabTextFormField(
                        //controller: offerNameController,
                        title: 'مرات الاستخدام:',
                        hintText: '1000',
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        // validator: (value) {
                        //   if (value!.trim().isEmpty) {
                        //     return 'الرجاء ادخال الكود';
                        //   } else if (value.trim().length < 4) {
                        //     return 'الاسم يجب على الاقل ان يكون مؤلف من 4 أحرف';
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          // context
                          //     .read<OfferBloc>()
                          //     .add(SetOfferNameEvent(value!));
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
                              value: DiscountTypes.price,
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
                                    child: Text(
                                      format['title'],
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                );
                              }).toList(),
                              decoration: (const InputDecoration())
                                  .applyDefaults(
                                      Theme.of(context).inputDecorationTheme),
                              onChanged: (value) {
                                // offerDepositController.clear();
                                // context
                                //     .read<OfferBloc>()
                                //     .add(SelectDiscountTypeEvent(value!));
                              },
                            ),
                          ),
                          SizedBox(width: 10.h),
                          Expanded(
                            flex: 4,
                            child: MaktabTextFormField(
                              //controller: offerDepositController,
                              hintText: 'قيمة الخصم',
                              textInputType: TextInputType.number,
                              errorStyle: TextStyle(height: 0.v),
                              suffix: SizedBox(
                                width: 50.h,
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: BodyText(text: 'ريال'),
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                // state.discountType ==
                                //         DiscountTypes.percentage
                                //     ? NumericalRangeFormatter(
                                //         min: 0, max: 100)
                                //     : NumericalRangeFormatter(
                                //         min: 0, max: double.infinity)
                              ],
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  // context.read<OfferBloc>().add(
                                  //     const ChangeDiscountAmountEvent(''));
                                  return '';
                                } else {
                                  // context.read<OfferBloc>().add(
                                  //     ChangeDiscountAmountEvent(
                                  //         value.trim()));
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.v),
                      const SectionTitle(title: 'تاريخ تطبيق العرض:'),
                      SizedBox(height: 5.v),
                      const BodyText(
                          text:
                              'العرض سيطبق على تاريخ الوصول وليس تاريخ الحجز'),
                      SizedBox(height: 5.v),
                      MaktabTextFormField(
                        //controller: offerDateRangeController,
                        readOnly: true,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          // if (state.startDate == state.endDate) {
                          //   return 'الرجاء ادخال تاريخ صحيح';
                          // }
                          // if (!state.isValidOfferDateRange) {
                          //   return 'يوجد حجز مسبق من تاريخ ${DateFormatterHelper.getFormated(context.read<OfferBloc>().state.selectedOffer!.startDate)} الى ${DateFormatterHelper.getFormated(context.read<OfferBloc>().state.selectedOffer!.endDate)}';
                          // }
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
                            // context
                            //     .read<OfferBloc>()
                            //     .add(SelectOfferDateRangeEvent(range!));
                            // offerDateRangeController.value = TextEditingValue(
                            //     text:
                            //         '${DateFormatterHelper.getFormated(range!.start)} - ${DateFormatterHelper.getFormated(range!.end)}');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                child: MaktabButton(
                  height: 70.v,
                  text: 'إضافة',
                  isBordered: true,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
