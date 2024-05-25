// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/financial_transactions/financial_transfer.dart';
import 'package:maktab/domain/home/home_bloc.dart';
import 'package:maktab/presentation/home/widgets/financial_transfer_list_item.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class LatestTransfersSection extends StatelessWidget {
  LatestTransfersSection({super.key});

  FinancialTransfer? transfer;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: SizeHelper.width,
        padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 20.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: AppColors.softAsh,
                    size: 35.adaptSize,
                  ),
                  SizedBox(width: 10.h),
                  const SectionTitle(title: 'آخر الحوالات'),
                ],
              ),
            ),
            SizedBox(height: 10.v),
            context.read<HomeBloc>().state.statistics != null &&
                    context
                        .read<HomeBloc>()
                        .state
                        .statistics!
                        .transfers
                        .isNotEmpty
                ? ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 350.v),
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 10.v),
                      itemBuilder: (context, index) {
                        transfer = context
                            .read<HomeBloc>()
                            .state
                            .statistics!
                            .transfers[index];
                        return FinancialTransferListItem(transfer: transfer!);
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 5.v),
                      itemCount: context
                          .read<HomeBloc>()
                          .state
                          .statistics!
                          .transfers
                          .length,
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.v),
                      child: const BodyText(text: 'لا يوجد بيانات'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
