import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';

class CreateOfficeNavigationSection extends StatelessWidget {
  const CreateOfficeNavigationSection({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfficeBloc, OfficeState>(
      listener: (context, state) {
        if (state.stepNavigationState == StepNavigationState.next) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        } else if (state.stepNavigationState == StepNavigationState.previous) {
          pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        } else if (state.stepNavigationState == StepNavigationState.end) {
          pageController.dispose();
          context.pop();
          MaktabSnackbar.showWarning(context, 'جاري رفع الملفات ...');
        }
        if (state.imagesApiCallState == OfficeApiCallState.success) {
          MaktabSnackbar.showSuccess(context, 'تم رفع الملفات بنجاح');
        } else if (state.imagesApiCallState == OfficeApiCallState.failure) {
          MaktabSnackbar.showError(context, 'فشل رفع الملفات');
        }
      },
      builder: (context, state) => Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10.v,
            borderRadius: BorderRadius.circular(20),
            backgroundColor: AppColors.mintGreen,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.emeraldTeal,
            ),
            value: state.progressValue.toDouble() / 10,
          ),
          Container(
            height: 100.v,
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
            child: Row(
              children: [
                Expanded(
                  child: MaktabButton(
                    text: 'السابق',
                    backgroundColor: AppColors.white,
                    color: AppColors.emeraldTeal,
                    isBordered: true,
                    onPressed: () {
                      if (pageController.page! > 0) {
                        context.read<OfficeBloc>().add(
                            NavigateToPreviousStepEvent(
                                pageController.page!.toInt() - 1));
                      }
                    },
                  ),
                ),
                SizedBox(width: 20.h),
                Expanded(
                  child: BlocBuilder<OfficeBloc, OfficeState>(
                    builder: (context, state) {
                      return MaktabButton(
                        text: 'التالي',
                        backgroundColor: !state.isStepCompleted ||
                                state.officeApiCallState ==
                                    OfficeApiCallState.loading
                            ? AppColors.mintTeal.withOpacity(0.2)
                            : AppColors.mintTeal,
                        isEnabled: state.isStepCompleted,
                        isLoading: state.officeApiCallState ==
                            OfficeApiCallState.loading,
                        onPressed: () {
                          context.read<OfficeBloc>().add(
                              NavigateToNextStepEvent(
                                  pageController.page!.toInt()));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
