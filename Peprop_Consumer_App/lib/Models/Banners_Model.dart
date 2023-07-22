

class Banners_Model{
  String? type;
  String? name;
  String? img;
  String? s_type;
  Banners_Model({required this.type, required this.name,required this.img,required this.s_type});
  factory Banners_Model.fromJson(Map<String, dynamic> json) {
    return Banners_Model(
      type: json["type"].toString(),
      name: json["name"].toString().replaceAll("null", "N/A"),
      img: json["img"].toString().replaceAll("null", "N/A"),
      s_type: json["s_type"].toString().replaceAll("null", "N/A"),


    );
  }


}