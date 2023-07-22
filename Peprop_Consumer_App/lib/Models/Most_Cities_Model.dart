class Most_Cities_Model {
  String image="";
  String city_name="";

  Most_Cities_Model({required this.image, required this.city_name});
  factory Most_Cities_Model.fromJson(Map<String, dynamic> json) {
    return Most_Cities_Model(
      image: json["image"].toString(),
      city_name: json["city_name"].toString().replaceAll("null", "N/A"),


    );
  }

}

class Event_Model {
  String id="";
  String event_name="";
  String banner="";

  Event_Model({required this.id, required this.event_name,required this.banner});
  factory Event_Model.fromJson(Map<String, dynamic> json) {
    return Event_Model(
      id: json["id"].toString(),
      event_name: json["event_name"].toString().replaceAll("null", "N/A"),
      banner: json["banner"].toString().replaceAll("null", "N/A"),


    );
  }

}