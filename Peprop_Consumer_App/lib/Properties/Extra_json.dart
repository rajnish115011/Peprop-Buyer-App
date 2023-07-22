

class Extra_json{
  String id="";
  String value="";

  Extra_json(this.id, this.value);

  Map<dynamic, dynamic> TojsonData() {
    var map = new Map<dynamic, dynamic>();
    map["id"] = id;
    map["value"] = value;
    return map;
  }
}