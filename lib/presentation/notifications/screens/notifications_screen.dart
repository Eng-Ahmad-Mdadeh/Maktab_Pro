import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/delete_alert_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/loading_widget.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';

import '../../../domain/contracts/contract/contract_bloc.dart';
import '../../../domain/notification/notification_bloc.dart';
import '../../../domain/orders/order/order_bloc.dart';
import '../../widgets/body_text.dart';
import '../../widgets/section_title.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(
        title: "الاشعارات",
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) return const LoadingWidget(1);
          if (state is NotificationsFailure) return Center(child: BodyText(text: "${state.message}حدث خطأ ما حاول مجدداً"));
          if (state is NotificationsSuccess) {
            return ListView.separated(
              separatorBuilder: (context, i) {
                return const Divider(
                  color: AppColors.mintGreen,
                );
              },
              itemCount: state.notifications.length,
              itemBuilder: (context, i) {
                final notification = state.notifications[i];
                return ListTile(
                  onTap: () {
                    /// "/dashboard/reservations/70",
                    /// "dashboard/contracts/custom-contracts-details/23",
                    /// "dashboard/contracts/custom-contracts-details/11",
                    /// "dashboard/contracts/custom-contracts-details/24",

                    context.read<NotificationsBloc>().add(SetSeenNotificationEvent(notification.id!));

                    final url = notification.url ?? '';
                    late final int? id;
                    if (url.contains('contract')) {
                      if (url.contains('delete')) {
                        // "url": "contract-delete-20",
                        id = int.tryParse(url.split('-').last);
                        log(id.toString());
                      } else {
                        // "url": "dashboard/contracts/custom-contracts-details/20",
                        id = int.tryParse(url.split('/').last);
                        log(url.split('/').last);
                      }
                      context.read<ContractBloc>().add(GetContractEvent(id));
                      context.pushNamed(AppRoutes.contractScreen, extra: true);
                    } else if (url.contains('reservations')) {
                      // "url": "/dashboard/reservations/20",
                      id = int.tryParse(url.split('/').last);
                      log(url.split('/').last);
                      context.read<OrderBloc>().add(GetOrderEvent(id));
                      context.pushNamed(AppRoutes.orderScreen, extra: true);
                    }
                  },
                  title: SectionTitle(
                    title: notification.arTitle ?? '',
                    textColor: notification.seen ? AppColors.gray : null,
                  ),
                  subtitle: BodyText(
                    text: notification.arBody ?? '',
                    textColor: notification.seen ? AppColors.gray : null,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => DeleteAlertDialog(
                          alertText: "سيتم حذف ${notification.arTitle}",
                          confirmOnPressed: () {
                            context.read<NotificationsBloc>().add(DeleteNotificationEvent(notification.id!));
                            context.pop();
                          },
                          cancelOnPressed: context.pop,
                        ),
                      );
                    },
                    color: AppColors.cherryRed,
                    icon: const Icon(Icons.delete),
                  ),
                  leading: SectionTitle(
                    title: '#${notification.id!}',
                    textColor: notification.seen ? AppColors.gray : null,
                  ),
                );
              },
            );
          }
          return const Center(child: BodyText(text: "لا يوجد شيء لعرضه"));
        },
      ),
    );
  }
}
