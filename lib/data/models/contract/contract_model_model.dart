class ContractModel {
  String name;
  String description;
  String contentContractModel;
  int status;

  ContractModel({
    required this.name,
    required this.description,
    required this.contentContractModel,
    required this.status,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
        name: json["name"],
        description: json["description"],
        contentContractModel: json["content_contract_model"],
        status: json["status"] is bool
            ? json["status"] == true
                ? 1
                : 0
            : int.parse(json["status"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "content_contract_model": contentContractModel,
        "status": status,
      };
}
