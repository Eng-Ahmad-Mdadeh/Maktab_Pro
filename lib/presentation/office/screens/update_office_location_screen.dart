import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/interface_aqar/interface_aqar_model.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab/presentation/widgets/maktab_google_map.dart';
import 'package:maktab/presentation/widgets/maktab_map_search_text_form_field.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UpdateOfficeLocationScreen extends StatefulWidget {
  const UpdateOfficeLocationScreen({super.key, required this.office});

  final Office? office;

  @override
  State<UpdateOfficeLocationScreen> createState() =>
      _UpdateOfficeLocationScreenState();
}

class _UpdateOfficeLocationScreenState
    extends State<UpdateOfficeLocationScreen> {
  late TextEditingController _cityController;
  late TextEditingController _neighborhoodController;
  late TextEditingController _streetController;
  late GlobalKey<FormState> _addressConfirmFormKey;
  late InterfaceAqar? interface;

  @override
  void initState() {
    _cityController =
        TextEditingController(text: widget.office!.location!.city);
    _neighborhoodController =
        TextEditingController(text: widget.office!.location!.neighborhood);
    _streetController =
        TextEditingController(text: widget.office!.location!.street);
    _addressConfirmFormKey = GlobalKey<FormState>();
    interface = context
        .read<OfficesCubit>()
        .state
        .searchData!
        .officeInterfaces
        .firstWhereOrNull(
            (interface) => interface.id == widget.office!.interfaceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<OfficeBloc>()
        ..add(InitialOfficeEvent(
            widget.office!, context.read<OfficesCubit>().state.searchData!)),
      child: BlocConsumer<OfficeBloc, OfficeState>(
        listener: (context, state) {
          if (state.officeApiCallState == OfficeApiCallState.success) {
            context.read<OfficesCubit>().getMyOffices();
            context.pop();
            MaktabSnackbar.showSuccess(context, 'تم تعديل المعلومات بنجاح');
          } else if (state.officeApiCallState == OfficeApiCallState.failure) {
            MaktabSnackbar.showError(context, 'فشل تعديل المعلومات');
          }
        },
        builder: (context, state) {
          return state.isInitialized
              ? Scaffold(
                  appBar: const MaktabAppBar(title: 'تعديل عنوان المكتب'),
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 25.v),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const PageTitle(title: 'عنوان المكتب'),
                                  SizedBox(height: 30.v),
                                  const SectionTitle(
                                    title: 'يرجى تحديد موقع المكتب',
                                    textFontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 20.v),
                                  const MaktabMapSearchTextField(),
                                  SizedBox(height: 20.v),
                                  const MaktabGoogleMap(isEditMode: true),
                                  SizedBox(height: 30.v),
                                  const PageTitle(title: 'تأكيد عنوان المكتب'),
                                  SizedBox(height: 30.v),
                                  BlocBuilder<OfficeBloc, OfficeState>(
                                    builder: (context, state) {
                                      _cityController.text = state.city;
                                      _neighborhoodController.text =
                                          state.neighborhood;
                                      _streetController.text = state.street;
                                      return Form(
                                        key: _addressConfirmFormKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MaktabTextFormField(
                                              controller: _cityController,
                                              title: 'المدينة',
                                              validator: (value) {
                                                if (value!.trim().isEmpty) {
                                                  return 'الرجاء ادخال المدينة';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                context.read<OfficeBloc>().add(
                                                    SetCityNameEvent(
                                                        value!.trim()));
                                              },
                                            ),
                                            SizedBox(height: 20.v),
                                            MaktabTextFormField(
                                              controller:
                                                  _neighborhoodController,
                                              title: 'الحي',
                                              validator: (value) {
                                                if (value!.trim().isEmpty) {
                                                  return 'الرجاء ادخال الحي';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                context.read<OfficeBloc>().add(
                                                    SetNeighborhoodNameEvent(
                                                        value!.trim()));
                                              },
                                            ),
                                            SizedBox(height: 20.v),
                                            MaktabTextFormField(
                                              controller: _streetController,
                                              title: 'اسم الشارع',
                                              validator: (value) {
                                                if (value!.trim().isEmpty) {
                                                  return 'الرجاء ادخال اسم الشارع';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                context.read<OfficeBloc>().add(
                                                    SetStreetNameEvent(
                                                        value!.trim()));
                                              },
                                            ),
                                            SizedBox(height: 20.v),
                                            const SectionTitle(
                                                title: 'الاتجاه'),
                                            SizedBox(height: 5.v),
                                            const BodyText(
                                                text:
                                                    'اختر اتجاه الحي في المدينة'),
                                            SizedBox(height: 5.v),
                                            MaktabDropDownFormField(
                                              initialValue: interface != null
                                                  ? interface!.arName
                                                  : '',
                                              items: context
                                                  .read<OfficesCubit>()
                                                  .state
                                                  .searchData!
                                                  .officeInterfaces
                                                  .map((interface) =>
                                                      interface.arName!)
                                                  .toList(),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'الرجاء ادخال الاتجاه';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {},
                                              onSaved: (value) {
                                                context.read<OfficeBloc>().add(
                                                    SetInterfaceEvent(
                                                        value!.trim()));
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 100.v,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.h, vertical: 20.v),
                            child: MaktabButton(
                              text: 'حفظ التغييرات',
                              isLoading: state.officeApiCallState ==
                                  OfficeApiCallState.loading,
                              backgroundColor: AppColors.mintTeal,
                              onPressed: () {
                                if (_addressConfirmFormKey.currentState!
                                    .validate()) {
                                  _addressConfirmFormKey.currentState!.save();
                                  context
                                      .read<OfficeBloc>()
                                      .add(UpdateOfficeLocationEvent());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
