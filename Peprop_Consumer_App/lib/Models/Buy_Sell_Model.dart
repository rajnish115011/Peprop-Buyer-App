



class Buy_Sell_Model{
  String furnishing_types_name="";
  String area_type_name="";
  String id="";
  String budget="";
  String prefered_floor="";
  String bedroom="";
  String area="";
  String city_name="";
  String loc_name="";
  String proj_name="";
  String perpose="";
  String source="";
  String proj_type_name="";
  String PropertType="";
  String lease="";
  String residential="";
  String commercial="";
  String created_on="";
  String possession_by="";


  List<dynamic>photo=[];






  Buy_Sell_Model({required this.furnishing_types_name, required this.area_type_name,required this.id,required this.budget,
    required this.prefered_floor, required this.bedroom,required this.area,required this.city_name,
    required this.loc_name, required this.proj_name,required this.perpose,required this.source,
    required this.proj_type_name, required this.PropertType,required this.lease,required this.residential,required this.commercial,required this.created_on,required this.possession_by,required this.photo});
  factory Buy_Sell_Model.fromJson(Map<String, dynamic> json) {
    return Buy_Sell_Model(
      furnishing_types_name: json["furnishing_types_name"].toString(),
      area_type_name: json["area_type_name"].toString().replaceAll("null", "N/A"),
      id: json["id"].toString().replaceAll("null", "N/A"),
      budget: json["budget"].toString().replaceAll("0.00", "N/A"),
      prefered_floor: json["prefered_floor"].toString().replaceAll("null", "N/A"),
      bedroom: json["bedroom"].toString().replaceAll("null", "N/A"),
      area: json["area"].toString().replaceAll("null", "N/A"),
      city_name: json["city_name"].toString().replaceAll("null", "N/A"),
      loc_name: json["loc_name"].toString().replaceAll("null", "N/A").replaceAll("0", "N/A"),
      proj_name: json["proj_name"].toString().replaceAll("null", "N/A").toString().replaceAll("0", ""),
      perpose: json["perpose"].toString().replaceAll("null", "N/A"),
      source: json["source"].toString().replaceAll("null", "N/A"),
      proj_type_name: json["proj_type_name"].toString().replaceAll("null", "N/A"),
      PropertType: json["PropertType"].toString().replaceAll("null", "N/A"),
      lease: json["lease"].toString().replaceAll("null", "N/A"),
      residential: json["residential"].toString().replaceAll("null", "N/A"),
      commercial: json["commercial"].toString().replaceAll("null", "N/A"),
      created_on: json["created_on"].toString().replaceAll("null", "N/A"),
      possession_by: json["possession_by"].toString().replaceAll("null", "N/A"),
      photo: json["photo"],


    );
  }
}