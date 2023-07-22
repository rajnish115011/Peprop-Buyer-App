import 'Broker_profile_Model.dart';

class BrokerModelEn {
  String? leadContactId;
  String? mobile;
  String? createdBy;
  String? name;
  String? propertyCount;
  String? user_level;


  List<PropertyDetail>? propertyDetail;
  String? city_name;
  String? broker_mobile;
  String? created_by;
  String? brokerage_rm_accept_reject;
  String? builder_name;
  String? broker_tasks_count;


  Broker_Profile_Model?broker_Profile_model;




  BrokerModelEn({this.leadContactId, this.mobile, this.createdBy, this.name, this.propertyCount, this.propertyDetail,this.city_name,this.user_level,this.broker_mobile});

  BrokerModelEn.fromJson(Map<String, dynamic> json) {
    leadContactId = json['lead_contact_id'];
    mobile = json['mobile'];
    createdBy = json['created_by'];
    name = json['name'];
    propertyCount = json['property_count'];
    brokerage_rm_accept_reject = json['brokerage_rm_accept_reject'].toString();
    builder_name = json['builder_name'].toString();




    if (json['property_detail'] != null) {
      propertyDetail = <PropertyDetail>[];
      json['property_detail'].forEach((v) {
        propertyDetail!.add(new PropertyDetail.fromJson(v));
      });
    }
    city_name = json['city_name'].toString().replaceAll("null", "");
    user_level = json['user_level'].toString().replaceAll("null", "");

    broker_mobile = json['broker_mobile'].toString().replaceAll("null", "");
    created_by = json['created_by'].toString().replaceAll("null", "");
    broker_tasks_count = json['broker_tasks_count'].toString().replaceAll("null", "");



    if(json["broker_details"]!=null){
      var PropertyLocation = json["broker_details"];
      broker_Profile_model = Broker_Profile_Model.fromJson(PropertyLocation);

    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_contact_id'] = this.leadContactId;
    data['mobile'] = this.mobile;
    data['created_by'] = this.createdBy;
    data['name'] = this.name;
    data['property_count'] = this.propertyCount;
    if (this.propertyDetail != null) {
      data['property_detail'] =
          this.propertyDetail!.map((v) => v.toJson()).toList();
    }


    return data;
  }
}

class PropertyDetail {
  String? iD;
  String? propertyname;
  String? address;
  String? image;
  String? lead_id;
  String? PropertyFor;
  String? builder_name;
  String total="0";



  PropertyDetail({this.iD, this.propertyname, this.address, this.image,this.lead_id,this.PropertyFor,this.builder_name,required this.total});

  PropertyDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    propertyname = json['propertyname'];
    address = json['Address'];
    image = json['image'];
    lead_id = json['lead_id'];
    PropertyFor = json['PropertyFor'];
    builder_name = json['builder_name'];
    total = json['inventory_count']??"0";




  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['propertyname'] = this.propertyname;
    data['Address'] = this.address;
    data['image'] = this.image;

    return data;
  }
}