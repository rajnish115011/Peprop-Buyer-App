class Aminities_Model {
  String name="";
  String logo_image="";
  String cat_name="";
  Aminities_Model({required this.name, required this.logo_image,required this.cat_name});
  factory Aminities_Model.fromJson(Map<String, dynamic> json) {
    return Aminities_Model(
      name: json["name"].toString(),
      logo_image: json["logo_image"].toString().replaceAll("null", "N/A"),
      cat_name: json["cat_name"].toString().replaceAll("null", "N/A"),


    );
  }

}
class Menu_Slider_Model {
  String id="";
  String slider_img="";
  String slider_url="";
  String menu_id="";
  Menu_Slider_Model({required this.id, required this.slider_img,required this.slider_url,required this.menu_id});
  factory Menu_Slider_Model.fromJson(Map<String, dynamic> json) {
    return Menu_Slider_Model(
      id: json["id"].toString(),
      slider_img: json["slider_img"].toString().replaceAll("null", "N/A"),
      slider_url: json["slider_url"].toString().replaceAll("null", "N/A"),
      menu_id: json["menu_id"].toString().replaceAll("null", "N/A"),
    );
  }

}

