class Extra_charges_details{

  String amenity_id="";
  String name="";
  String quantity="";
  String charge_amount="";
  String unit_id="";
  String unit_name="";
  String edit_qty="";

  String addOnChargableType="";
  String mandatory_unit_num="";
  String mandatory_price="";
  String bsp_flag="";
  String charge_unit="";



  Extra_charges_details({required this.amenity_id, required this.name, required this.quantity,required this.charge_amount,required this.unit_id,required this.unit_name,required this.addOnChargableType,
  required this.mandatory_unit_num,required this.mandatory_price,required this.bsp_flag,required this.charge_unit
  });
  factory Extra_charges_details.fromJson(Map<String, dynamic> json) {
    return Extra_charges_details(
      amenity_id: json["amenity_id"].toString(),
      name: json["name"].toString(),
      quantity: json["quantity"].toString(),
      charge_amount: json["charge_amount"].toString(),
      unit_id: json["unit_id"].toString(),
      unit_name: json["unit_name"].toString(),
      addOnChargableType: json["addOnChargableType"].toString(),
        mandatory_unit_num: json["mandatory_unit_num"].toString(),
        mandatory_price: json["mandatory_price"].toString(),
        bsp_flag: json["bsp_flag"].toString(),
        charge_unit: json["charge_unit"].toString(),







    );
  }

}


class Other_charges_details{

  String id="";
  String charge_title="";
  String charge_amount="";
  String extra_backup="";
  String total_amount="";
  String charge_unit="";



  Other_charges_details({required this.id, required this.charge_title, required this.charge_amount,required this.extra_backup,required this.total_amount,required this.charge_unit});
  factory Other_charges_details.fromJson(Map<String, dynamic> json) {
    return Other_charges_details(
        id: json["id"].toString(),
      charge_title: json["charge_title"].toString(),
      charge_amount: json["charge_amount"].toString(),
      extra_backup: json["extra_backup"].toString(),
      total_amount: json["total_amount"].toString(),
      charge_unit: json["charge_unit"].toString(),






    );
  }

}
class AmenitiesPrice_details{

  String id="";
  String name="";
  String charge_amount="";
  String is_chargable="";
  String total_amount="";
  String mandatory_unit_num="";
  String mandatory_price="";
  String charge_unit="";


  AmenitiesPrice_details({required this.id, required this.name, required this.charge_amount,required this.is_chargable,required this.total_amount,
  required this.mandatory_unit_num,required this.mandatory_price,required this.charge_unit});
  factory AmenitiesPrice_details.fromJson(Map<String, dynamic> json) {
    return AmenitiesPrice_details(
      id: json["id"].toString(),
      name: json["name"].toString(),
      charge_amount: json["charge_amount"].toString(),
      is_chargable: json["is_chargable"].toString(),
      total_amount: json["total_amount"].toString(),
      mandatory_unit_num: json["mandatory_unit_num"].toString(),
      mandatory_price: json["mandatory_price"].toString(),
      charge_unit: json["charge_unit"].toString(),




    );
  }

}


