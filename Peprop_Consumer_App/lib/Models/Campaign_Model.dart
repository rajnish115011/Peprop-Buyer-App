

class Campaign_Model{
  String type_id="";
  String type_name="";
  String parent="";
  String banner="";



  Campaign_Model({required this.type_id, required this.type_name,required this.parent,required this.banner});
  factory Campaign_Model.fromJson(Map<String, dynamic> json) {
    return Campaign_Model(
      type_id: json["type_id"].toString(),
      type_name: json["type_name"].toString().replaceAll("null", ""),
      parent: json["parent"].toString().replaceAll("null", "0"),
      banner: json["banner"].toString().replaceAll("null", "0"),



    );
  }
}


class Offers_List_Refer{
  String id="";
  String offer_title="";
  String offer_description="";
  String offer_details="";
  String offer_banner="";
  String rewards_budget="";
  String referrer_rewards="";
  String referee_rewards="";
  String google_playstore="";
  String offer_type="";
  String reward_type="";



  bool is_spin=false;
  bool click=false;


  List<Partitions>partitions=[];




  Offers_List_Refer.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    offer_title= json["offer_title"].toString();
    offer_description= json["offer_description"].toString();
    offer_details= json["offer_details"].toString();
    offer_banner= json["offer_banner"].toString();
    rewards_budget= json["rewards_budget"].toString();
    referrer_rewards= json["referrer_rewards"].toString();
    referee_rewards= json["referee_rewards"].toString();
    google_playstore= json["google_playstore"].toString();
    offer_type= json["offer_type"].toString();
    reward_type= json["reward_type"].toString();


    if(json["partitions"]!=null&&json["partitions"]!="")
    partitions= json["partitions"].map<Partitions>((json) => Partitions.fromJson(json)).toList();


   }
}

class Partitions {
  String partition_title="";
  String partition_bgcolor="";
  String partition_points="";

  Partitions.fromJson(Map<String, dynamic> json) {
    partition_title= json["partition_title"].toString();
    partition_bgcolor= json["partition_bgcolor"].toString();
    partition_points= json["partition_points"].toString();


  }
}