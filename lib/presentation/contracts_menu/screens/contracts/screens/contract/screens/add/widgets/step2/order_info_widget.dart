import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/widgets/body_text.dart';

import '../../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../../domain/contracts/contract/add/contract_state.dart';
import '../../../../../../../../../../domain/orders/orders_bloc.dart';
import '../../../../../../../../../../domain/settings/settings_bloc.dart';
import '../../../../../../../../../resources/app_colors.dart';
import '../contract_group_button.dart';
import '../contract_input_widget.dart';
import '../contract_order_select_widget.dart';
import '../contract_select_widget.dart';
import '../contract_switch_widget.dart';

class OrderInfoWidget extends StatelessWidget {
  const OrderInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractCubit, ContractEntity>(
      builder: (context, state) {
        return Column(
          children: [
            ContractSwitchWidget(
              title: "هل تريد العقد مخصص لطلب ؟",
              onSwitch: context.read<ContractCubit>().setisOrderOn,
              value: state.isOrderOn ?? false,
            ),
            if (state.isOrderOn ?? false)
              BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, orderState) {
                  print(orderState);
                  if (orderState is OrdersWithoutPaginationSuccess) {
                    return ContractOrderSelectWidget(
                      title: "الرجاء اختيار الطلب",
                      items: orderState.orders,
                      initialValue: state.orderId,
                      onChanged: context.read<ContractCubit>().setorder,
                    );
                  }
                  if(orderState is OrdersLoading) {
                    return const LinearProgressIndicator();
                  }
                  if(orderState is OrdersFailure) {
                    return BodyText(text: "لا يمكن التحميل هنالك خطأ: ${orderState.message}");
                  }
                  return const BodyText(text: "لا يمكن التحميل هنالك خطأ");
                },
              ),
            ContractInputWidget(
              title: "اسم العقار",
              hint: "اسم العقار",
              disabled: state.isOrderOn ?? false,
              onChanged: context.read<ContractCubit>().setofficeName,
              controller: context.read<ContractCubit>().officeName,
            ),

            //
            BlocBuilder<SearchDataBloc, SearchDataState>(
              builder: (context, searchDataState) {
                if (searchDataState is SearchDataSuccess) {
                  return ContractSelectWidget<String>(
                    title: "تجهيز العقار",
                    value: (state.officeCategoryAqar??'').isEmpty ? null : state.officeCategoryAqar,
                    onChanged: context.read<ContractCubit>().setofficeCategoryAqar,
                    // items: const ["المالك", "الوكيل"],
                    children: searchDataState.searchData.officeCategories.map((e) => e.arName).toList(),
                    items: searchDataState.searchData.officeCategories.map((e) => e.enName).toList(),
                  );
                }
                if(searchDataState is SearchDataLoading) {
                  return const LinearProgressIndicator();
                }
                return const BodyText(text: "لا يمكن التحميل هنالك خطأ");
              },
            ),
            //
            BlocBuilder<SearchDataBloc, SearchDataState>(
              builder: (context, searchDataState) {
                if (searchDataState is SearchDataSuccess) {
                  return ContractSelectWidget<String>(
                    title: "نوع العقار",
                    value: (state.officeTypeAqar??'').isEmpty ? null : state.officeTypeAqar,
                    // value: state.officeTypeAqar,
                    onChanged: context.read<ContractCubit>().setofficeTypeAqar,
                    children: searchDataState.searchData.officeTypes.map((e) => e.arName).toList(),
                    items: searchDataState.searchData.officeTypes.map((e) => e.enName).toList(),
                  );
                }
                if(searchDataState is SearchDataLoading) {
                  return const LinearProgressIndicator();
                }
                return const BodyText(text: "لا يمكن التحميل هنالك خطأ");
              },
            ),
            ContractInputWidget(
              title: "الرمز البريدي",
              hint: "الرمز البريدي",
              controller: context.read<ContractCubit>().officePostalCode,
              // disabled: state.isOrderOn??false,
              numberMode: true,
              onChanged: context.read<ContractCubit>().setofficePostalCode,
              // req: false,
              validator: (value) {
                if ((value ?? '').length < 5) {
                  return "يجب ان كون اكبر من 5 خانات";
                }
                return null;
              },
            ),
            ContractInputWidget(
              title: "رقم إضافي",
              hint: "رقم إضافي",
              controller: context.read<ContractCubit>().officeAdditionalNo,
              // disabled: state.isOrderOn??false,
              numberMode: true,
              onChanged: context.read<ContractCubit>().setofficeAdditionalNo,
              validator: (value) {
                if ((value ?? '').length < 4) {
                  return "يجب ان كون اكبر من 4 خانات";
                }
                return null;
              },
            ),
            ContractInputWidget(
              title: "رقم المبنى",
              hint: "رقم المبنى",
              controller: context.read<ContractCubit>().officeBuildingNo,
              // disabled: state.isOrderOn??false,
              numberMode: true,
              onChanged: context.read<ContractCubit>().setofficeBuildingNo,
              validator: (value) {
                if ((value ?? '').length < 4) {
                  return "يجب ان كون اكبر من 4 خانات";
                }
                return null;
              },
            ),
            ContractInputWidget(
              title: "رقم الوحدة",
              hint: "رقم الوحدة",
              controller: context.read<ContractCubit>().officeUnitNo,
              // disabled: state.isOrderOn??false,
              numberMode: true,
              onChanged: context.read<ContractCubit>().setofficeUnitNo,
              req: false,
            ),
            ContractInputWidget(
              title: "اسم المدينة",
              hint: "اسم المدينة",
              controller: context.read<ContractCubit>().officeCity,
              // disabled: state.isOrderOn ?? false,
              disabled: true,
              onChanged: context.read<ContractCubit>().setofficeCity,
            ),
            ContractInputWidget(
              title: "اسم الحي",
              hint: "اسم الحي",
              controller: context.read<ContractCubit>().officeNeighborhood,
              // disabled: state.isOrderOn ?? false,
              disabled: true,
              onChanged: context.read<ContractCubit>().setofficeNeighborhood,
            ),
            ContractInputWidget(
              title: "اسم الشارع",
              hint: "اسم الشارع",
              controller: context.read<ContractCubit>().officeStreet,
              // disabled: state.isOrderOn ?? false,
              disabled: true,
              onChanged: context.read<ContractCubit>().setofficeStreet,
            ),

            if (!(state.isOrderOn ?? false)) const ContractMapWidget(),

            ContractInputWidget(
              title: "مساحة الوحدة",
              hint: "مساحة الوحدة",
              numberMode: true,
              controller: context.read<ContractCubit>().officeSpace,
              disabled: state.isOrderOn ?? false,
              onChanged: context.read<ContractCubit>().setofficeSpace,
            ),
            ContractInputWidget(
              title: "طول الواجهة الامامية",
              hint: "طول الواجهة الامامية",
              controller: context.read<ContractCubit>().officeLengthFrontEnd,
              // disabled: state.isOrderOn??false,
              numberMode: true,
              onChanged: context.read<ContractCubit>().setofficeLengthFrontEnd,
            ),
            ContractGroupButton<YesOrNoType>(
              title: "مشطب",
              // items: const ["نعم", "لا"],
              items: const [YesOrNoType.yes, YesOrNoType.no],
              itemsText: [
                context.read<ContractCubit>().getName(YesOrNoType.yes),
                context.read<ContractCubit>().getName(YesOrNoType.no),
              ],
              onButtonSelected: context.read<ContractCubit>().setofficeIsMushtab,
              value: state.officeIsMushtab ?? YesOrNoType.yes,
              controller: context.read<ContractCubit>().officeIsMushtab,
            ),
            ContractInputWidget(
              title: "رقم الطابق",
              hint: "رقم الطابق",
              // disabled: state.isOrderOn??false,
              numberMode: true,
              controller: context.read<ContractCubit>().officeNoFloor,
              onChanged: context.read<ContractCubit>().setofficeNoFloor,
            ),
          ],
        );
      },
    );
  }
}

enum YesOrNoType { yes, no }

class ContractMapWidget extends StatelessWidget {
  const ContractMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.v,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15.fSize),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.fSize),
        child: LayoutBuilder(
            builder: (context, constraints) => Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Stack(
                      children: [
                        GoogleMap(
                          gestureRecognizers: {
                            Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            ),
                          },
                          onCameraMove: context.read<ContractCubit>().onContractCameraMove,
                          onCameraIdle: context.read<ContractCubit>().onContractCameraIdle,
                          mapType: MapType.normal,
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(24.7113719, 46.6744867),
                            zoom: 13,
                          ),
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: false,
                          scrollGesturesEnabled: true,
                          rotateGesturesEnabled: true,
                          onMapCreated: context.read<ContractCubit>().onContractMapCreated,
                        ),
                        // Positioned(
                        //   bottom: constraints.maxHeight * 0.05,
                        //   right: constraints.maxWidth * 0.05,
                        //   child: InkWell(
                        //     onTap: () async {},
                        //     child: Container(
                        //       width: 60.v,
                        //       height: 60.h,
                        //       decoration: const BoxDecoration(
                        //         color: Color(0xffffffff),
                        //         shape: BoxShape.circle,
                        //       ),
                        //       child: Icon(
                        //         Icons.my_location,
                        //         color: const Color(0xFF14B183),
                        //         size: 45.fSize,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Icon(
                      Icons.my_location,
                      color: AppColors.cherryRed,
                      size: 45.fSize,
                    )
                  ],
                )),
      ),
    );
  }
}
