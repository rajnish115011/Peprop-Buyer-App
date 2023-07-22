

class Broker_Profile_Model{



  String? comp_name;
  String? comp_address;
  String? country_name;
  String? state_name;
  String? city_name;
  String? rera_approved;
  String? rera_number;
  String? full_name;
  String? email;
  String? mobile;
  String? user_level;
  String? profile_image;
  String? kyc_status;
  String? rating;



    Broker_Profile_Model.fromJson(Map<String, dynamic> json) {
    comp_name = json['comp_name'].toString().replaceAll("null", "N/A");
    comp_address = json['comp_address'].toString().replaceAll("null", "N/A");
    country_name = json['country_name'].toString().replaceAll("null", "N/A");
    state_name = json['state_name'].toString().replaceAll("null", "N/A");
    city_name = json['city_name'].toString().replaceAll("null", "N/A");
    rera_approved = json['rera_approved'].toString().replaceAll("null", "N/A");
    rera_number = json['rera_number'].toString().replaceAll("null", "N/A");
    full_name = json['full_name'].toString().replaceAll("null", "N/A");
    email = json['email'].toString().replaceAll("null", "N/A");
    mobile = json['mobile'].toString().replaceAll("null", "N/A");
    user_level = json['user_level'].toString().replaceAll("null", "N/A");
    profile_image = json['profile_image'].toString().replaceAll("null", "N/A");
    kyc_status = json['kyc_status'].toString().replaceAll("null", "N/A");
    rating = json['rating'].toString().replaceAll("null", "N/A");



    }
}