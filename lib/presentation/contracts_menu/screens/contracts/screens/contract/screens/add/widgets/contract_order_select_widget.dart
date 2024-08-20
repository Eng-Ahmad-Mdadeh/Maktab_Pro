import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/extension/date_time_extension.dart';

import '../../../../../../../../../data/models/order/order_model.dart';
import '../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../widgets/body_text.dart';

class ContractOrderSelectWidget extends StatelessWidget {
  final String title;
  final OrderModel? value;
  final List<OrderModel> items;
  final void Function(OrderModel?) onChanged;

  final bool disabled;
  final bool req;

  const ContractOrderSelectWidget({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.value,
    this.req = true,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(
            text: title,
            fontSize: 15.0,
          ),
          DropdownButtonFormField2<OrderModel>(
            selectedItemBuilder: (context) => items.map((e) {
              return Row(
                children: [
                  BodyText(text: value?.office?.title ?? ''),
                  SizedBox(width: 10.0.h),
                  Row(
                    children: [
                      BodyText(text: 'من: ${value?.startDate?.shorDate()}', textColor: AppColors.black.withOpacity(.7)),
                      BodyText(text: ' - ', textColor: AppColors.black.withOpacity(.5)),
                      BodyText(text: 'الى: ${value?.endDate?.shorDate()}', textColor: AppColors.black.withOpacity(.7)),
                    ],
                  ),
                ],
              );
            }).toList(),
            value: value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            isExpanded: true,
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
            items: items
                .map(
                  (item) => DropdownMenuItem<OrderModel>(
                    value: item,
                    child: SizedBox(
                      height: 62,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              BodyText(text: item.office?.title ?? ''),
                              const BodyText(text: ' - '),
                              BodyText(text: item.tenant?.username ?? ''),
                            ],
                          ),
                          Row(
                            children: [
                              BodyText(
                                  text: 'من: ${item.startDate?.dayFormatWithLocale('ar')}', textColor: AppColors.black.withOpacity(.5)),
                              BodyText(text: ' - ', textColor: AppColors.black.withOpacity(.5)),
                              BodyText(text: 'الى: ${item.endDate?.dayFormatWithLocale('ar')}', textColor: AppColors.black.withOpacity(.5)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: req
                ? (value) {
                    if (value == null) {
                      return 'هذا القسم اجباري';
                    }
                    return null;
                  }
                : null,
            onChanged: (v) => onChanged(v),
          ),
        ],
      ),
    );
  }
}
