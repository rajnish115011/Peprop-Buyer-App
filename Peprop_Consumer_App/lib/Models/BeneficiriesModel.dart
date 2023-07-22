


class BeneficiriesModel{

  String id="";
  String acc_id="";
  String acc_type="";
  String user_id="";
  String account_no="";
  String b_user_id="";
  String b_account_no="";
  String b_ifsc="";
  String b_bank_name="";
  String b_branch="";
  String b_name="";
  String b_mobile="";
   String b_email="";



  BeneficiriesModel({required this.id, required this.acc_id,required this.acc_type,required this.user_id,
    required this.account_no, required this.b_user_id,required this.b_account_no,required this.b_ifsc,
    required this.b_bank_name, required this.b_branch,required this.b_name,required this.b_mobile,required this.b_email});
  factory BeneficiriesModel.fromJson(Map<String, dynamic> json) {
    return BeneficiriesModel(
      id: json["id"].toString(),
      acc_id: json["acc_id"].toString().replaceAll("null", ""),
      acc_type: json["acc_type"].toString().replaceAll("null", "0"),
      user_id: json["user_id"].toString().replaceAll("null", "0"),
      account_no: json["account_no"].toString().replaceAll("null", "0"),
      b_user_id: json["b_user_id"].toString().replaceAll("null", "0"),
      b_account_no: json["b_account_no"].toString().replaceAll("null", "0"),
b_ifsc: json["b_ifsc"].toString().replaceAll("null", "0"),
b_bank_name: json["b_bank_name"].toString().replaceAll("null", "0"),
b_branch: json["b_branch"].toString().replaceAll("null", "0"),
b_name: json["b_name"].toString().replaceAll("null", "0"),
b_mobile: json["b_mobile"].toString().replaceAll("null", "0"),
b_email: json["b_email"].toString().replaceAll("null", "0"),


    );
  }
}


