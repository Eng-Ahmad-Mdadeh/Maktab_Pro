// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_navigation_item.dart';

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({super.key});

  @override
  State<ContractsScreen> createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'العقود'),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaktabNavigationItemItem(
              title: 'نماذج العقود',
              onTap: () => context.pushNamed(AppRoutes.contractsSamplesScreen),
            ),
            MaktabNavigationItemItem(
              title: 'عقود مخصصة',
              onTap: () => context.pushNamed(AppRoutes.specificContractsScreen),
            ),
            MaktabNavigationItemItem(
              title: 'فواتيري',
              onTap: () {},
            ),
          ],
        ),
      )),
    );
  }
}
