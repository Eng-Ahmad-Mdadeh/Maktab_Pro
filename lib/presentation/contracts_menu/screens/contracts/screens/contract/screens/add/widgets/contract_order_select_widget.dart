import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import '../../../../../../../../../data/models/order/order_model.dart';
import '../../../../../../../../widgets/maktab_drop_down_form_field.dart';
import '../../../../../../../../widgets/body_text.dart';

class ContractOrderSelectWidget extends StatelessWidget {
  final String title;
  final String? initialValue;
  final List<OrderModel> items;
  final void Function(OrderModel?) onChanged;

  final bool disabled;
  final bool req;

  const ContractOrderSelectWidget({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.initialValue,
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
          MaktabDropDownFormField(
            items: items.where((e) => e.tenant?.username != null).map((e) => e.tenant!.username!).toList(),
            idItems: items.where((e) => e.id != null).map((e) => e.id!.toString()).toList(),
            onChanged: disabled ? null : (id) => onChanged(items.firstWhereOrNull((e) => e.id.toString() == id)),
            initialValue: initialValue,
            validator: req ? (value){
              if((value??'').isEmpty){
                return 'هذا القسم اجباري';
              }
              return null;
            } : null,
          ),
        ],
      ),
    );
  }
}