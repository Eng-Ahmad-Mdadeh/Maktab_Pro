import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/orders/widgets/order_selection_button.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

import '../../../domain/orders/orders_bloc.dart';

class OrdersSearchBox extends StatelessWidget {
  OrdersSearchBox({super.key, required this.currentPage});

  final int currentPage;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.softAsh)),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          children: [
            const SectionTitle(title: "البحث"),
            SizedBox(width: 10.h),
            Icon(
              Icons.info,
              color: AppColors.lightCyan,
              size: 30.adaptSize,
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.v),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: MaktabTextFormField(
                      controller: _searchController,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'البحث باسم العميل أو رقم الطلب',
                      prefix: const Icon(Icons.search, color: AppColors.slateGray),
                      onChanged: (value) {
                        context.read<OrdersBloc>().add(FilterOrders(value ?? ''));
                      },
                    ),
                  ),
                  SizedBox(height: 15.v),
                  const SectionTitle(title: 'حالة الحجز'),
                  SizedBox(height: 10.v),
                  SizedBox(
                    height: 50.v,
                    child: BlocConsumer<OrderReservationCubit, OrderReservationStatus>(
                      listener: (context, state){
                        switch(state){
                          case OrderReservationStatus.all:
                            context.read<OrdersBloc>().add(const StatusFilterOrders(''));
                            break;
                          case OrderReservationStatus.accepted:
                            context.read<OrdersBloc>().add(const StatusFilterOrders('acceptably'));
                            break;
                          case OrderReservationStatus.waiting:
                            context.read<OrdersBloc>().add(const StatusFilterOrders('pending'));
                            break;
                          case OrderReservationStatus.canceled:
                            context.read<OrdersBloc>().add(const StatusFilterOrders('canceled'));
                            break;
                        }
                      },
                      builder: (context, state) {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            OrderSelectionButton(
                              title: 'الكل',
                              isSelected: state == OrderReservationStatus.all,
                              onSelected: (){
                                context.read<OrderReservationCubit>().changeStatus(OrderReservationStatus.all);
                              },
                            ),
                            SizedBox(width: 7.h),
                            OrderSelectionButton(
                              title: 'مقبول',
                              isSelected: state == OrderReservationStatus.accepted,
                              onSelected: (){
                                context.read<OrderReservationCubit>().changeStatus(OrderReservationStatus.accepted);

                              },
                            ),
                            SizedBox(width: 7.h),
                            OrderSelectionButton(
                              title: 'انتظار',
                              isSelected: state == OrderReservationStatus.waiting,
                              onSelected: (){
                                context.read<OrderReservationCubit>().changeStatus(OrderReservationStatus.waiting);

                              },
                            ),
                            SizedBox(width: 7.h),
                            OrderSelectionButton(
                              title: 'ملغي',
                              isSelected: state == OrderReservationStatus.canceled,
                              onSelected: (){
                                context.read<OrderReservationCubit>().changeStatus(OrderReservationStatus.canceled);

                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum OrderReservationStatus { all, accepted, waiting, canceled }

class OrderReservationCubit extends Cubit<OrderReservationStatus> {
  OrderReservationCubit() : super(OrderReservationStatus.all);

  void changeStatus(OrderReservationStatus status) {
    emit(status);
  }
}