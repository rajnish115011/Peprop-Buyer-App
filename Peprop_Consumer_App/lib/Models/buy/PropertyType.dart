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