

class User_Profile_Model{



  String? full_name;
  String? mobile;
  String? email;
  String? created_on;
  String? city_name;
  String? aadhar;

  String? pan;
  String? user_level;
  String? notification;
  String? city_id;
  String? state_id;
  String? country_id;

  String? photo;
  String? kyc_status;
  String? c_address;
  String? rm_id;
  String? rm_name;
  String? rm_email;
  String? rm_mobile;
  String? address;
  String? comp_name;
  String? comp_address;
  String? country_name;
  String? state_name;
  String? rera_approved;
  String? rera_number;









  User_Profile_Model({this.full_name,this.mobile,this.email,this.created_on,this.city_name,this.aadhar,this.pan,this.notification,
  required this.city_id,required this.state_id,required this.country_id,required this.photo,required this.kyc_status,required this.c_address,

  });

  User_Profile_Model.fromJson(Map<String, dynamic> json) {
    full_name = json['full_name'].toString().replaceAll("null", "N/A");
    mobile = json['mobile'].toString().replaceAll("null", "N/A");
    email = json['email'].toString().replaceAll("null","N/A");
    created_on = json['created_on'].toString().replaceAll("null","N/A");
    city_name = json['city_name'].toString().replaceAll("null", "N/A");
    aadhar = json['aadhar'].toString().replaceAll("null", "N/A");
    pan = json['pan'].toString().replaceAll("null", "N/A");
    user_level = json['user_level'].toString().replaceAll("null", "N/A");
    notification = json['notification'].toString().replaceAll("null", "1");
    city_id = json['city_id'].toString().replaceAll("null", "1");
    state_id = json['state_id'].toString().replaceAll("null", "1");
    country_id = json['country_id'].toString().replaceAll("null", "1");
    photo = json['photo'].toString().replaceAll("null", "N/A");
    kyc_status = json['kyc_status'].toString().replaceAll("null", "N/A");
    c_address = json['c_address'].toString().replaceAll("null", "");
    rm_id = json['rm_id'].toString().replaceAll("null", "");
    rm_name = json['rm_name'].toString().replaceAll("null", "");
    rm_email = json['rm_email'].toString().replaceAll("null", "");
    rm_mobile = json['rm_mobile'].toString().replaceAll("null", "");
    address = json['address'].toString().replaceAll("null", "N/A");

    comp_name = json['comp_name'].toString().replaceAll("null", "N/A");
    comp_address = json['comp_address'].toString().replaceAll("null", "N/A");
    country_name = json['country_name'].toString().replaceAll("null", "N/A");
    state_name = json['state_name'].toString().replaceAll("null", "N/A");
    rera_approved = json['rera_approved'].toString().replaceAll("null", "N/A");
    rera_number = json['rera_number'].toString().replaceAll("null", "N/A");





  }



}