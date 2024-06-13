import 'package:intl/intl.dart';

extension StringExtensions on String {
  String toStringAsNumber([String? locale]) {
    String result = locale == null
        ? ''
        : locale == 'ar'
        ? ' ريال'
        : 'Rial ';
    if (isNotEmpty) {
      int textLength = split('.').length;
      if (textLength > 1) {
        String decimalText = split('.').last;
        if (decimalText[0] == '0') {
          return '${split('.').first}$result';
        }
        return '${split('.').first}.${split('.').last[0]}$result';
      }
      return this + result;
    }
    return this + result;
  }

  String toCurrency({String locale = 'ar'}) {
    final formatter = NumberFormat.simpleCurrency(
      locale: locale,
      name: locale == 'ar' ? 'ريال' : 'R.S ',
    );
    return formatter.format(double.tryParse(this) ?? 0);
  }
}
