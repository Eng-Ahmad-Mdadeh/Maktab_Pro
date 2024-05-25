import 'package:maktab/data/models/complaint/complaint_model.dart';
import 'package:maktab/data/models/evaluation/evaluation_model.dart';
import 'package:maktab/data/models/financial_transactions/financial_transfer.dart';
import 'package:maktab/data/models/order/order_model.dart';

class Statistics {
  String username;
  List<FinancialTransfer> transfers;
  List<OrderModel> orders;
  List<Evaluation> evaluations;
  List<Complaint> complaints;

  Statistics({
    required this.username,
    required this.transfers,
    required this.orders,
    required this.evaluations,
    required this.complaints,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        username: json["username"],
        transfers: List<FinancialTransfer>.from(
            json["transfers"].map((x) => FinancialTransfer.fromJson(x))),
        orders: List<OrderModel>.from(json["orders"].map((x) => OrderModel.fromJson(x))),
        evaluations: List<Evaluation>.from(
            json["evaluations"].map((x) => Evaluation.fromJson(x))),
        complaints: List<Complaint>.from(
            json["reports"].map((x) => Complaint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "transfers": List<dynamic>.from(transfers.map((x) => x.toJson())),
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "evaluations": List<dynamic>.from(evaluations.map((x) => x.toJson())),
        "reports": List<dynamic>.from(complaints.map((x) => x.toJson())),
      };
}
