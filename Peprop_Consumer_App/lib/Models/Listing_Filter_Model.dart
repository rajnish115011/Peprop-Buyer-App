class Listing_Filter_Model {
  String listing_type="1";
  bool listing_checked=true;

  int filter_type=1;
  String city="";
  double min_budget=0;
  double max_buget=200000000;

  double min_area=0;
  double max_area=5000;
  List<Room_Type_Model>room_list=[];
  List<PropertyType>res=[];
  List<PropertyType>com=[];
  List<Room_Type_Model>posted_by=[];
  List<Measurement_Unit>measurement=[];
  List<FurnishingMaster>furnishing=[];
  List<FurnishingMaster>project_status=[];
  List<Availability_Model>availability=[];
  String order_by="ASC";


  bool filter_apply=false;
  String legal="";

  bool is_direct_open=false;


  String area_id="2";
  String area_name="Sq.ft.";
  String prop_name="";


}
class Room_Type_Model{
  String unit_type="";
  bool checked=false;
  Room_Type_Model(String unit_type,bool checked){
    this.unit_type=unit_type;
    this.checked=checked;


  }

}
class PropertyType{
  String ID="";
  String property_category_id="";
  String PropertType="";
  String id="";


  bool checked=false;

  PropertyType({required this.ID, required this.property_category_id,required this.PropertType,required this.id});
  factory PropertyType.fromJson(Map<String, dynamic> json) {
    return PropertyType(
      ID: json["ID"].toString(),
      property_category_id: json["property_category_id"].toString(),
      PropertType: json["PropertType"].toString(),
      id: json["id"].toString(),


    );

  }



}
class Measurement_Unit{
  String id="";
  String name="";
  Measurement_Unit({required this.id, required this.name});
  factory Measurement_Unit.fromJson(Map<String, dynamic> json) {
    return Measurement_Unit(
      id: json["id"].toString(),
      name: json["name"].toString(),


    );

  }



}
class FurnishingMaster{
  String id="";
  String furnishing_name="";
  bool checked=false;
  String name="";

  FurnishingMaster({required this.id, required this.furnishing_name, required this.name});
  factory FurnishingMaster.fromJson(Map<String, dynamic> json) {
    return FurnishingMaster(
      id: json["id"].toString(),
      furnishing_name: json["furnishing_name"].toString(),
      name: json["name"].toString(),


    );

  }





}
class Availability_Model{
  String id="";
  String name="";
  Availability_Model({required this.id, required this.name});
  factory Availability_Model.fromJson(Map<String, dynamic> json) {
    return Availability_Model(
      id: json["id"].toString(),
      name: json["name"].toString(),


    );

  }

}

class Furnishing_Model{
  String id="";
  String name="";
  Furnishing_Model({required this.id, required this.name});
  factory Furnishing_Model.fromJson(Map<String, dynamic> json) {
    return Furnishing_Model(
      id: json["id"].toString(),
      name: json["furnishing_name"].toString(),


    );

  }

}