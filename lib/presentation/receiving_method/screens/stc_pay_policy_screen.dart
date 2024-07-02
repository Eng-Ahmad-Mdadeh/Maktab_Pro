import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import '../../widgets/maktab_button.dart';
import '../widgets/stc_policy_section.dart';
import '../widgets/stc_pay_header.dart';

class StcPayPolicyScreen extends StatefulWidget {
  const StcPayPolicyScreen({super.key});

  @override
  State<StcPayPolicyScreen> createState() => _StcPayPolicyScreenState();
}

class _StcPayPolicyScreenState extends State<StcPayPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StcPayHeader(),
              SizedBox(height: 20.v),
              const StcPolicySection(),
              MaktabButton(
                text: 'تأكيد',
                onPressed: () {
                  if (context
                      .read<ReceivingMethodBloc>()
                      .state
                      .acceptStcPayPolicy) {
                    context
                        .pushReplacementNamed(AppRoutes.stcPayActivateScreen);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
