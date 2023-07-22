
class LoanModel {
  String name = "";
  String mobile = "";
  String email = "";
  String amount = "";
  String tenure = "";
  String type = "";
  String status = "";
  String created_on = "";

  LoanModel(
      {required this.name,
      required this.mobile,
      required this.email,
      required this.amount,
      required this.tenure,
      required this.type,
      required this.status,
      required this.created_on});

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      name: json["name"].toString().replaceAll("null", ""),
      mobile: json["mobile"].toString().replaceAll("null", ""),
      email: json["email"].toString().replaceAll("null", ""),
      amount: json["amount"].toString().replaceAll("null", ""),
      tenure: json["tenure"].toString().replaceAll("null", ""),
      type: json["type"].toString().replaceAll("null", ""),
      status: json["status"].toString().replaceAll("null", ""),
      created_on: json["created_on"].toString().replaceAll("null", ""),
    );
  }
}
