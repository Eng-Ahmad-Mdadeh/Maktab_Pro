

import 'package:flutter_bloc/flutter_bloc.dart';

class LicenseCubit extends Cubit<bool> {
  LicenseCubit() : super(true);

  void toggleLicenseStatus(bool v) => emit(v);
}
