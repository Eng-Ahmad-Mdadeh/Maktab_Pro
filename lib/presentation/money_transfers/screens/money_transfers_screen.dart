import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/transfers/transfers_bloc.dart';
import 'package:maktab_lessor/domain/transfers/transfers_event.dart';
import 'package:maktab_lessor/domain/transfers/transfers_state.dart';

import '../../../core/services/service_locator.dart';
import '../../widgets/body_text.dart';
import '../../widgets/loading_dialog.dart';
import '../../widgets/maktab_app_bar.dart';
import '../../widgets/retry_button.dart';
import '../widgets/transfer_money_card.dart';

class MoneyTransfersScreen extends StatefulWidget {
  const MoneyTransfersScreen({super.key});

  @override
  State<MoneyTransfersScreen> createState() => _MoneyTransfersScreenState();
}

class _MoneyTransfersScreenState extends State<MoneyTransfersScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _transferBloc = BlocProvider.of<TransferBloc>(context);
  }

  late TransferBloc _transferBloc;

  @override
  void dispose() {
    _transferBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent &&
          context.read<TransferBloc>().state.transfers.length < context.read<TransferBloc>().state.total) {
        log("PAGINATE...");
        context.read<TransferBloc>().add(GetTransfersEvent(page: context.read<TransferBloc>().state.page));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<TransferBloc>()..add(const GetTransfersEvent(page: 1)),
      child: Scaffold(
        appBar: const MaktabAppBar(title: 'الحوالات المالية'),
        body: Padding(
          padding: EdgeInsets.all(15.0.fSize),
          child: BlocConsumer<TransferBloc, TransfersState>(
            listener: (context, state) {
              if (state.fetchingDataState == FetchingDataStates.loading) {
                LoadingDialog.show(context);
              } else if (state.fetchingDataState == FetchingDataStates.failure) {
                LoadingDialog.hide(context);
              } else if (state.fetchingDataState == FetchingDataStates.success && state.page == 2) {
                LoadingDialog.hide(context);
              }
            },
            builder: (context, state) {
              if (state.fetchingDataState == FetchingDataStates.failure) {
                return Center(
                  child: RetryButton(
                    onTap: () {
                      context.read<TransferBloc>().add(const GetTransfersEvent(page: 1));
                    },
                  ),
                );
              }

              return state.transfers.isNotEmpty || state.fetchingDataState == FetchingDataStates.loading
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return TransferMoneyCard(model: state.transfers[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20.v,
                        );
                      },
                      itemCount: state.transfers.length)
                  : const Center(child: BodyText(text: 'لا يوجد بيانات'));
            },
          ),
        ),
      ),
    );
  }
}

// SafeArea(
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
// child: const SingleChildScrollView(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// MaktabTextFormField(
// hintText: 'ابحث برقم الحجز',
// prefix: Icon(
// FontAwesomeIcons.magnifyingGlass,
// color: AppColors.gray,
// ),
// ),
// TransferMoneyCard()
// ],
// ),
// ),
// )),
