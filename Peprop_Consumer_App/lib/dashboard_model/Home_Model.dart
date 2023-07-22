

import '../Models/Aminities_Model.dart';

class Home_Model{
  String title="";
  String type="";
  String section_id="";
  int num_of_column=0;
  List<Home_List_Model>list=[];
  String earn_points="0";
  String redeem_points="0";
  String balance_points="0";

}
class Home_List_Model{


  String id="";
  String section_id="";
  String title="";
  String alt="";
  String bg_icon="";
  String icon="";
  String banner="";
  String sort_by="";
  String status="";
  String is_deleted="";
  String type="";
  String no_of_column="";
  List<Menu_Slider_Model>sliders = [];
      Home_List_Model.fromJson(Map<String, dynamic> json) {
      id= json["id"].toString();
      section_id= json["section_id"].toString().replaceAll("null", "N/A");
      title= json["title"].toString().replaceAll("null", "N/A");
      alt= json["alt"].toString().replaceAll("null", "N/A");
      bg_icon= json["bg_icon"].toString().replaceAll("null", "N/A");
      icon= json["icon"].toString().replaceAll("null", "N/A");
      banner= json["banner"].toString().replaceAll("null", "N/A");
      sort_by= json["sort_by"].toString().replaceAll("null", "N/A");
      status= json["status"].toString().replaceAll("null", "N/A");
      is_deleted= json["is_deleted"].toString().replaceAll("null", "N/A");
      type= json["type"].toString().replaceAll("null", "N/A");
      no_of_column= json["no_of_column"].toString().replaceAll("null", "N/A");
      if (json['slider'] != null) {

        sliders = <Menu_Slider_Model>[];
        json['slider'].forEach((v) {
           sliders.add(new Menu_Slider_Model.fromJson(v));
           print(id+sliders.length.toString());
        });
      }

    }





}

