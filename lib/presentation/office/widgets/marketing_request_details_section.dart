import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/office/widgets/marketing_request_details_item.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class MarketingRequestDetailsSection extends StatelessWidget {
  const MarketingRequestDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OfficeBloc, OfficeState>(
      listener: (context, state) {
        if (state.filesErrorMessage.isNotEmpty) {
          MaktabSnackbar.showError(context, state.filesErrorMessage);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.v),
          const Divider(color: AppColors.softAsh),
          SizedBox(height: 20.v),
          const PageTitle(title: 'بيانات طلب التسويق'),
          SizedBox(height: 20.v),
          BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              return MarketingRequestDetailsItem(
                title: 'ترخيص المكتب',
                fileName: state.selectedOfficeLicensingFile,
                onTap: () {
                  context
                      .read<OfficeBloc>()
                      .add(PickOfficeLicensingFileEvent());
                },
              );
            },
          ),
          SizedBox(height: 20.v),
          BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              return MarketingRequestDetailsItem(
                title: 'ترخيص المبنى',
                fileName: state.selectedBuildingLicesnsingFile,
                onTap: () {
                  context
                      .read<OfficeBloc>()
                      .add(PickBuildingLicensingFileEvent());
                },
              );
            },
          ),
          SizedBox(height: 20.v),
          BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              return MarketingRequestDetailsItem(
                title: 'الدفاع المدني',
                fileName: state.selectedCivilDefenseFile,
                onTap: () {
                  context.read<OfficeBloc>().add(PickCivilDefenseFileEvent());
                },
              );
            },
          )
        ],
      ),
    );
  }
}
