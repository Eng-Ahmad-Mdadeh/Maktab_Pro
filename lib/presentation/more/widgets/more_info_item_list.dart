import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/more/widgets/more_info_item.dart';

class MoreInfoItemList extends StatelessWidget {
  const MoreInfoItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.v,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          MoreInfoItem(
            title: 'المبيعات',
            icon: FontAwesomeIcons.coins,
            onTap: () {},
          ),
          SizedBox(width: 15.h),
          MoreInfoItem(
            title: 'الطلبات',
            icon: FontAwesomeIcons.fileInvoiceDollar,
            onTap: () {},
          ),
          SizedBox(width: 15.h),
          MoreInfoItem(
            title: 'الوحدات',
            icon: FontAwesomeIcons.house,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
