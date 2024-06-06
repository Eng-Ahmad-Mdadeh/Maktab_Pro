// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/user/user_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UserAgreementScreen extends StatefulWidget {
  const UserAgreementScreen({super.key});

  @override
  State<UserAgreementScreen> createState() => _UserAgreementScreenState();
}

class _UserAgreementScreenState extends State<UserAgreementScreen> {
  @override
  void initState() {
    // context.read<UserBloc>().add(GetUserAgreementEvent());
    super.initState();
  }

  // @override
  // void dispose() {
  //   userBloc.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'اتفاقية الاستخدام'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(title: state.agreement!.titleAr??''),
                  SizedBox(height: 30.v),
                  Html(data: state.agreement?.contentAr??''),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
