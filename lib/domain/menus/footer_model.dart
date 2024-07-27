import 'package:equatable/equatable.dart';

class FooterModel extends Equatable{
  final String phone;


  const FooterModel({required this.phone});

  factory FooterModel.fromJson(Map<String, dynamic> json){
    return FooterModel(
      phone: json['phone']
    );
  }

  toJson(){
    return {
      'phone': phone,
    };
  }

  @override
  List<Object?> get props => [phone];

}