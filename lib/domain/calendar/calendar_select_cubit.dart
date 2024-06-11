import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/aqar_filter/type_res.dart';

class CalendarSelectCubit extends Cubit<CalendarFormatOptions?> {
  CalendarSelectCubit(super.defaultOption);

  void changed(CalendarFormatOptions option) => emit(option);
}
