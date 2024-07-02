import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/presentation/calendar/widgets/office_calendar_box.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_loading.dart';
import 'package:maktab_lessor/presentation/widgets/shimmer_effect.dart';

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
    return Scaffold(
      appBar: const MaktabAppBar(
        title: 'التقويم',
      ),
      body: SafeArea(
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
      // bottomNavigationBar: const MaktabBottomAppBar(),
    );
  }
}
