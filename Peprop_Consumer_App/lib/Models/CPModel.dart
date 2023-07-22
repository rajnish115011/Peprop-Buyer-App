import 'Broker_profile_Model.dart';

class CPModel {
  String? createdBy;
  String? createdOn;
  String? fullname;
  String? mobile;
  String? email;
  String? compAddress;
  String? profileImage;
  String? userlevel;
  String? userId;
  String? req_id;
  String? kyc_status;
  String? rera_number;
  String? company_type;
  String? cp_id;
  String? property_count;
  String? PropertyTitle;
  String? Propertyfor;
  Broker_Profile_Model?broker_Profile_model;




  CPModel(
      {this.createdBy,
        this.createdOn,
        this.fullname,
        this.mobile,
        this.email,
        this.compAddress,
        this.profileImage,
        this.userlevel,
        this.req_id,
        this.kyc_status,
        this.rera_number,
        this.company_type,
        this.cp_id,
        this.property_count,
        this.PropertyTitle,
        this.Propertyfor,

      });

  CPModel.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    fullname = json['full_name'];
    mobile = json['mobile'];
    email = json['email'];
    compAddress = json['comp_address'];
    profileImage = json['profile_image'];
    userlevel = json['userlevel'];
    userId = json['user_id'];
    req_id = json['req_id'];
    kyc_status = json['kyc_status'];
    rera_number = json['rera_number'];
    company_type = json['company_type'];
    cp_id = json['cp_id'];
    property_count = json['property_count'].toString();
    PropertyTitle = json['PropertyTitle'].toString();
    Propertyfor = json['PropertyFor'].toString();
    if(json["broker_details"]!=null){
      var PropertyLocation = json["broker_details"];
      broker_Profile_model = Broker_Profile_Model.fromJson(PropertyLocation);

    }



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['fullname'] = this.fullname;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['comp_address'] = this.compAddress;
    data['profile_image'] = this.profileImage;
    data['userlevel'] = this.userlevel;
    data['user_id'] = this.userId;
    data['req_id'] = this.req_id;
    data['kyc_status'] = this.kyc_status;
    data['rera_number'] = this.rera_number;
    data['company_type'] = this.company_type;
    data['cp_id'] = this.cp_id;
    return data;
  }
}