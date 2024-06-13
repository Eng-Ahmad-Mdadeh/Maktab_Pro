// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maktab/core/helpers/size_helper.dart';
// import 'package:maktab/presentation/order/widgets/guest_data_box.dart';
// import 'package:maktab/presentation/order/widgets/order_data_box.dart';
// import 'package:maktab/presentation/order/widgets/order_summary_box.dart';
// import 'package:maktab/presentation/order/widgets/payment_data_box.dart';
// import 'package:maktab/presentation/resources/app_colors.dart';
// import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
// import 'package:maktab/presentation/widgets/shimmer_effect.dart';
//
// import '../../../domain/orders/order/order_bloc.dart';
//
// class OrderScreen extends StatelessWidget {
//   const OrderScreen({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MaktabAppBar(title: '2233445'),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
//           child: BlocBuilder<OrderBloc, OrderState>(
//             builder: (context, state) {
//               return ShimmerEffect(
//                 isLoading: state is OrderLoading,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.softAsh),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Column(
//                     children: [
//                       GuestDataBox(),
//                       Divider(color: AppColors.softAsh),
//                       OrderDataBox(),
//                       Divider(color: AppColors.softAsh),
//                       PaymentDataBox(),
//                       Divider(color: AppColors.softAsh),
//                       OrderSummaryBox(),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//       // bottomNavigationBar: const MaktabBottomAppBar(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maktab/core/extension/date_time_extension.dart';
import 'package:maktab/core/extension/num_extension.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_rich_text.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/models/order/order_model.dart';
import '../../../domain/orders/order/order_bloc.dart';
import '../../../domain/orders/orders_bloc.dart';
import '../../resources/app_colors.dart';
import '../../widgets/maktab_app_bar.dart';
import '../../widgets/page_title.dart';
import '../../widgets/shimmer_effect.dart';
import '../../widgets/body_text.dart';
import '../../widgets/section_title.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderSuccess) {
          context.read<OrdersBloc>().add(const GetOrdersEvent(1));
        }
      },
      builder: (context, state) {
        if (state is OrderFailure) {
          return const BodyText(text: "error");
        }
        if (state is OrderLoading) {
          return Scaffold(
            appBar: const MaktabAppBar(
              title: '',
            ),
            body: ShimmerEffect(
              isLoading: true,
              child: Column(
                children: List.generate(
                  3,
                  (index) => OrderDetailsCard(
                    cardTitle: ['معلومات المستأجر', 'معلومات المؤجر', 'معلومات الوحدة'][index],
                    items: const [
                      OrderDetailsItemData(title: 'الاسم', value: ''),
                      OrderDetailsItemData(title: 'معلومات الهوية', value: ''),
                      OrderDetailsItemData(title: 'الجوال', value: ''),
                      OrderDetailsItemData(title: 'الموقع', value: ''),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (state is OrderSuccess) {
          final order = state.order;
          return Scaffold(
            appBar: MaktabAppBar(
              title: order.office?.title ?? '',
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MaktabButton(
                          // height: 45.0.v,
                          width: 150.0.h,
                          text: "إنشاء عقد",
                          color: AppColors.white,
                          bold: false,
                          backgroundColor:
                              order.reservation == 'acceptably' ? AppColors.mintGreen : AppColors.softAsh,
                          fontSize: 17.0,
                          onPressed: order.reservation == 'acceptably'
                              ? () {
                                  context.pushNamed(AppRoutes.addContractScreen, extra: order.id);
                                }
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MaktabButton(
                          // height: 60.0.v,
                          width: 150.0.h,
                          fontSize: 17.0,
                          bold: false,
                          text: "إلغاء الطلب",
                          color: AppColors.white,
                          backgroundColor:
                              order.reservation != 'canceled' ? AppColors.cherryRed : AppColors.softAsh,
                          onPressed: order.reservation != 'canceled'
                              ? () {
                                  showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 20.0.v,
                                          ),
                                          Icon(
                                            Icons.cancel_outlined,
                                            color: AppColors.cherryRed,
                                            size: 70.0.adaptSize,
                                          ),
                                          SizedBox(
                                            height: 20.0.v,
                                          ),
                                          const SectionTitle(
                                            title: 'هل انت متأكد؟',
                                          ),
                                          const BodyText(text: "هل انت متأكد من قيامك بهذه العملية")
                                        ],
                                      ),
                                      actionsAlignment: MainAxisAlignment.center,
                                      actions: [
                                        MaktabButton(
                                          width: 70,
                                          height: 50,
                                          onPressed: () {
                                            context.pop(true);
                                          },
                                          text: 'نعم',
                                          backgroundColor: AppColors.cherryRed,
                                          color: AppColors.white,
                                        ),
                                        MaktabButton(
                                          width: 70,
                                          height: 50,
                                          onPressed: () {
                                            context.pop(false);
                                          },
                                          text: 'لا',
                                          backgroundColor: AppColors.gray,
                                          color: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  ).then((value) {
                                    final canCancel = value ?? false;
                                    if (canCancel) {
                                      context.read<OrderBloc>().add(SetOrderCancelEvent(order.id!));
                                    }
                                  });
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'معلومات المستأجر',
                    items: [
                      OrderDetailsItemData(title: 'الاسم', value: order.tenant?.username ?? ''),
                      OrderDetailsItemData(title: 'معلومات الهوية', value: order.tenant?.idNumber ?? ''),
                      OrderDetailsItemData(title: 'الجوال', value: order.tenant?.phone ?? ''),
                      OrderDetailsItemData(
                          title: 'الموقع',
                          value: '${order.tenant?.city ?? ''},${order.tenant?.neighborhood ?? ''}'),
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'معلومات المؤجر',
                    items: [
                      OrderDetailsItemData(title: 'الاسم', value: order.lessor?.username ?? ''),
                      OrderDetailsItemData(title: 'معلومات الهوية', value: order.lessor?.idNumber ?? ''),
                      OrderDetailsItemData(title: 'الجوال', value: order.lessor?.phone ?? ''),
                      OrderDetailsItemData(
                          title: 'الموقع',
                          value: '${order.lessor?.city ?? ''},${order.lessor?.neighborhood ?? ''}'),
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'معلومات الوحدة',
                    items: [
                      OrderDetailsItemData(title: 'اسم المكتب', value: order.office?.title ?? ''),
                      OrderDetailsItemData(title: 'الوحدة', value: order.office?.unitId?.toString() ?? ''),
                      OrderDetailsItemData(
                          title: 'الموقع',
                          value:
                              '${order.office?.location?.city ?? ''},${order.office?.location?.neighborhood ?? ''},${order.office?.location?.street ?? ''}'),
                      OrderDetailsItemData(
                          title: 'تاريخ الحجز', value: order.startDate?.dayFormatWithLocale('ar') ?? ''),
                      OrderDetailsItemData(
                          title: 'تاريخ الانتهاء', value: order.endDate?.dayFormatWithLocale('ar') ?? ''),
                      OrderDetailsItemData(title: 'مدة الإيجار', value: '${order.durationRes ?? ''} يوم'),
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'بيانات الدفع',
                    fontSize: 17,
                    items: [
                      OrderDetailsItemData(
                        title: 'طريقة الدفع',
                        value: order.paymentMethod == 'bank'
                            ? 'تحويل بنكي'
                            : order.paymentMethod == 'electronic'
                                ? 'بطاقة ائتمانية'
                                : '',
                      ),
                      OrderDetailsItemData(
                        title: 'المدفوع',
                        value: _getTotal(order.paymentTenants, false),
                        isCurrency: true,
                        valueColor: AppColors.orangeAccent,
                      ),
                      OrderDetailsItemData(
                        title: 'المبلغ المتبقي من المدة التي حجزتها',
                        value: _getTotal(order.paymentTenants, true),
                        isCurrency: true,
                        valueColor: AppColors.cherryRed,
                      ),
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'بيانات معاين الموقع',
                    items: [
                      OrderDetailsItemData(title: 'الاسم', value: order.office?.viewerName ?? ''),
                      OrderDetailsItemData(title: 'الجوال', value: order.office?.viewerPhone ?? ''),
                    ],
                    location: LatLng(order.office!.location!.lat, order.office!.location!.lng),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: BodyText(text: "no data"),
          ),
        );
      },
    );
  }

  String _getTotal(List<PaymentTenant> paymentTenants, remaining) {
    if (paymentTenants.isEmpty) return '0';
    return paymentTenants
        .map((e) => num.parse(remaining ? e.remaining! : e.paid!))
        .reduce((v, e) => v + e)
        .toStringAsFixedWithCheck(2);
  }
}

class OrderDetailsItemData {
  final String title;
  final String value;
  final Color? titleColor;
  final Color? valueColor;
  final bool isCurrency;

  const OrderDetailsItemData({
    required this.title,
    required this.value,
    this.titleColor,
    this.valueColor,
    this.isCurrency = false,
  });
}

class OrderDetailsCard extends StatelessWidget {
  final String cardTitle;
  final List<OrderDetailsItemData> items;
  final LatLng? location;
  final double? fontSize;

  const OrderDetailsCard({
    super.key,
    required this.cardTitle,
    required this.items,
    this.location,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.softAsh,
        ),
        borderRadius: BorderRadius.circular(10.0.adaptSize),
      ),
      margin: EdgeInsets.all(7.0.adaptSize),
      padding: EdgeInsets.all(14.0.adaptSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageTitle(
            title: cardTitle,
            fontSize: 17,
          ),
          ...items.map((e) => OrderDetailsItem(
                title: e.title,
                text: e.value,
                fontSize: fontSize,
                titleColor: e.titleColor,
                valueColor: e.valueColor,
                isCurrency: e.isCurrency,
              )),
          SizedBox(
            height: 10.0.v,
          ),
          if (location != null)
            SizedBox(
              height: 300,
              width: SizeHelper.width,
              child: GoogleMap(
                circles: {
                  Circle(
                      circleId: CircleId(UniqueKey().toString()),
                      center: location!,
                      radius: 1000,
                      fillColor: AppColors.paleBlue,
                      strokeWidth: 0)
                },
                markers: {
                  Marker(
                      markerId: MarkerId(UniqueKey().toString()),
                      position: location!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure))
                },
                style: AppConstants.mapStyle,
                initialCameraPosition: CameraPosition(target: location!, zoom: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class OrderDetailsItem extends StatelessWidget {
  final String title;
  final String text;
  final double? fontSize;
  final Color? titleColor;
  final Color? valueColor;
  final bool isCurrency;

  const OrderDetailsItem({
    super.key,
    required this.title,
    required this.text,
    this.fontSize,
    this.titleColor,
    this.valueColor,
    this.isCurrency = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.0.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SectionTitle(
            title: title,
            textFontWeight: FontWeight.normal,
            textColor: titleColor,
          ),
          if (isCurrency)
            MaktabRichText(
              texts: [
                MaktabRichTextModel(text: text, color: valueColor),
                MaktabRichTextModel(text: ' ريال', fontWeight: FontWeight.normal),
              ],
            )
          else
            BodyText(
              text: text,
              fontSize: fontSize,
              textColor: valueColor,
            ),
        ],
      ),
    );
  }
}
