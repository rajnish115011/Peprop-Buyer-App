class Inside_Model{
  String? id;
  String? acc_no;
  String? ifsc;
  String? acc_type;
  String? name;
  String? mobile;
  String? kyc;
  String? status;
  String? user_mobile;
  String? user_account;
  String? created_by;


  Inside_Model({this.id,this.acc_no,this.ifsc,this.acc_type,this.name,this.mobile, this.kyc, this.status,this.created_by});
  Inside_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString().replaceAll("null", "");
    acc_no = json['acc_no'].toString().replaceAll("null", "");
    ifsc = json['ifsc'].toString().replaceAll("null", "");
    acc_type = json['acc_type'].toString().replaceAll("null", "");
    name = json['name'].toString().replaceAll("null", "");
    mobile = json['mobile'].toString().replaceAll("null", "");
    kyc = json['kyc'].toString().replaceAll("null", "");
    status = json['status'].toString().replaceAll("null", "");
    created_by = json['created_by'].toString().replaceAll("null", "");
  }}