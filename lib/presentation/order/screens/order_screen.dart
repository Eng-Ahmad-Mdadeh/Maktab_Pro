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
import 'package:maktab/presentation/widgets/maktab_button.dart';

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
      listener: (context, state){
        if(state is OrderSuccess){
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
                            ['الاسم', ''],
                            ['معلومات الهوية', ''],
                            ['الجوال', ''],
                            ['الموقع', ''],
                          ],
                        )),
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
                          height: 45.0.v,
                          width: 150.0.h,
                          text: "إنشاء عقد",
                            color: AppColors.white,
                          onPressed: () {
                            // todo: link this with create contract page after work on contract
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MaktabButton(
                          height: 45.0.v,
                          width: 150.0.h,
                          text: "إلغاء الطلب",
        color: AppColors.white,
                          backgroundColor: AppColors.cherryRed,
                          onPressed: () {
                            showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 20.0.v,),
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.cherryRed,
                                      size: 70.0.adaptSize,
                                    ),
                                    SizedBox(height: 20.0.v,),
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
                            ).then((value){
                              final canCancel = value ?? false;
                              if(canCancel) {
                                context.read<OrderBloc>().add(SetOrderCancelEvent(order.id!));
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'معلومات المستأجر',
                    items: [
                      ['الاسم', order.tenant?.username ?? ''],
                      ['معلومات الهوية', order.tenant?.idNumber ?? ''],
                      ['الجوال', order.tenant?.phone ?? ''],
                      ['الموقع', '${order.tenant?.city ?? ''},${order.tenant?.neighborhood ?? ''}'],
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'معلومات المؤجر',
                    items: [
                      ['الاسم', order.lessor?.username ?? ''],
                      ['معلومات الهوية', order.lessor?.idNumber ?? ''],
                      ['الجوال', order.lessor?.phone ?? ''],
                      ['الموقع', '${order.lessor?.city ?? ''},${order.lessor?.neighborhood ?? ''}'],
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'معلومات الوحدة',
                    items: [
                      ['اسم المكتب', order.office?.title ?? ''],
                      ['الوحدة', order.office?.unitId?.toString() ?? ''],
                      [
                        'الموقع',
                        '${order.office?.location?.city ?? ''},${order.office?.location?.neighborhood ?? ''},${order.office?.location?.street ?? ''}'
                      ],
                      ['تاريخ الحجز', (order.startDate?.dayFormatWithLocale('ar') ?? '')],
                      ['تاريخ الانتهاء', '${order.endDate?.dayFormatWithLocale('ar') ?? ''},${order.lessor?.neighborhood ?? ''}'],
                      ['مدة الإيجار', '${order.durationRes ?? ''} يوم'],
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'بيانات الدفع',
                    items: [
                      [
                        'طريقة الدفع',
                        order.paymentMethod == 'bank'
                            ? 'تحويل بنكي'
                            : order.paymentMethod == 'electronic'
                                ? 'بطاقة ائتمانية'
                                : ''
                      ],
                      ['المدفوع', _getTotal(order.paymentTenants, false)],
                      ['المبلغ المتبقي من المدة التي حجزتها', _getTotal(order.paymentTenants, false)],
                    ],
                  ),
                  OrderDetailsCard(
                    cardTitle: 'بيانات معاين الموقع',
                    items: [
                      ['الاسم', order.office?.viewerName ?? ''],
                      ['الجوال', order.office?.viewerPhone ?? ''],
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
    return paymentTenants.map((e) => num.parse(remaining ? e.remaining! : e.paid!)).reduce((v, e) => v + e).toStringAsFixedWithCheck(2);
  }
}

class OrderDetailsCard extends StatelessWidget {
  final String cardTitle;
  final List<List<String>> items;
  final LatLng? location;

  const OrderDetailsCard({
    super.key,
    required this.cardTitle,
    required this.items,
    this.location,
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
          ...items.map((e) => OrderDetailsItem(title: e.first, text: e.last)),
          SizedBox(
            height: 10.0.v,
          ),
          if (location != null)
            SizedBox(
              height: 300,
              width: SizeHelper.width,
              child: GoogleMap(
                circles: {
                  Circle(circleId: CircleId(UniqueKey().toString()), center: location!, radius: 1000, fillColor: AppColors.paleBlue, strokeWidth: 0)
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

  const OrderDetailsItem({
    super.key,
    required this.title,
    required this.text,
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
            fontSize: 15,
          ),
          BodyText(
            text: text,
          ),
        ],
      ),
    );
  }
}
