class Bank_List_Model {
  String bank_id="";
  String bank_name="";
  String bank_image="";
  Bank_List_Model({required this.bank_id, required this.bank_name,required this.bank_image});
  factory Bank_List_Model.fromJson(Map<String, dynamic> json) {
    return Bank_List_Model(
      bank_id: json["bank_id"].toString(),
      bank_name: json["bank"].toString().replaceAll("null", "N/A"),
      bank_image: json["bank_image"].toString().replaceAll("null", "N/A"),


    );
  }

}
class IFSC_Model {
  String ifsc="";
  String branch="";
  String address="";
  IFSC_Model({required this.ifsc, required this.branch,required this.address});
  factory IFSC_Model.fromJson(Map<String, dynamic> json) {
    return IFSC_Model(
      ifsc: json["ifsc"].toString(),
      branch: json["branch"].toString().replaceAll("null", "N/A"),
      address: json["address"].toString().replaceAll("null", "N/A"),


    );
  }

}


