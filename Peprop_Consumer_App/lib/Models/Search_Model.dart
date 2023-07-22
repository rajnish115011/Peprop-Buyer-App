class Search_Model{
  String id="";
  String builder_name="";
  String property_name="";
  String property_type="";
  String location="";
  String city="";
  String PropertyTitle="";
  String Address="";



  Search_Model({required this.id, required this.builder_name, required this.property_name,required this.property_type,required this.location,required this.city,required this.PropertyTitle,required this.Address});
  factory Search_Model.fromJson(Map<String, dynamic> json) {
    return Search_Model(
      id: json["id"].toString(),
      builder_name: json["builder_name"].toString(),
      property_name: json["property_name"].toString(),
      property_type: json["property_type"].toString(),
      location: json["location"].toString(),
      city: json["city"].toString(),
      PropertyTitle: json["PropertyTitle"].toString(),
      Address: json["Address"].toString(),


    );
  }

}