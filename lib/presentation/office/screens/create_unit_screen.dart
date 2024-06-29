import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/office/screens/unit_description_step.dart';
import 'package:maktab_lessor/presentation/office/screens/unit_details_step.dart';
import 'package:maktab_lessor/presentation/office/screens/unit_images_step.dart';
import 'package:maktab_lessor/presentation/office/screens/unit_info_step.dart';
import 'package:maktab_lessor/presentation/office/screens/unit_prices_step.dart';
import 'package:maktab_lessor/presentation/office/screens/unit_services_and_features_step.dart';
import 'package:maktab_lessor/presentation/office/widgets/create_unit_navigation_section.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';

class CreateUnitScreen extends StatefulWidget {
  const CreateUnitScreen({super.key, this.unit, this.office});

  final Office? unit;
  final Office? office;

  @override
  State<CreateUnitScreen> createState() => _CreateUnitScreenState();
}

class _CreateUnitScreenState extends State<CreateUnitScreen> {
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    UnitInfoStepStep(),
    UnitDetailsStep(),
    UnitServicesAndFeaturesStep(),
    UnitDescriptionStep(),
    UnitPricesStep(),
    UnitImagesStep(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _officeBloc = BlocProvider.of<UnitBloc>(context);
    _officesCubit = BlocProvider.of<OfficesCubit>(context);
  }

  late UnitBloc _officeBloc;
  late OfficesCubit _officesCubit;

  @override
  void dispose() {
    _officeBloc.close();
    if (widget.unit != null) {
      _officesCubit.getIncompleteUnits();
    } else {
      _officesCubit.getMyOffices();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<UnitBloc>()
        ..add(InitialUnitEvent(widget.unit, widget.office,
            context.read<OfficesCubit>().state.searchData)),
      child: BlocBuilder<UnitBloc, UnitState>(
        builder: (context, state) {
          return state.isInitialized
              ? Scaffold(
                  appBar: const MaktabAppBar(title: 'انشاء وحدة جديدة'),
                  body: SafeArea(
                    child: SizedBox(
                      width: SizeHelper.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.v, vertical: 25.v),
                              child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _pageController,
                                itemBuilder: (context, index) {
                                  return _pages[index];
                                },
                                itemCount: _pages.length,
                              ),
                            ),
                          ),
                          CreateUnitNavigationSection(
                              pageController: _pageController),
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
