class BrokerPropertiesModel {
  String? reqId;
  String? iD;
  String? propertyname;
  String? address;
  String? image;
  String? broker_count;
  String? fullname;
  String? inv_count;

  BrokerPropertiesModel({this.reqId, this.iD, this.propertyname, this.address, this.image,this.broker_count});

  BrokerPropertiesModel.fromJson(Map<String, dynamic> json) {
    reqId = json['req_id'];
    iD = json['ID'];
    propertyname = json['propertyname'];
    address = json['Address'];
    image = json['image'];
    broker_count = json['broker_count'].toString();
    fullname = json['fullname'].toString();
    inv_count = json['inv_count'].toString();



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['req_id'] = this.reqId;
    data['ID'] = this.iD;
    data['propertyname'] = this.propertyname;
    data['Address'] = this.address;
    data['image'] = this.image;
    return data;
  }
}


class Sussgested_Model {
  String? propertyTitle;
  String? proj_type_name;
  String? builder_name;
  String? builder_city;
  String? id;
  String? FeaturedImage;
  String? PropertyFor;
  String? StateName;
  String? CountryName;




  Sussgested_Model({this.propertyTitle, this.proj_type_name, this.builder_name, this.builder_city, this.id, this.FeaturedImage,required this.PropertyFor});

  Sussgested_Model.fromJson(Map<String, dynamic> json) {
    propertyTitle = json['propertyTitle'].toString();
    proj_type_name = json['proj_type_name'].toString();
    builder_name = json['builder_name'].toString();
    builder_city = json['city_name'].toString();
    id = json['id'].toString();
    FeaturedImage = json['FeaturedImage'].toString();
    PropertyFor = json['PropertyFor'].toString();
    StateName = json['StateName'].toString();
    CountryName = json['CountryName'].toString();


  }


}