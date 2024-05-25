import 'package:flutter/material.dart';
import 'package:maktab/presentation/receiving_method/widgets/stc_terms_item.dart';

class StcTermsList extends StatelessWidget {
  const StcTermsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        StcTermsItem(
          title: '1',
          text: 'حمل تطبيق STC Pay من هنا',
        ),
        StcTermsItem(
          title: '2',
          text:
              'سحل تسجيل جديد باستخدام رقم الجوال الذي ترغب بأن نحول له المبالغ المالية',
        ),
        StcTermsItem(
          title: '3',
          text:
              'فعل من هنا رقم الجوال المسجل لدى stc pay والذي ترغب بأن نحول له المبالغ المالية',
        ),
        StcTermsItem(
          title: '4',
          text:
              'تنشئ الحوالة وتحول تلقائيا بعد 48 ساعة من تاريخ المغادرة بكل الحجوزات التي تمت في هذا التاريخ',
        ),
      ],
    );
  }
}
