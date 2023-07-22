class My_Legal_Enquiry_Model {
  String full_name="";
  String mobile="";
  String property_name="";
  String type="";
  String date="";
  String slot="";
  String reason="";
  String status="0";
  String id="";
  String layer_name="";
  String layer_Education="";



  My_Legal_Enquiry_Model({required this.full_name, required this.mobile,required this.property_name,
    required this.type, required this.date,required this.slot,required this.reason,required this.id,
  required this.layer_name,required this.layer_Education});
  factory My_Legal_Enquiry_Model.fromJson(Map<String, dynamic> json) {
    return My_Legal_Enquiry_Model(
      full_name: json["full_name"].toString(),
      mobile: json["mobile"].toString().replaceAll("null", "N/A"),
      property_name: json["property_name"].toString().replaceAll("null", "N/A"),
      type: json["type"].toString().replaceAll("null", "N/A"),
      date: json["date"].toString().replaceAll("null", "N/A"),
      slot: json["slot"].toString().replaceAll("null", "N/A"),
      reason: json["legal_name"].toString().replaceAll("null", "N/A"),
      id: json["id"].toString().replaceAll("null", ""),
      layer_name: json["layer_name"].toString().replaceAll("null", ""),
      layer_Education: json["layer_Education"].toString().replaceAll("null", ""),


    );
  }

}


