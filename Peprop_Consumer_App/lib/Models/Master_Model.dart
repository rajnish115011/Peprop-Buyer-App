class Master_Model{
  String id="";
  String name="";
  String purpose_id="";
  bool checked=false;


  Master_Model({required this.id, required this.name, required this.purpose_id, required this.checked});

  factory Master_Model.fromJson(Map<String, dynamic> json) {
    return Master_Model(
      id: json["id"].toString(),
      name: json["name"].toString(),
      purpose_id: json["purpose_id"].toString(),
      checked: false,
    );

  }


}