import 'package:equatable/equatable.dart';

class ContractModelModel extends Equatable {
  const ContractModelModel({
    required this.id,
    required this.status,
    required this.name,
    required this.description,
    required this.contentContractModel,
    required this.createByBusiness,
    required this.createByAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? status;
  final String? name;
  final String? description;
  final String? contentContractModel;
  final String? createByBusiness;
  final String? createByAdmin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ContractModelModel copyWith({
    int? id,
    String? status,
    String? name,
    String? description,
    String? contentContractModel,
    String? createByBusiness,
    String? createByAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ContractModelModel(
      id: id ?? this.id,
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      contentContractModel: contentContractModel ?? this.contentContractModel,
      createByBusiness: createByBusiness ?? this.createByBusiness,
      createByAdmin: createByAdmin ?? this.createByAdmin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ContractModelModel.fromJson(Map<String, dynamic> json){
    return ContractModelModel(
      id: json["id"],
      status: json["status"].toString(),
      name: json["name"],
      description: json["description"],
      contentContractModel: json["content_contract_model"],
      createByBusiness: json["create_by_business"].toString(),
      createByAdmin: json["create_by_admin"].toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "name": name,
    "description": description,
    "content_contract_model": contentContractModel,
    "create_by_business": createByBusiness,
    "create_by_admin": createByAdmin,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $status, $name, $description, $contentContractModel, $createByBusiness, $createByAdmin, $createdAt, $updatedAt, ";
  }

  @override
  List<Object?> get props => [
    id, status, name, description, contentContractModel, createByBusiness, createByAdmin, createdAt, updatedAt, ];
}
