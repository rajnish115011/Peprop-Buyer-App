

import 'dart:ui';

class Luck{
  final String image;
  final Color color;

  Luck(this.image, this.color);


  String get asset =>  "asset/image/$image.png";
}


class Coupon_Categepry_Model{
  String id="";
  String cat_name="";
  String img_path="";

  String parent="";

  List<dynamic>banner_multiple=[];


  Coupon_Categepry_Model({required this.id,required this.cat_name,required this.img_path,required this.parent});



       Coupon_Categepry_Model.fromJson(Map<String, dynamic> json) {
       id= json["id"].toString();
       cat_name= json["cat_name"].toString();
       img_path= json["img_path"].toString();
       parent= json["parent"].toString();
       banner_multiple= json["banner_multiple"];


       }
}

class Coupons{




  String is_viewed="";
  String id="";
  String RewardID="";
  String BrandName="";
  String RewardCode="";
  String RewardTitle="";
  String StepsToRedeem="";
  String RewardDescription="";
  String BrandLogo="";
  String BrandImage="";
  String Link="";
  String ExpiryDate="";
  String IsUniqueCode="";
  String created_at="";
  String assigned_at="";
  String pin="";
  String lead_id="";


  List<dynamic> banner_multiple=[];

  bool is_locked=false;





  Coupons.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    RewardID= json["RewardID"].toString().toString().replaceAll("null", "");
    BrandName= json["BrandName"].toString().toString().replaceAll("null", "");
    RewardCode= json["RewardCode"].toString().toString().replaceAll("null", "");
    RewardTitle= json["RewardTitle"].toString().toString().replaceAll("null", "");
    StepsToRedeem= json["StepsToRedeem"].toString().replaceAll("null", "");
    RewardDescription= json["RewardDescription"].toString().replaceAll("null", "");
    BrandLogo= json["BrandLogo"].toString().toString().replaceAll("null", "");
    BrandImage= json["BrandImage"].toString().toString().replaceAll("null", "");
    Link= json["Link"].toString().toString().replaceAll("null", "");
    ExpiryDate= json["ExpiryDate"].toString().toString().replaceAll("null", "");
    IsUniqueCode= json["IsUniqueCode"].toString().toString().replaceAll("null", "");
    created_at= json["created_at"].toString();
    assigned_at= json["assigned_at"].toString().replaceAll("null", "");
    lead_id= json["lead_id"].toString().replaceAll("null", "");
    is_viewed= json["is_viewed"].toString().replaceAll("null", "");


    if(json["banner_multiple"]!=null&&json["banner_multiple"]!="")
      banner_multiple= json["banner_multiple"];



  }
}


class Orders{



  String id="";

  String price="";
  String created_at="";
  String title="";
  String image="";

  String ship_address="";
  String cancel="";
  String shipping="";
  String seller_name="";







  Orders.fromJson(Map<String, dynamic> json) {
    price= json["price"].toString();
    created_at= json["created_at"].toString().toString().replaceAll("null", "");
    title= json["title"].toString().toString().replaceAll("null", "");
    image= json["image"].toString().toString().replaceAll("null", "");
    ship_address= json["ship_address"].toString().toString().replaceAll("null", "");
    cancel= json["cancel"].toString().toString().replaceAll("null", "");
    shipping= json["shipping"].toString().toString().replaceAll("null", "");
    seller_name= json["seller_name"].toString().toString().replaceAll("null", "");
    id= json["id"].toString().toString().replaceAll("null", "");




  }
}


class Gift_Card{







  String is_viewed="";
  String id="";
  String ProductID="";
  String BrandName="";
  String RewardTitle="";
  String StepsToRedeem="";
  String RewardDescription="";
  String BrandLogo="";
  String BrandImage="";

  String validity_duration="";



  bool locked=false;


  String created_at="";
  String assigned_at="";

  List<dynamic> banner_multiple=[];

  List<Demon> denomination=[];
  bool is_locked=false;


  String Denomination="";

  String request_time="";


  String coupon_code="";
  String coupon_pin="";
  String use_validity="";

  String Link="";

  String valid_on="";
  String payment_info="";
  String lead_id="";






  Gift_Card.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    ProductID= json["ProductID"].toString();
    BrandName= json["BrandName"].toString();
    RewardTitle= json["RewardTitle"].toString().toString().replaceAll("null", "");
    StepsToRedeem= json["StepsToRedeem"].toString().replaceAll("null", "");
    RewardDescription= json["RewardDescription"].toString().replaceAll("null", "");
    BrandLogo= json["BrandLogo"].toString();
    BrandImage= json["BrandImage"].toString();
    created_at= json["created_at"].toString();
    assigned_at= json["assigned_at"].toString().replaceAll("null", "");
    request_time= json["request_time"].toString().replaceAll("null", "");
    Denomination= json["redeem_denominations_value"].toString().replaceAll("null", "");
    use_validity= json["use_validity"].toString().replaceAll("null", "");
    Link= json["Link"].toString().replaceAll("null", "");
    validity_duration= json["validity_duration"].toString().replaceAll("null", "");
    valid_on= json["valid_on"].toString().replaceAll("null", "");
    payment_info= json["payment_info"].toString().replaceAll("null", "");
    lead_id= json["lead_id"].toString().replaceAll("null", "");
    is_viewed= json["is_viewed"].toString().replaceAll("null", "");






    coupon_code= json["coupon_code"].toString().replaceAll("null", "0");

    coupon_pin= json["coupon_pin"].toString().replaceAll("null", "");

    if (json['Denomination'] != null&&json["Denomination"]!="")
    {json['Denomination'].forEach((v) {denomination.add(new Demon.fromJson(v));});}





    if(json["banner_multiple"]!=null&&json["banner_multiple"]!="")
      banner_multiple= json["banner_multiple"];



  }
}


class Demon{

  String id="";
  String ProductID="";
  String Denomination="";




  Demon.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    ProductID= json["ProductID"].toString();
    Denomination= json["Denomination"].toString();




  }
}




class Offers{
  String id="";
  String coupon_rule_id="";
  String benefits="";
  String how_to_avail="";
  String tnc="";
  String benefits_code="";







  Offers.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    coupon_rule_id= json["coupon_rule_id"].toString();
    benefits= json["benefits"].toString();
    how_to_avail= json["how_to_avail"].toString();
    tnc= json["tnc"].toString();
    benefits_code= json["benefits_code"].toString().replaceAll("null", "");





  }
}
