


class Ecommerce_Model {

  String id="";
  String name="";
  String logo="";
  int selected=0;


  List<String>banner=[];


  List<Brand_Model>brand_list=[];

  Ecommerce_Model.fromJson(Map<String, dynamic> json) {
  id= json["id"].toString();
  name= json["name"].toString();
  logo= json["logo"].toString();
  banner= json["banner"].toString().split(",");
  print("banner"+banner.toString());

  if (json['brand'] != null&&json["brand"]!="")
  {json['brand'].forEach((v) {brand_list.add(new Brand_Model.fromJson(v));});}


  }


}



class Brand_Model {

  String id="";
  String name="";
  String logo="";
  List<String>banner=[];
  List<Varient_Model>varient_list=[];
  Brand_Model.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    name= json["name"].toString();
    logo= json["logo"].toString();
    banner= json["banner"].toString().split(",");

    if (json['variant'] != null&&json["variant"]!="")
    {json['variant'].forEach((v) {varient_list.add(new Varient_Model.fromJson(v));});}


  }


}


class Varient_Model {

  String id="";
  String name="";
  String logo="";
  String banner="";

  Varient_Model.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    name= json["name"].toString();
    logo= json["logo"].toString();
    banner= json["banner"].toString();



  }


}


class Product_Model {




  String id="";
  String title="";
  String sub_title="";
  String category="";

  double?rating;

  List<dynamic>colors=[];

  String price="";
  String discount_price="";


  List<String>image=[];


  String feature="";
  String available_model="";

  String specification="";
  String created_at="";
  String warranty_text="";
  String cashback="";
  String seller_name="";
  String discount="";





  Product_Model.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    title= json["title"].toString().replaceAll("null", "");
    sub_title= json["sub_title"].toString().replaceAll("null", "");
    discount_price= json["discount_price"].toString().replaceAll("null", "");


    if(json["colors"]!=null&&json["colors"]!="")colors= json["colors"];
    price= json["price"].toString();
    image= json["image"].toString().split(",");
    feature= json["feature"].toString();
    specification= json["specification"].toString();
    created_at= json["created_at"].toString();
    available_model= json["available_model"].toString();

    warranty_text= json["warranty_text"].toString();
    cashback= json["cashback"].toString();
    category= json["brand"].toString();
    seller_name= json["seller_name"].toString();
    discount= json["discount"].toString().replaceAll("null", "");


    if(json["rating"]!=null)rating= double.parse(json["rating"].toString());





  }


}