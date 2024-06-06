extension NumsExtension on num {
  String toStringAsFixedWithCheck(int fractionDigits) {
    final number = toStringAsFixed(fractionDigits);
    if (number.contains('.')) {
      String fractionalPart = number.split('.').last;
      if (fractionalPart.isNotEmpty) {
        if(fractionalPart[0] != '0') {
          return number;
        }else{
          return number.split('.').first;
        }
      } else {
        return toString();
      }
    } else {
      return toString();
    }
  }

  String toShortPrice(int fractionDigits, [bool show = false, String? local = 'ar']){
    if(!show) return toStringAsFixedWithCheck(fractionDigits);
    if(this > 1000){
      return local == 'en' ? '${(this/1000).ceil()}K' : '${(this/1000).ceil()}ألف';
    }
    return toStringAsFixedWithCheck(fractionDigits);
  }
}
