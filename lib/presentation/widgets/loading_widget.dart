import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import '../resources/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final int index;
  final double? size;
  final bool noCenter;

  const LoadingWidget(this.index, {super.key, this.size, this.noCenter = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: [
        const ThreeBounceWidgetsFactory(),
        const WaveSpinnerWidgetsFactory(),
      ][index]
          .create()
          .render(color: AppColors.mintGreen, size: size ?? 50.v, noCenter: noCenter),
    );
  }
}

// SpinKitWaveSpinner

abstract interface class ILoading {
  Widget render({required Color color, required double size, required noCenter});
}

class ThreeBounce implements ILoading {
  const ThreeBounce();

  @override
  Widget render({required Color color, required double size, required noCenter}) {
    if(noCenter){
      return SpinKitThreeBounce(
        color: color,
        size: size,
      );
    }
    return Center(
      child: SpinKitThreeBounce(
        color: color,
        size: size,
      ),
    );
  }
}

class WaveSpinner implements ILoading {
  const WaveSpinner();

  @override
  Widget render({required Color color, required double size, required noCenter}) {
    if(noCenter){
      return SpinKitWaveSpinner(
        color: color,
        size: size,
      );
    }
    return Center(
      child: SpinKitWaveSpinner(
        color: color,
        size: size,
      ),
    );
  }
}

class ThreeBounceWidgetsFactory implements IWidgetsFactory {
  const ThreeBounceWidgetsFactory();

  @override
  String getTitle() => 'Three Bounce Loading Widget';

  @override
  ILoading create() => const ThreeBounce();
}

class WaveSpinnerWidgetsFactory implements IWidgetsFactory {
  const WaveSpinnerWidgetsFactory();

  @override
  String getTitle() => 'Wave Spinner Loading Widget';

  @override
  ILoading create() => const WaveSpinner();
}

abstract interface class IWidgetsFactory {
  String getTitle();

  ILoading create();
}
