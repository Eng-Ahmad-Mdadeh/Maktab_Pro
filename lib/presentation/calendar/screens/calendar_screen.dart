import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/navigation/navigation_cubit.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/calendar/widgets/office_calendar_box.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_bottom_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_loading.dart';
import 'package:maktab/presentation/widgets/shimmer_effect.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    context.read<OfficesCubit>().getCalendars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const MaktabAppBar(title: 'التقويم'),
          body: WillPopScope(
            onWillPop: () async {
              if (state.currentIndexs.length > 1) {
                state.currentIndexs.removeLast();
                context.read<NavigationCubit>().getNavBarItem(state.currentIndexs.last);
              } else if (state.currentIndexs.length == 1) {
                state.currentIndexs.clear();
                context.read<NavigationCubit>().getNavBarItem(0);
              }
              return true;
            },
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                child: BlocBuilder<OfficesCubit, OfficesState>(
                  builder: (context, state) {
                    return ShimmerEffect(
                      isLoading: state.calendarsApiCallState == OfficesApiCallState.loading,
                      child: state.calendarsApiCallState == OfficesApiCallState.loading
                          ? Center(child: loadingItem())
                          : ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return OfficeCalendarBox(
                                  office: context.read<OfficesCubit>().state.calendars[index],
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 15.v),
                              itemCount: context.read<OfficesCubit>().state.calendars.length,
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
          bottomNavigationBar: const MaktabBottomAppBar(),
        );
      },
    );
  }
}
