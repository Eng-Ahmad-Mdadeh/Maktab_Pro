import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/loading_widget.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

import '../../../domain/contracts/contract/contract_bloc.dart';
import '../../../domain/notification/notification_bloc.dart';
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
          if (state is NotificationsFailure) return const BodyText(text: "حدث خطأ ما حاول مجدداً");
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
                    ///

                    final url = notification.url ?? '';
                    if (url.contains('contract')) {
                      late final int? id;
                      if (url.contains('delete')) {
                        id = int.tryParse(url.split('-').last);
                        log(id.toString());
                      } else {
                        id = int.tryParse(url.split('/').last);
                        log(url.split('/').last);
                      }
                      context.read<ContractBloc>().add(GetContractEvent(id));
                      context.pushNamed(AppRoutes.contractScreen, extra: true);
                    }
                  },
                  title: SectionTitle(
                    title: notification.arTitle ?? '',
                  ),
                  subtitle: BodyText(text:notification.arBody ?? ''),
                  trailing: IconButton(
                    onPressed: () {},
                    color: AppColors.cherryRed,
                    icon: const Icon(Icons.delete),
                  ),
                  leading: SectionTitle(title: '#${notification.id!}'),
                );
              },
            );
          }
          return const BodyText(text: "لا يوجد شيء لعرضه");
        },
      ),
    );
  }
}
