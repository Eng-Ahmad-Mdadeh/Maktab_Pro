class Response {
  bool status;
  String errNum;
  String message;
  dynamic data;

  Response({
    required this.status,
    required this.errNum,
    required this.message,
    required this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"],
        errNum: json["errNum"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errNum": errNum,
        "message": message,
        "data": data,
      };
}
