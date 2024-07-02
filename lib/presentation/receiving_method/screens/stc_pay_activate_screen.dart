import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/receiving_method/widgets/stc_phone_form.dart';
import 'package:maktab_lessor/presentation/receiving_method/widgets/stc_terms_list.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class StcPayActivateScreen extends StatefulWidget {
  const StcPayActivateScreen({super.key});

  @override
  State<StcPayActivateScreen> createState() => _StcPayActivateScreenState();
}

class _StcPayActivateScreenState extends State<StcPayActivateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'طريقة استلام المبالغ'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'تفعيل حساب التسوية المالية'),
                SizedBox(height: 30.v),
                const StcTermsList(),
                SizedBox(height: 30.v),
                const StcPhoneForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
