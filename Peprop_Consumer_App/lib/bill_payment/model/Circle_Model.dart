

class Circle_Model {

  String id="";
  String circle="";

  Circle_Model({required this.id,required this.circle });

  factory Circle_Model.fromJson(Map<String, dynamic> json) {
    return Circle_Model(
      id:json["id"].toString(),
      circle: json["circle"].toString(),


    );
  }



}
class Opertaor_list {

  String id="";
  String operator_id="";
  String name="";
  String category="";
  String logo="";
  String ca_number="";

  Opertaor_list({required this.id,required this.operator_id,required this.name,required this.category,required this.logo });

  factory Opertaor_list.fromJson(Map<String, dynamic> json) {
    return Opertaor_list(
      id:json["id"].toString(),
      operator_id: json["operator_id"].toString(),
      name: json["name"].toString(),
      category: json["category"].toString(),
      logo: json["logo"].toString(),


    );
  }



}

class Bill_Fetch_Model{
  String? amount;
  String? name;
  String? duedate;
  String? response_code;


  Bill_Fetch_Model({this.amount,this.name,this.duedate});
  Bill_Fetch_Model.fromJson(Map<String, dynamic> json) {
    amount = json['amount'].toString().replaceAll("null", "");
    name = json['name'].toString().replaceAll("null", "");
    duedate = json['duedate'].toString().replaceAll("null", "");
    response_code = json['response_code'].toString().replaceAll("null", "");

  }}


