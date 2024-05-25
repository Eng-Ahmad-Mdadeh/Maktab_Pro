import 'package:flutter/material.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class ContractsSamplesScreen extends StatefulWidget {
  const ContractsSamplesScreen({super.key});

  @override
  State<ContractsSamplesScreen> createState() => _ContractsSamplesScreenState();
}

class _ContractsSamplesScreenState extends State<ContractsSamplesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MaktabAppBar(title: 'نماذج العقود'),
    );
  }
}
