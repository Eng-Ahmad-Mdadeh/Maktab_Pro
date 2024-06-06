import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/office/screens/office_confirm_address_step.dart';
import 'package:maktab/presentation/office/screens/office_description_step.dart';
import 'package:maktab/presentation/office/screens/office_details_step.dart';
import 'package:maktab/presentation/office/screens/office_first_info_step.dart';
import 'package:maktab/presentation/office/screens/office_images_step.dart';
import 'package:maktab/presentation/office/screens/office_address_step.dart';
import 'package:maktab/presentation/office/screens/office_second_info_step.dart';
import 'package:maktab/presentation/office/screens/office_services_and_features_step.dart';
import 'package:maktab/presentation/office/screens/office_type_step.dart';
import 'package:maktab/presentation/office/screens/office_unit_prices_step.dart';
import 'package:maktab/presentation/office/widgets/create_office_navigation_section.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class CreateOfficeScreen extends StatefulWidget {
  const CreateOfficeScreen({super.key, this.office});

  final Office? office;

  @override
  State<CreateOfficeScreen> createState() => _CreateOfficeScreenState();
}

class _CreateOfficeScreenState extends State<CreateOfficeScreen> {
  final PageController _pageController = PageController();
  List<Widget> pages = const [
    OfficeTypeStep(),
    OfficeFirstInfoStep(),
    OfficeSecondInfoStep(),
    OfficeDetailsStep(),
    OfficeDescriptionStep(),
    OfficeServicesAndFeaturesStep(),
    OfficeAddressStep(),
    OfficeConfirmAddressStep(),
    OfficeUnitPricesStep(),
    OfficeImagesStep(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _officesCubit = BlocProvider.of<OfficesCubit>(context);
  }

  late OfficesCubit _officesCubit;

  @override
  void dispose() {
    //_officeBloc.close();
    if (widget.office != null) {
      _officesCubit.getIncompleteOffices();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<OfficeBloc>()
        ..add(InitialOfficeEvent(widget.office, context.read<OfficesCubit>().state.searchData)),
      child: BlocBuilder<OfficeBloc, OfficeState>(
        builder: (context, state) {
          return state.isInitialized
              ? Scaffold(
                  appBar: MaktabAppBar(
                      title: widget.office != null ? 'استكمال: ${widget.office!.title}' : 'انشاء مكتب جديد'),
                  body: SafeArea(
                    child: SizedBox(
                      width: SizeHelper.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
                              child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _pageController,
                                itemBuilder: (context, index) {
                                  return pages[index];
                                },
                                itemCount: pages.length,
                              ),
                            ),
                          ),
                          CreateOfficeNavigationSection(pageController: _pageController),
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
