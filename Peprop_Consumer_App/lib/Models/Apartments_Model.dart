import 'package:flutter/material.dart';

class Apartments_Model {

  String ID="";
  String PropertyTitle="";
  String builder_name="";
  String builder_logo="";
  String ProjectStatus="";
  String Address="";
  String BannerImage="";
  String key_feature1="";
  String key_feature2="";
  String key_feature3="";
  String key_feature4="";
  String key_feature5="";
  String FeaturedImage="";
  String PropertyFor="";

  Color?color;


  String title="";
  String banner="";
  String banner_url="";
  String no_of_column="";
  String type="";

  String banner_type="";
  String property_save_later="";

  String information_only_status="";
  String booking_option="";



  List<PriceList>priceList=[];
  List<Offers>offer_list=[];
  Apartments_Model({required this.ID, required this.PropertyTitle,required this.builder_name,required this.builder_logo,
    required this.ProjectStatus,required this.Address,required this.BannerImage,
    required this.key_feature1,required this.key_feature2,required this.key_feature3,required this.key_feature4,
    required this.key_feature5,required this.FeaturedImage,
    required this.priceList,required this.offer_list,required this.PropertyFor,
    required this.title,
    required this.banner,
    required this.banner_url,
    required this.no_of_column,
    required this.type,
    required this.banner_type,
    required this.property_save_later,

    required this.information_only_status,
    required this.booking_option,



  });

  factory Apartments_Model.fromJson(Map<String, dynamic> json) {
    return Apartments_Model(
      ID: json["ID"].toString(),
      PropertyTitle: json["PropertyTitle"].toString().replaceAll("null", "N/A"),
      builder_name: json["builder_name"].toString().replaceAll("null", "N/A"),
      builder_logo: json["builder_logo"].toString().replaceAll("null", "N/A"),
      ProjectStatus: json["ProjectStatus"].toString().replaceAll("null", "N/A"),
      Address: json["Address"].toString().replaceAll("null", "N/A"),
      BannerImage: json["FeatureImageUrl"].toString().replaceAll("null", "N/A"),
      key_feature1: json["key_feature1"].toString().replaceAll("null", ""),
      key_feature2: json["key_feature2"].toString().replaceAll("null", ""),
      key_feature3: json["key_feature3"].toString().replaceAll("null", ""),
      key_feature4: json["key_feature4"].toString().replaceAll("null", ""),
      key_feature5: json["key_feature5"].toString().replaceAll("null", ""),
      FeaturedImage: json["FeaturedImage"].toString().replaceAll("null", "N/A"),



      priceList : json["PriceList"]!=null? json["PriceList"].map<PriceList>((json) => PriceList.fromJson(json)).toList():[],
      offer_list : json["Offers"]!=null? json["Offers"].map<Offers>((json) => Offers.fromJson(json)).toList():[],
      PropertyFor: json["PropertyFor"].toString().replaceAll("null", "N/A"),


      title: json["title"].toString().replaceAll("null", "N/A"),
      banner: json["banner"].toString().replaceAll("null", "N/A"),
      banner_url: json["banner_url"].toString().replaceAll("null", "N/A"),
      no_of_column: json["no_of_column"].toString().replaceAll("null", "N/A"),
      type: json["type"].toString().replaceAll("null", "N/A"),
      banner_type: json["banner_type"].toString().replaceAll("null", "N/A"),
      property_save_later: json["property_save_later"].toString().replaceAll("null", "N/A"),
      information_only_status: json["information_only_status"].toString().replaceAll("null", "N/A"),

      booking_option: json["booking_option"].toString().replaceAll("null", "N/A"),



    );
  }


}

class PriceList {
  String id="";
  String unit_price="";
  String prop_unit_size="";

  String unit_name="";
  String CurrencyName="";
  String PropertymapImage="";
  String name;
  String unit_measurement;


  PriceList({required this.id, required this.unit_price,required this.prop_unit_size,required this.unit_name,
    required this.CurrencyName,required this.PropertymapImage,
    required this.name, required this.unit_measurement});

  factory PriceList.fromJson(Map<String, dynamic> json) {
    return PriceList(
      id: json["id"].toString(),
      unit_price: json["unit_price"].toString().replaceAll("null", ""),
      prop_unit_size: json["prop_unit_size"].toString().replaceAll("null", ""),
      unit_name: json["unit_name"].toString().replaceAll("null", ""),
      CurrencyName: json["CurrencyName"].toString().replaceAll("null", "").replaceAll("INR(₹)", "₹"),
      PropertymapImage: json["property_map_img"].toString().replaceAll("null", ""),
      name: json["name"].toString().replaceAll("null", ""),
      unit_measurement: json["unit_measurement"].toString().replaceAll("null", ""),



    );
  }


}
class Payment_option_other {
  String company_name="";
  String bank_name="";
  String account_no="";
  String ifsc_code="";

  Payment_option_other({required this.company_name, required this.bank_name,required this.account_no,required this.ifsc_code,
    });

  factory Payment_option_other.fromJson(Map<String, dynamic> json) {
    return Payment_option_other(
      company_name: json["company_name"].toString(),
      bank_name: json["bank_name"].toString().replaceAll("null", ""),
      account_no: json["account_no"].toString().replaceAll("null", ""),
      ifsc_code: json["ifsc_code"].toString().replaceAll("null", ""),



    );
  }


}




class Offers {

  String offer_title="";
  String offer_type="";
  String offer_from="";
  String offer_to="";


  Offers({required this.offer_title, required this.offer_type,required this.offer_from,required this.offer_to,
  });

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
      offer_title: json["offer_title"].toString(),
      offer_type: json["offer_type"].toString().replaceAll("null", ""),
      offer_from: json["offer_from"].toString().replaceAll("null", ""),
      offer_to: json["offer_to"].toString().replaceAll("null", ""),



    );
  }


}
class Bank_loan {

  String bank_id="";
  String bank_name="";
  String bank_image="";



  Bank_loan({required this.bank_id, required this.bank_name,required this.bank_image
  });

  factory Bank_loan.fromJson(Map<String, dynamic> json) {
    return Bank_loan(
      bank_id: json["bank_id"].toString(),
      bank_name: json["bank_name"].toString().replaceAll("null", ""),
      bank_image: json["bank_image"].toString().replaceAll("null", ""),


    );
  }


}

class Property_Rewards {

  String title="";
  String desc="";
  String value="";



  Property_Rewards({required this.title, required this.desc,required this.value
  });

  factory Property_Rewards.fromJson(Map<String, dynamic> json) {
    return Property_Rewards(
      title: json["title"].toString(),
      desc: json["desc"].toString().replaceAll("null", ""),
      value: json["value"].toString().replaceAll("null", ""),


    );
  }


}


class TC_Model {

  String tower_name;
  String tower_map;
  TC_Model({required this.tower_name,required this.tower_map });

  factory TC_Model.fromJson(Map<String, dynamic> json) {
    return TC_Model(

      tower_name:json["tower_name"],
      tower_map: json["tower_map"],


    );
  }


}