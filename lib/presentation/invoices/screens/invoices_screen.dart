import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/helpers/size_helper.dart';
import '../../../domain/invoice/invoice_bloc.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/maktab_app_bar.dart';
import '../../widgets/body_text.dart';
import '../widgets/invoice_item_card.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    context.read<InvoiceBloc>().add(GetInvoicesEvent());
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      log('Reached the end of the list');
      context.read<InvoiceBloc>().add(GetMoreInvoicesEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvoiceDownloadingCubit(),
      child: Scaffold(
        appBar: const MaktabAppBar(title: 'فواتيري'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: BlocBuilder<InvoiceBloc, InvoiceState>(builder: (context, state) {
            if (state is LoadingInvoiceState) {
              return const LoadingWidget(1);
            }
            if (state is FailureInvoiceState) {
              return Center(
                child: BodyText(text: state.message),
              );
            }
            if (state is SuccessInvoiceState) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.invoices.length,
                itemBuilder: (context, i) {
                  final invoice = state.invoices[i];
                  return InvoiceItemCard(invoice: invoice);
                },
              );
            }
            return const Center(
              child: BodyText(text: 'لا يوجد فواتير'),
            );
          }),
        ),
      ),
    );
  }
}
