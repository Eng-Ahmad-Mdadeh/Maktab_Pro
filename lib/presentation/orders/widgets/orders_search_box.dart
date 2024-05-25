import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/orders/widgets/order_selection_button.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OrdersSearchBox extends StatelessWidget {
  OrdersSearchBox({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.softAsh)),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          children: [
            const SectionTitle(title: "البحث"),
            SizedBox(width: 10.h),
            Icon(
              Icons.info,
              color: AppColors.lightCyan,
              size: 30.adaptSize,
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.v),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaktabTextFormField(
                    controller: _searchController,
                    contentPadding: EdgeInsets.zero,
                    hintText: 'البحث باسم العميل أو رقم الطلب',
                    prefix:
                        const Icon(Icons.search, color: AppColors.slateGray),
                  ),
                  SizedBox(height: 15.v),
                  const SectionTitle(title: 'حالة الحجز'),
                  SizedBox(height: 10.v),
                  SizedBox(
                    height: 50.v,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        const OrderSelectionButton(
                          title: 'الكل',
                          isSelected: true,
                        ),
                        SizedBox(width: 7.h),
                        const OrderSelectionButton(
                          title: 'مقبول',
                          isSelected: true,
                        ),
                        SizedBox(width: 7.h),
                        const OrderSelectionButton(
                          title: 'انتظار',
                          isSelected: false,
                        ),
                        SizedBox(width: 7.h),
                        const OrderSelectionButton(
                          title: 'ملغي',
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
