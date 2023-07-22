

import 'package:peprop_consumer_app/Models/Apartments_Model.dart';

import '../dashboard_model/Home_Model.dart';

class View_Property_Model{

  String? discount;
  String? BuilderId;
  String? fullname;

  String? comp_name;

  String? property_tnc;



  String? discount_value;
  String? cashback;
  String? cashback_value;
  String? key_feature1;
  String? key_feature2;
  String? key_feature3;
  String? key_feature4;
  String? key_feature5;
  String? ProjectStatus;

  String? furnishing_name;

  String? PropertyType;
  String? PropertyTitle;

  String? loc_name;
  String? city_name;
  String? state_name;
  String? country_name;
  List<PriceList>priceList=[];
  List<Payment_option_other>payment_option_other=[];



  String? PropertyTypeName;
  String? PropertyFor;
  String? refundable;
  String? refundable_duration;
  String? Ref_term_condn;
  String? booking_term_cond;
  List<Bank_loan>bank_loan=[];
  List<dynamic>payment_option_mode=[];
  int selected_account=-1;
  String? booking_partner_name;
  String? booking_partner_rera;
  String? booking_partner_mobile;
  String? booking_partner_email;
  String? FeatureImageUrl;
  String? logo;
  String? Rera;
  String? booking_max_amount;
  String? booking_min_amount;
  String? invoice_insurance;



  List<List_Of_Price>price_of_list=[];
  List<dynamic>gallery_list=[];
  String? discount_visibility;
  String? cashback_visibility;
  String? broker_visibility;
  String? broker_discount_value;


  String? builder_visibility;


  List<Property_Rewards>property_rewards=[];











  View_Property_Model.fromJson(Map<String, dynamic> json) {
    discount = json['discount'].toString().replaceAll("null", "");
    discount_value = json['discount_value'].toString().replaceAll("null", "");
    cashback = json['cashback'].toString().replaceAll("null", "");
    cashback_value = json['cashback_value'].toString().replaceAll("null", "");
    key_feature1 = json['key_feature1'].toString().replaceAll("null", "");
    key_feature2 = json['key_feature2'].toString().replaceAll("null", "");
    key_feature3 = json['key_feature3'].toString().replaceAll("null", "");
    key_feature4 = json['key_feature4'].toString().replaceAll("null", "");
    key_feature5 = json['key_feature5'].toString().replaceAll("null", "");
    ProjectStatus = json['ProjectStatus'].toString().replaceAll("null", "");
    furnishing_name = json['furnishing_name'].toString().replaceAll("null", "");
    PropertyType = json['PropertyType'].toString().replaceAll("null", "");
    PropertyTitle = json['PropertyTitle'].toString().replaceAll("null", "");
    loc_name = json['loc_name'].toString().replaceAll("null", "");
    city_name = json['city_name'].toString().replaceAll("null", "");
    state_name = json['state_name'].toString().replaceAll("null", "");
    country_name = json['country_name'].toString().replaceAll("null", "");
    property_tnc = json['property_tnc'].toString().replaceAll("null", "");


    if (json['PriceList'] != null) {json['PriceList'].forEach((v) {priceList.add(new PriceList.fromJson(v));});}

    PropertyTypeName = json['PropertyTypeName'].toString().replaceAll("null", "");
    PropertyFor = json['PropertyFor'].toString().replaceAll("null", "");

    refundable = json['refundable'].toString().replaceAll("null", "");
    refundable_duration = json['refundable_duration'].toString().replaceAll("null", "");
    Ref_term_condn = json['Ref_term_condn'].toString().replaceAll("null", "");
    booking_term_cond = json['booking_term_cond'].toString().replaceAll("null", "");

    fullname = json['fullname'].toString().replaceAll("null", "");

    comp_name = json['comp_name'].toString().replaceAll("null", "");



    BuilderId = json['BuilderId'].toString().replaceAll("null", "");
    booking_partner_name = json['booking_partner_name'].toString().replaceAll("null", "");
    booking_partner_rera = json['booking_partner_rera'].toString().replaceAll("null", "");
    booking_partner_mobile = json['booking_partner_mobile'].toString().replaceAll("null", "");
    booking_partner_email = json['booking_partner_email'].toString().replaceAll("null", "");
    FeatureImageUrl=json["FeaturedImage"].toString().toString().replaceAll("null", "");
    logo=json["builder_logo"].toString();
    Rera=json["Rera"].toString();
    booking_max_amount=json["booking_max_amount"].toString().toString().replaceAll("null", "");
    booking_min_amount=json["booking_min_amount"].toString().toString().replaceAll("null", "");
    invoice_insurance=json["invoice_insurance"].toString().toString().replaceAll("null", "");
    discount_visibility=json["discount_visibility"].toString().toString();
    cashback_visibility=json["cashback_visibility"].toString().toString();
    broker_visibility=json["broker_visibility"].toString().toString();
    broker_discount_value=json["broker_discount_value"].toString().toString();
    builder_visibility=json["builder_visibility"].toString().toString();






    if(json['payment_option_other']!=null) {json['payment_option_other'].forEach((v) {payment_option_other.add(new Payment_option_other.fromJson(v));});}







    if (json['bank_loan'] != null) {
      bank_loan = <Bank_loan>[];
      json['bank_loan'].forEach((v) {
        bank_loan.add(new Bank_loan.fromJson(v));
      });
    }
    if (json['property_rewards'] != null) {
      property_rewards.clear();
      json['property_rewards'].forEach((v) {
        property_rewards.add(new Property_Rewards.fromJson(v));
      });
    }




    try{
      Map mapValue =json["SizeListByType"];
      if(mapValue.length>0){
        mapValue.forEach((key, value) {
          String heading=key.toString();
          List_Of_Price model=new List_Of_Price();
          var data =value as List;
          List<PriceList>l = data.map<PriceList>((json) => PriceList.fromJson(json)).toList();
          model.name=heading;
          model.list=l;
          price_of_list.add(model);

        });

      }
    }catch(e){

    }


    if(json["payment_option_mode"]!=null){
      payment_option_mode= json["payment_option_mode"];
    }

    if(json["gallery"]!=null){
      gallery_list= json["gallery"];
    }
  }
}


class View_Property_Model1{

  String? discount;
  String? BuilderId;

  String? discount_value;
  String? cashback;
  String? cashback_value;
  String? key_feature1;
  String? key_feature2;
  String? key_feature3;
  String? key_feature4;
  String? key_feature5;
  String? ProjectStatus;

  String? furnishing_name;

  String? PropertyType;
  String? PropertyTitle;

  String? loc_name;
  String? city_name;
  String? state_name;
  String? country_name;
  List<PriceList>priceList=[];
  List<Payment_option_other>payment_option_other=[];



  String? PropertyTypeName;
  String? PropertyFor;
  String? refundable;
  String? refundable_duration;
  String? Ref_term_condn;
  String? booking_term_cond;
  List<Bank_loan>bank_loan=[];


  int selected_account=-1;


  String? booking_partner_name;
  String? booking_partner_rera;
  String? booking_partner_mobile;
  String? booking_partner_email;
  String? FeatureImageUrl;
  String? logo;
  String? Rera;
  String? booking_max_amount;
  String? booking_min_amount;
  String? invoice_insurance;



  List<List_Of_Price>price_of_list=[];
  List<dynamic>gallery_list=[];
  List<Property_Rewards>property_rewards=[];





  View_Property_Model1.fromJson(Map<String, dynamic> json) {
    discount = json['discount'].toString().replaceAll("null", "");
    discount_value = json['discount_value'].toString().replaceAll("null", "");
    cashback = json['cashback'].toString().replaceAll("null", "");
    cashback_value = json['cashback_value'].toString().replaceAll("null", "");
    key_feature1 = json['key_feature1'].toString().replaceAll("null", "");
    key_feature2 = json['key_feature2'].toString().replaceAll("null", "");
    key_feature3 = json['key_feature3'].toString().replaceAll("null", "");
    key_feature4 = json['key_feature4'].toString().replaceAll("null", "");
    key_feature5 = json['key_feature5'].toString().replaceAll("null", "");
    ProjectStatus = json['ProjectStatus'].toString().replaceAll("null", "");
    furnishing_name = json['furnishing_name'].toString().replaceAll("null", "");
    PropertyType = json['PropertyType'].toString().replaceAll("null", "");
    PropertyTitle = json['PropertyTitle'].toString().replaceAll("null", "");
    loc_name = json['loc_name'].toString().replaceAll("null", "");
    city_name = json['city_name'].toString().replaceAll("null", "");
    state_name = json['state_name'].toString().replaceAll("null", "");
    country_name = json['country_name'].toString().replaceAll("null", "");
    if (json['PriceList'] != null) {json['PriceList'].forEach((v) {priceList.add(new PriceList.fromJson(v));});}

    PropertyTypeName = json['PropertyTypeName'].toString().replaceAll("null", "");
    PropertyFor = json['PropertyFor'].toString().replaceAll("null", "");

    refundable = json['refundable'].toString().replaceAll("null", "");
    refundable_duration = json['refundable_duration'].toString().replaceAll("null", "");
    Ref_term_condn = json['Ref_term_condn'].toString().replaceAll("null", "");
    booking_term_cond = json['booking_term_cond'].toString().replaceAll("null", "");

    BuilderId = json['BuilderId'].toString().replaceAll("null", "");






    if (json['bank_loan'] != null) {
      bank_loan = <Bank_loan>[];
      json['bank_loan'].forEach((v) {
        bank_loan.add(new Bank_loan.fromJson(v));
      });
    }

    if (json['property_rewards'] != null) {
      bank_loan = <Bank_loan>[];
      json['property_rewards'].forEach((v) {
        property_rewards.add(new Property_Rewards.fromJson(v));
      });
    }

    booking_partner_name = json['booking_partner_name'].toString().replaceAll("null", "");
    booking_partner_rera = json['booking_partner_rera'].toString().replaceAll("null", "");
    booking_partner_mobile = json['booking_partner_mobile'].toString().replaceAll("null", "");
    booking_partner_email = json['booking_partner_email'].toString().replaceAll("null", "");

    FeatureImageUrl=json["FeaturedImage"].toString().toString().replaceAll("null", "");
    logo=json["builder_logo"].toString();
    Rera=json["Rera"].toString();
    booking_max_amount=json["booking_max_amount"].toString().toString().replaceAll("null", "");
    booking_min_amount=json["booking_min_amount"].toString().toString().replaceAll("null", "");
    invoice_insurance=json["invoice_insurance"].toString().toString().replaceAll("null", "");
    if(json["gallery"]!=null){
      gallery_list= json["gallery"];
    }



  }
}

class List_Of_Price{
  String name="";
  List<PriceList>list=[];

}