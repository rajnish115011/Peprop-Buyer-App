

class User_Model{
  String? full_name;
  String? gender;
  String? dob;


  String? aadhar;
  String? pan;
  String? name;
  String? email;
  String? mobile;
  String? address;

  String? city_name;
  String? state_name;
  String? country_name;
  String? pin_code;




  User_Model({this.full_name,this.gender,this.dob,this.aadhar,this.pan});
  User_Model.fromJson(Map<String, dynamic> json) {
    full_name = json['full_name'].toString().replaceAll("null", "");
    gender = json['gender'].toString().replaceAll("null", "");
    dob = json['dob'].toString().replaceAll("null", "");
    aadhar = json['aadhar'].toString().replaceAll("null", "");
    pan = json["pan"].toString().replaceAll("null", "");

    name = json["name"].toString().replaceAll("null", "");
    email = json["email"].toString().replaceAll("null", "");
    mobile = json["mobile"].toString().replaceAll("null", "");
    address = json["address"].toString().replaceAll("null", "");
    city_name = json["city_name"].toString().replaceAll("null", "");
    state_name = json["state_name"].toString().replaceAll("null", "");
    country_name = json["country_name"].toString().replaceAll("null", "");
    pin_code = json["pin_code"].toString().replaceAll("null", "");




  }}
