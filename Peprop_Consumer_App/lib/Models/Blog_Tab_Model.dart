class Blog_Tab_Model {
  String id="";
  String name="";

  Blog_Tab_Model({required this.id, required this.name});
  factory Blog_Tab_Model.fromJson(Map<String, dynamic> json) {
    return Blog_Tab_Model(
      id: json["id"].toString(),
      name: json["name"].toString().replaceAll("null", "N/A"),
    );
  }

}
class Legal_model {
  String id="";
  String name="";

  Legal_model({required this.id, required this.name});
  factory Legal_model.fromJson(Map<String, dynamic> json) {
    return Legal_model(
      id: json["id"].toString(),
      name: json["legal_name"].toString().replaceAll("null", "N/A"),
    );
  }

}