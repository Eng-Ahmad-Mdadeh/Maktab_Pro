import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MaktabPageSlider extends StatefulWidget {
  const MaktabPageSlider({super.key, required this.widgets, this.height});

  final List<Widget> widgets;
  final double? height;

  @override
  State<MaktabPageSlider> createState() => _MaktabPageSliderState();
}

class _MaktabPageSliderState extends State<MaktabPageSlider> {
  final pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return widget.widgets.isNotEmpty
        ? Column(
            children: [
              SizedBox(
                height: widget.height ?? 120.v,
                child: PageView.builder(
                  controller: pageController,
                  itemBuilder: (_, index) {
                    return widget.widgets[index % widget.widgets.length];
                  },
                  itemCount: widget.widgets.length,
                ),
              ),
              SizedBox(height: 10.v),
              SmoothPageIndicator(
                controller: pageController,
                count: widget.widgets.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 16.v,
                  dotWidth: 16.h,
                  activeDotColor: AppColors.lightCyan,
                  dotColor: AppColors.softAsh,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
