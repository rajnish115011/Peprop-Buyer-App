import '../Book_Now/Booking/Extra_charges_details.dart';

class Tower_Model {

  String id="";
  String tower_name="";
  String type="";
  String plan_name="";
  String term_condition="";
  String name="";
  String super_area="";
  String carpet_area="";
  String inventory_id="";




  Tower_Model({required this.id, required this.tower_name,required this.type,required this.plan_name,required this.term_condition,
    required this.name,required this.super_area,required this.carpet_area,required this.inventory_id
  });
  factory Tower_Model.fromJson(Map<String, dynamic> json) {
    return Tower_Model(
      id: json["id"].toString(),
      tower_name: json["tower_name"].toString().replaceAll("null", ""),
      type: json["type"].toString().replaceAll("null", ""),
      plan_name: json["plan_name"].toString().replaceAll("null", ""),
      term_condition: json["term_condition"].toString().replaceAll("null", ""),
      name: json["name"].toString().replaceAll("null", ""),
      super_area: json["super_area"].toString().replaceAll("null", ""),
      carpet_area: json["carpet_area"].toString().replaceAll("null", ""),
      inventory_id: json["inventory_id"].toString().replaceAll("null", ""),


    );
  }

}


class No_of_floors {

  String id="";
  String total_no_of_floors="";




  No_of_floors({required this.id, required this.total_no_of_floors});
  factory No_of_floors.fromJson(Map<String, dynamic> json) {
    return No_of_floors(
      id: json["id"].toString(),
      total_no_of_floors: json["total_no_of_floors"].toString(),

    );
  }

}


class Book_Now_Unit_Type_Model {
  String name="";
  String super_area="";
  Book_Now_Unit_Type_Model({required this.name, required this.super_area});
  factory Book_Now_Unit_Type_Model.fromJson(Map<String, dynamic> json) {
    return Book_Now_Unit_Type_Model(
      name: json["name"].toString(),
      super_area: json["super_area"].toString(),

    );
  }

}


class Book_Now_Unit_Type_Models {
  String id="";
  String type="";
  List<dynamic>area_list=[];
  Book_Now_Unit_Type_Models({required this.id, required this.type,required this.area_list});
  factory Book_Now_Unit_Type_Models.fromJson(Map<String, dynamic> json) {
    return Book_Now_Unit_Type_Models(
      id: json["id"].toString(),
      type: json["type"].toString(),
      area_list: json["size"],
    );
  }

}

class Book_Now_all_Tower_Model {
  String tower_id="";
  String tower_name="";
  String name="";
  String super_area="";
  String carpet_area="";
  String unit_id="";
  String floor="";
  String unit_name_number="";
  String price="";
  String unit_status="";
  String inventory_id="";
  String space_id="";
  String unit_location="";
  String facing_name="";
  String bsp_super_area="";
  bool is_checked=false;

  double sum=0;



  String total_unit_price="";
  String mandatoryPriceTotalWithBsp="";
  String mandatoryPriceTotalWithOutBsp="";

  List<Extra_charges_details>extra_charges_details=[];
  List<Other_charges_details>other_charges_details=[];
  List<AmenitiesPrice_details>aminities_charges_details=[];


  Book_Now_all_Tower_Model({required this.tower_id, required this.tower_name,
    required this.name, required this.super_area,
    required this.carpet_area, required this.unit_id,
    required this.floor, required this.unit_name_number,required this.price,required this.unit_status,
    required this.inventory_id,required this.space_id,
    required this.unit_location,required this.facing_name,

    required this.total_unit_price,required this.mandatoryPriceTotalWithBsp,
    required this.mandatoryPriceTotalWithOutBsp,required this.extra_charges_details,
    required this.other_charges_details,required this.aminities_charges_details,


  });
  Book_Now_all_Tower_Model.fromJson(Map<String, dynamic> json) {
    print(json["floor"]);
    tower_id= json["tower_id"].toString();
    tower_name=  json["tower_name"].toString();
    name=  json["name"].toString();
    super_area=  json["super_area"].toString();
    carpet_area=  json["carpet_area"].toString();
    unit_id= json["unit_id"].toString();
    floor=  json["floor"].toString();
    unit_name_number=  json["unit_name_number"].toString();
    price=  json["price"].toString();
    unit_status=  json["unit_status"].toString();
    inventory_id=  json["inventory_id"].toString();
    space_id=  json["space_id"].toString();
    unit_location=  json["unit_location"].toString().replaceAll("null", "");
    facing_name=  json["facing_name"].toString().replaceAll("null", "");
    bsp_super_area=  json["bsp_super_area"].toString().replaceAll("null", "");



  }

}


class Book_Now_Tower_Model {
  String id="";
  String name="";
  List<dynamic>floor_list=[];


  Book_Now_Tower_Model({required this.id, required this.name,
    required this.floor_list
  });
  Book_Now_Tower_Model.fromJson(Map<String, dynamic> json) {
    print(json["floor"]);
    id= json["id"].toString();
    name=  json["name"].toString();
    floor_list=json["floor"];


  }

}







class Payments_Plans {

  String id="";
  String plan_name="";
  String term_condition="";
  String key_feature1="";
  String key_feature2="";
  String key_feature3="";
  String key_feature4="";
  String key_feature5="";

  String scheme_rewards_total_value="";





  List<Payment_milestones>payment_milestones=[];


  Scheme? scheme;






   Payments_Plans.fromJson(Map<String, dynamic> json) {

      id=json["id"].toString();
      plan_name= json["plan_name"].toString();
      term_condition=json["term_condition"].toString();
      key_feature1=json["key_feature1"].toString().replaceAll("null", "");
      key_feature2=json["key_feature2"].toString().replaceAll("null", "");
      key_feature3=json["key_feature3"].toString().replaceAll("null", "");
      key_feature4=json["key_feature4"].toString().replaceAll("null", "");
      key_feature5=json["key_feature5"].toString().replaceAll("null", "");
      scheme_rewards_total_value=json["scheme_rewards_total_value"].toString().replaceAll("null", "");


      if(json["scheme"]!=null){
        scheme=Scheme.fromJson(json["scheme"]);


      }


      if (json['milestonArrData'] != null) {json['milestonArrData'].forEach((v) {payment_milestones.add(new Payment_milestones.fromJson(v));});}

  }

}


class Scheme {

  String scheme_name="";
  String scheme_loyalty_points="";
  String scheme_is_cashback="";
  String scheme_cashback_type="";
  String scheme_cashback_value="";
  String scheme_rewards_total_value="";
  String scheme_notes="";



  List<Payment_milestones>scheme_rewards_categories=[];






  Scheme.fromJson(Map<String, dynamic> json) {

    scheme_name=json["scheme_name"].toString();
    scheme_loyalty_points= json["scheme_loyalty_points"].toString();
    scheme_is_cashback=json["scheme_is_cashback"].toString();
    scheme_cashback_type=json["scheme_cashback_type"].toString().replaceAll("null", "");
    scheme_cashback_value=json["scheme_cashback_value"].toString().replaceAll("null", "");
    scheme_rewards_total_value=json["scheme_rewards_total_value"].toString().replaceAll("null", "");
    scheme_notes=json["scheme_notes"].toString().replaceAll("null", "");



    if(json["scheme_rewards_categories"]!=null){
      if (json['scheme_rewards_categories'] != null) {json['scheme_rewards_categories'].forEach((v) {
        scheme_rewards_categories.add(new Payment_milestones.fromJson(v));

      });}


    }





  }

}

class Payment_milestones {

  String milestone_name="";
  String amount="";
  String stage_description="";


  String name="";




  Payment_milestones.fromJson(Map<String, dynamic> json) {

    milestone_name=json["milestone_name"].toString();
    amount= json["amount"].toString();
    stage_description=json["stage_description"].toString();
    name=json["name"].toString();



  }

}

class Unit_Type {
  String floor_id="";
  String unit_id="";
  String unit_name="";
  String unit_name_number="";
  String bsp_unit="";
  String super_area="";
  String main_unit_id="";
  String unit_status="";
  String inventory_id="";

  Unit_Type({required this.floor_id, required this.unit_id, required this.unit_name,required this.unit_name_number,required this.bsp_unit,required this.super_area,required this.main_unit_id,required this.unit_status,required this.inventory_id});
  factory Unit_Type.fromJson(Map<String, dynamic> json) {
    return Unit_Type(
      floor_id: json["floor_id"].toString(),
      unit_id: json["unit_id"].toString(),
      unit_name: json["unit_name"].toString(),
      unit_name_number: json["unit_name_number"].toString(),
      bsp_unit: json["bsp_unit"].toString(),
      super_area: json["super_area"].toString(),
      main_unit_id: json["main_unit_id"].toString(),
      unit_status: json["unit_status"].toString(),
      inventory_id: json["inventory_id"].toString(),




    );
  }

}

