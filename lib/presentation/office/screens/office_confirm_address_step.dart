import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/interface_aqar/interface_aqar_model.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeConfirmAddressStep extends StatefulWidget {
  const OfficeConfirmAddressStep({super.key});

  @override
  State<OfficeConfirmAddressStep> createState() => _OfficeConfirmAddressStepState();
}

class _OfficeConfirmAddressStepState extends State<OfficeConfirmAddressStep> {
  late TextEditingController _cityController;
  late TextEditingController _neighborhoodController;
  late TextEditingController _streetController;
  late GlobalKey<FormState> _addressConfirmFormKey;
  late InterfaceAqar? interface;
  late OfficeState state;

  // @override
  // void initState() {
  //   OfficeState state = context.read<OfficeBloc>().state;
  //   _cityController = TextEditingController(text: state.city);
  //   _neighborhoodController = TextEditingController(text: state.neighborhood);
  //   _streetController = TextEditingController(text: state.street);
  //   _addressConfirmFormKey = GlobalKey<FormState>();
  //   interface = state.searchData!.officeInterfaces
  //       .firstWhereOrNull((interface) => interface.id == state.interfaceId);
  //   super.initState();
  // }

  @override
  void initState() {
    state = context.read<OfficeBloc>().state;
    // _cityController = TextEditingController(text: state.verifyLicenseNumberModel!.location!.city ?? state.city);
    // _neighborhoodController = TextEditingController(text: state.verifyLicenseNumberModel!.location!.district ?? state.neighborhood);
    // _streetController = TextEditingController(text: state.verifyLicenseNumberModel!.location!.street ?? state.street);
    _cityController = TextEditingController(text: state.verifyLicenseNumberModel?.location?.city ?? state.city);
    _neighborhoodController =
        TextEditingController(text: state.verifyLicenseNumberModel?.location?.neighborhood ?? state.neighborhood);
    _streetController = TextEditingController(text: state.verifyLicenseNumberModel?.location?.street ?? state.street);
    _addressConfirmFormKey = GlobalKey<FormState>();
    interface = state.searchData!.officeInterfaces.firstWhereOrNull((interface) => interface.id == state.interfaceId);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (state.verifyLicenseNumberModel != null) {
      context
          .read<OfficeBloc>()
          .add(SetCityNameEvent(state.verifyLicenseNumberModel!.location!.city ?? state.location!.city));
      context.read<OfficeBloc>().add(SetNeighborhoodNameEvent(
          state.verifyLicenseNumberModel?.location?.neighborhood ?? state.location!.neighborhood));
      context
          .read<OfficeBloc>()
          .add(SetStreetNameEvent(state.verifyLicenseNumberModel!.location?.street ?? state.street));
      // context
      //     .read<OfficeBloc>()
      //     .add(SetDistrictCodeEvent(state.verifyLicenseNumberModel!.location?.districtCode ?? state.districtCode));
      // context
      //     .read<OfficeBloc>()
      //     .add(SetRegionCodeEvent(int.parse(state.verifyLicenseNumberModel!.location?.regionCode ?? '0')));

      context.read<OfficeBloc>().add(
          SetInterfaceEvent(state.verifyLicenseNumberModel!.interfaceAqar?.arName ?? state.interfaceAqar!.arName!));
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'تأكيد عنوان المكتب'),
          SizedBox(height: 30.v),
          Form(
            key: _addressConfirmFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaktabTextFormField(
                  readOnly:
                      state.officeType == OfficeTypes.license && state.verifyLicenseNumberModel!.location!.city != null,
                  controller: _cityController,
                  title: 'المدينة',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'الرجاء ادخال المدينة';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<OfficeBloc>().add(SetCityNameEvent(value.trim()));
                  },
                ),
                SizedBox(height: 20.v),
                MaktabTextFormField(
                  readOnly: state.officeType == OfficeTypes.license &&
                      state.verifyLicenseNumberModel!.location!.neighborhood != null,
                  controller: _neighborhoodController,
                  title: 'الحي',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'الرجاء ادخال الحي';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<OfficeBloc>().add(SetNeighborhoodNameEvent(value.trim()));
                  },
                ),
                SizedBox(height: 20.v),
                MaktabTextFormField(
                  readOnly: state.officeType == OfficeTypes.license &&
                      state.verifyLicenseNumberModel!.location!.street != null,
                  controller: _streetController,
                  title: 'اسم الشارع',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'الرجاء ادخال اسم الشارع';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<OfficeBloc>().add(SetStreetNameEvent(value.trim()));
                  },
                ),
                SizedBox(height: 20.v),
                const SectionTitle(title: 'الاتجاه'),
                SizedBox(height: 5.v),
                const BodyText(text: 'اختر اتجاه الحي في المدينة'),
                SizedBox(height: 5.v),
                MaktabDropDownFormField(
                  // initialValue: interface != null ? interface!.arName : '',
                  initialValue: state.verifyLicenseNumberModel?.interfaceAqar?.arName ?? interface?.arName,
                  // readOnly: state.officeType == OfficeTypes.license,

                  items: context
                      .read<OfficeBloc>()
                      .state
                      .searchData!
                      .officeInterfaces
                      .map((interface) => interface.arName!)
                      .toList(),
                  fontSize: 17.0,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء ادخال الاتجاه';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    print(value);
                    context.read<OfficeBloc>().add(SetInterfaceEvent(value!.trim()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
