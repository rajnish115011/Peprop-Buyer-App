class City_Model{
  String city_name="";
  String city_id="";
  String state_name="";
  String state_id="";
  String country_id="";
  String country_name="";
  String property_count="";


  City_Model({required this.city_name, required this.city_id,
    required this.state_name,required this.state_id,required this.country_id,required this.country_name,required this.property_count});
  factory City_Model.fromJson(Map<String, dynamic> json) {
    return City_Model(
      city_name: json["city_name"].toString().replaceAll("null", "N/A"),
      city_id: json["city_id"].toString().replaceAll("null", "N/A"),
      state_name: json["state_name"].toString().replaceAll("null", "N/A"),
      state_id: json["state_id"].toString().replaceAll("null", "N/A"),
      country_id: json["country_id"].toString().replaceAll("null", "N/A"),
      country_name: json["country_name"].toString().replaceAll("null", "N/A"),
      property_count: json["property_count"].toString().replaceAll("null", "N/A"),


    );
  }

}