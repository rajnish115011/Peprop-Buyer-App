import '../Book_Now/Booking/Extra_charges_details.dart';

class RM_Inventory_Model{
  String id="";
  String prop_id="";
  String lead_id="";
  String prop_type="";
  String tower_no="";
  String floor_no="";
  String unit_type="";
  String unit_no="";
  String unit_id="";


  String unit_area="";
  String facing="";
  String view="";
  String furnishing_type="";
  String electric_meter="";
  String pow_backup="";
  String plc="";
  String parking_type="";


  String parking="";
  String other_parking_type="";
  String other_parking="";
  String cost="";
  String notes="";
  String payment_plan_id="";
  String created_by="";


  String created_on="";
  String is_customer="";
  String is_broker="";
  String is_rm="";
  String status="";
  String requirement_id="";
  String is_approved="";
  String payment_type="";


  String discount_type="";
  String discount_amount="";
  String booking_amount_type="";
  String booking_amount="";
  String full_name="";
  String mobile="";
  String tower_name="";
  String plan_name="";

  String fullname="";
  String PropertyTitle="";
  String Address="";


  String rm_name="";
  String rm_mobile="";
  String rm_email="";
  String costsheet_status="";
  String PropertyFor="";

  String inventory_count="";
  List<Extra_charges_details>extra_charges_details=[];
  List<Other_charges_details>other_charges_details=[];
  List<AmenitiesPrice_details>aminities_charges_details=[];

  String bsp_unit="";
  String inventory_id="";
  String term_condition="";
  String total_unit_price="";
  String mandatoryPriceTotalWithBsp="";
  String FloorChargePriceTotal="";
  String amenitiesChargebleTotal="";
  String mandatoryPriceTotalWithOutBsp="";
  String super_area="";
  String carpet_area="";
  String bsp="";




  RM_Inventory_Model({required this.id, required this.prop_id,required this.lead_id,required this.prop_type,required this.tower_no,required this.floor_no, required this.unit_type, required this.unit_no,

    required this.unit_area,required this.facing,required this.view,required this.furnishing_type,required this.electric_meter,required this.pow_backup,required this.plc,required this.parking_type,required this.parking,

    required this.other_parking_type,required this.other_parking,required this.cost,required this.notes,required this.payment_plan_id, required this.created_by,

    required this.created_on,required this.is_customer,required this.is_broker,required this.is_rm,required this.status,required this.requirement_id,required this.is_approved,required this.payment_type,
    required this.discount_type,required this.discount_amount,required this.booking_amount_type,required this.booking_amount,required this.full_name,required this.mobile,
    required this.tower_name,required this.plan_name,required this.PropertyTitle,required this.Address,required this.fullname,
    required this.rm_name,required this.rm_mobile,required this.rm_email,required this.costsheet_status,required this.PropertyFor,required this.inventory_count,

    required this.extra_charges_details,required this.other_charges_details,required this.aminities_charges_details,required this.bsp_unit,required this.inventory_id,required this.term_condition,required this.total_unit_price,
    required this.mandatoryPriceTotalWithBsp,
    required this.FloorChargePriceTotal,
    required this.amenitiesChargebleTotal,
    required this.mandatoryPriceTotalWithOutBsp,
    required this.super_area,
    required this.carpet_area,
    required this.bsp,
    required this.unit_id,





  });
  factory RM_Inventory_Model.fromJson(Map<String, dynamic> json) {
    return RM_Inventory_Model(


      id: json["id"].toString().replaceAll("null", "N/A"),
      prop_id: json["prop_id"].toString().replaceAll("null", "N/A"),
      lead_id: json["lead_id"].toString().replaceAll("null", "N/A"),
      prop_type: json["prop_type"].toString().replaceAll("null", "N/A"),
      tower_no: json["tower_no"].toString().replaceAll("null", "N/A"),
      floor_no: json["floor_no"].toString().replaceAll("null", "N/A"),
      unit_type: json["unit_type"].toString().replaceAll("null", "N/A"),
      unit_no: json["unit_no"].toString().replaceAll("null", "N/A"),


      unit_area: json["unit_area"].toString().replaceAll("null", "N/A"),
      facing: json["facing"].toString().replaceAll("null", "N/A"),
      view: json["view"].toString().replaceAll("null", "N/A"),
      furnishing_type: json["furnishing_type"].toString().replaceAll("null", "N/A"),
      electric_meter: json["electric_meter"].toString().replaceAll("null", "N/A"),
      pow_backup: json["pow_backup"].toString().replaceAll("null", "N/A"),
      plc: json["plc"].toString().replaceAll("null", "N/A"),
      parking_type: json["parking_type"].toString().replaceAll("null", "N/A"),

      parking: json["parking"].toString().replaceAll("null", "N/A"),
      other_parking_type: json["other_parking_type"].toString().replaceAll("null", "N/A"),
      other_parking: json["other_parking"].toString().replaceAll("null", "N/A"),
      cost: json["cost"].toString().replaceAll("null", "N/A"),
      notes: json["notes"].toString().replaceAll("null", "N/A"),
      payment_plan_id: json["payment_plan_id"].toString().replaceAll("null", "N/A"),
      created_by: json["created_by"].toString().replaceAll("null", "N/A"),



      created_on: json["created_on"].toString().replaceAll("null", "N/A"),
      is_customer: json["is_customer"].toString().replaceAll("null", "N/A"),
      is_broker: json["is_broker"].toString().replaceAll("null", "N/A"),
      is_rm: json["is_rm"].toString().replaceAll("null", "N/A"),
      status: json["status"].toString().replaceAll("null", "N/A"),
      requirement_id: json["requirement_id"].toString().replaceAll("null", "N/A"),
      is_approved: json["is_approved"].toString().replaceAll("null", "N/A"),
      payment_type: json["payment_type"].toString().replaceAll("null", "N/A"),

      discount_type: json["discount_type"].toString().replaceAll("null", "N/A"),
      discount_amount: json["discount_amount"].toString().replaceAll("null", "N/A"),
      booking_amount_type: json["booking_amount_type"].toString().replaceAll("null", "N/A"),
      booking_amount: json["booking_amount"].toString().replaceAll("null", "N/A"),
      full_name: json["full_name"].toString().replaceAll("null", "N/A"),
      mobile: json["mobile"].toString().replaceAll("null", "N/A"),
      tower_name: json["tower_name"].toString().replaceAll("null", "N/A"),
      plan_name: json["plan_name"].toString().replaceAll("null", "N/A"),

      PropertyTitle: json["PropertyTitle"].toString().replaceAll("null", "N/A"),
      Address: json["Address"].toString().replaceAll("null", "N/A"),
      fullname: json["fullname"].toString().replaceAll("null", "N/A"),

      rm_name: json["rm_name"].toString().replaceAll("null", "N/A"),
      rm_mobile: json["rm_mobile"].toString().replaceAll("null", "N/A"),
      rm_email: json["rm_email"].toString().replaceAll("null", "N/A"),
      costsheet_status: json["costsheet_status"].toString(),
      PropertyFor: json["PropertyFor"].toString(),
      inventory_count: json["inventory_count"].toString(),
      extra_charges_details:json["extra_charges_details"]!=null?json["extra_charges_details"].map<Extra_charges_details>((json) => Extra_charges_details.fromJson(json)).toList():[],
      other_charges_details:json["otherChargePrice"]!=null?json["otherChargePrice"].map<Other_charges_details>((json) => Other_charges_details.fromJson(json)).toList():[],
      aminities_charges_details:json["AmenitiesPrice"]!=null?json["AmenitiesPrice"].map<AmenitiesPrice_details>((json) => AmenitiesPrice_details.fromJson(json)).toList():[],
      bsp_unit: json["bsp_unit"].toString(),
      inventory_id: json["inventory_id"].toString(),
      term_condition: json["term_condition"].toString(),
      total_unit_price: json["total_unit_price"].toString().replaceAll("null", "0"),
      mandatoryPriceTotalWithBsp: json["mandatoryPriceTotalWithBsp"].toString().replaceAll("null", "0"),
      FloorChargePriceTotal: json["FloorChargePriceTotal"].toString().replaceAll("null", "0"),
      amenitiesChargebleTotal: json["amenitiesChargebleTotal"].toString().replaceAll("null", "0"),
      mandatoryPriceTotalWithOutBsp: json["mandatoryPriceTotalWithOutBsp"].toString().replaceAll("null", "0"),
      super_area: json["super_area"].toString().replaceAll("null", "0"),
      carpet_area: json["carpet_area"].toString().replaceAll("null", "0"),
      bsp: json["bsp"].toString().replaceAll("null", "0"),
      unit_id: json["unit_id"].toString().replaceAll("null", "0"),



    );
  }

}