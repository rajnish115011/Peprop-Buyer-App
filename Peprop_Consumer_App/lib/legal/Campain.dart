

class Legal_Request {
  String legal_id="";
  String full_name="";
  String property_name="";
  String type="";
  String date="";
  String mobile="";
  String slot="";
  Map fields;
  Legal_Request(this.legal_id,this.full_name,this.property_name,this.type,this.date,this.mobile,this.slot, this.fields);
  //
  Map<String, dynamic> TojsonData() {
    var map = new Map<String, dynamic>();
    map["legal_id"] = legal_id;
    map["full_name"] = full_name;
    map["property_name"] = property_name;
    map["type"] =type;
    map["date"] =date;
    map["mobile"] =mobile;
    map["slot"] =slot;
    map["campaign"] = fields;
    return map;
  }
}
class Loan_Request {
  String email="";
  String mobile="";
  String amount="";
  String tenure="";
  String type="";
  String name="";
  Map fields;

  // String property_id;
  // String comment;
  Loan_Request(this.email,this.mobile,this.amount,this.tenure,this.type,this.name, this.fields);
  //
  Map<String, dynamic> TojsonData() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["mobile"] = mobile;
    map["amount"] = amount;
    map["tenure"] =tenure;
    map["type"] =type;
    map["name"] =name;

    map["campaign"] = fields;
    return map;
  }
}
class Campain {
  String campaign_id="";
  List<Map> fields;

  // String property_id;
  // String comment;
  Campain(this.campaign_id, this.fields);
  //
  Map<String, dynamic> TojsonData() {
    var map = new Map<String, dynamic>();
    map["campaign_id"] = campaign_id;
    map["fields"] = fields;
    return map;
  }
}
class CarJson {
  String label_id;
  String label_value;

  CarJson(this.label_id, this.label_value);

  Map<dynamic, dynamic> TojsonData() {
    var map = new Map<dynamic, dynamic>();
    map["label_id"] = label_id;
    map["label_value"] = label_value;
    return map;
  }
}
