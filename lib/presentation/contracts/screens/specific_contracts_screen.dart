import 'package:flutter/material.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class SpecificContractsScreen extends StatefulWidget {
  const SpecificContractsScreen({super.key});

  @override
  State<SpecificContractsScreen> createState() =>
      _SpecificContractsScreenState();
}

class _SpecificContractsScreenState extends State<SpecificContractsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MaktabAppBar(title: 'العقود المخصصة'),
    );
  }
}
