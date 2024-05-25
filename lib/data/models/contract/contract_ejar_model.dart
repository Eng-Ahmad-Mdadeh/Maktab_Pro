class ContractEjar {
  DateTime startDate;
  DateTime endDate;
  String imageRecord;
  String imageInstrument;
  int idNumberLessor;
  String mobileLessor;
  String neighborhoodLessor;
  String streetLessor;
  String cityLessor;
  String constructionNumberLessor;
  int idNumberTenant;
  String mobileTenant;
  String neighborhoodTenant;
  String streetTenant;
  String cityTenant;
  int constructionNumberTenant;
  String typeAqar;
  String spaceUnit;
  double lengthFrontEnd;
  bool isMushtab;
  bool noFloorUnit;
  String typeUnit;
  bool noCentralConditioners;
  bool noWindowConditioners;
  bool noSplitConditioners;
  String waterPaymentMethod;
  int waterMoney;
  String electricityPaymentMethod;
  int electricityMoney;
  int rentPaymentCycle;
  int downPayment;
  int durationDaysOpenContract;
  int durationDaysCancelContract;
  String notes;

  ContractEjar({
    required this.startDate,
    required this.endDate,
    required this.imageRecord,
    required this.imageInstrument,
    required this.idNumberLessor,
    required this.mobileLessor,
    required this.neighborhoodLessor,
    required this.streetLessor,
    required this.cityLessor,
    required this.constructionNumberLessor,
    required this.idNumberTenant,
    required this.mobileTenant,
    required this.neighborhoodTenant,
    required this.streetTenant,
    required this.cityTenant,
    required this.constructionNumberTenant,
    required this.typeAqar,
    required this.spaceUnit,
    required this.lengthFrontEnd,
    required this.isMushtab,
    required this.noFloorUnit,
    required this.typeUnit,
    required this.noCentralConditioners,
    required this.noWindowConditioners,
    required this.noSplitConditioners,
    required this.waterPaymentMethod,
    required this.waterMoney,
    required this.electricityPaymentMethod,
    required this.electricityMoney,
    required this.rentPaymentCycle,
    required this.downPayment,
    required this.durationDaysOpenContract,
    required this.durationDaysCancelContract,
    required this.notes,
  });

  factory ContractEjar.fromJson(Map<String, dynamic> json) => ContractEjar(
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        imageRecord: json["image_record"],
        imageInstrument: json["image_instrument"],
        idNumberLessor: json["id_number_lessor"],
        mobileLessor: json["mobile_lessor"],
        neighborhoodLessor: json["neighborhood_lessor"],
        streetLessor: json["street_lessor"],
        cityLessor: json["city_lessor"],
        constructionNumberLessor: json["construction_number_lessor"],
        idNumberTenant: json["id_number_tenant"],
        mobileTenant: json["mobile_tenant"],
        neighborhoodTenant: json["neighborhood_tenant"],
        streetTenant: json["street_tenant"],
        cityTenant: json["city_tenant"],
        constructionNumberTenant: json["construction_number_tenant"],
        typeAqar: json["type_aqar"],
        spaceUnit: json["space_unit"],
        lengthFrontEnd: json["length_front_end"]?.toDouble(),
        isMushtab: json["is_mushtab"],
        noFloorUnit: json["no_floor_unit"],
        typeUnit: json["type_unit"],
        noCentralConditioners: json["no_central_conditioners"],
        noWindowConditioners: json["no_window_conditioners"],
        noSplitConditioners: json["no_split_conditioners"],
        waterPaymentMethod: json["water_payment_method"],
        waterMoney: json["water_money"],
        electricityPaymentMethod: json["electricity_payment_method"],
        electricityMoney: json["electricity_money"],
        rentPaymentCycle: json["rent_payment_cycle"],
        downPayment: json["down_payment"],
        durationDaysOpenContract: json["duration_days_open_contract"],
        durationDaysCancelContract: json["duration_days_cancel_contract"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "image_record": imageRecord,
        "image_instrument": imageInstrument,
        "id_number_lessor": idNumberLessor,
        "mobile_lessor": mobileLessor,
        "neighborhood_lessor": neighborhoodLessor,
        "street_lessor": streetLessor,
        "city_lessor": cityLessor,
        "construction_number_lessor": constructionNumberLessor,
        "id_number_tenant": idNumberTenant,
        "mobile_tenant": mobileTenant,
        "neighborhood_tenant": neighborhoodTenant,
        "street_tenant": streetTenant,
        "city_tenant": cityTenant,
        "construction_number_tenant": constructionNumberTenant,
        "type_aqar": typeAqar,
        "space_unit": spaceUnit,
        "length_front_end": lengthFrontEnd,
        "is_mushtab": isMushtab,
        "no_floor_unit": noFloorUnit,
        "type_unit": typeUnit,
        "no_central_conditioners": noCentralConditioners,
        "no_window_conditioners": noWindowConditioners,
        "no_split_conditioners": noSplitConditioners,
        "water_payment_method": waterPaymentMethod,
        "water_money": waterMoney,
        "electricity_payment_method": electricityPaymentMethod,
        "electricity_money": electricityMoney,
        "rent_payment_cycle": rentPaymentCycle,
        "down_payment": downPayment,
        "duration_days_open_contract": durationDaysOpenContract,
        "duration_days_cancel_contract": durationDaysCancelContract,
        "notes": notes,
      };
}
