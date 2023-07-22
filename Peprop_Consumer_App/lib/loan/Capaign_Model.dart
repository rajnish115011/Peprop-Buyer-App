


class Capaign_Model {

  String campaign_label_id="";
  String field_name="";
  String field_type="";
  String enter_value="";


  Capaign_Model({required this.campaign_label_id,required this.field_name,required this.field_type});
  factory Capaign_Model.fromJson(Map<String, dynamic> json) {
    return Capaign_Model(
      campaign_label_id: json["campaign_label_id"].toString(),
      field_name: json["field_name"].toString(),
      field_type: json["field_type"].toString(),


    );
  }

}