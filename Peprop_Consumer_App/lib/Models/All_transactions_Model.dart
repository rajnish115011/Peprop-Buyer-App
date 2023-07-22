import 'package:peprop_consumer_app/Utils/AppUtils.dart';

class All_transactions_Model {
  String name="";
  String mobile="";
  String dr_acc="";
  String cr_acc="";
  String ifsc="";
  String amount="";
  String remark="";
  String created_ip="";
  DateTime created_at=DateTime.now();
  String created_by="";
  String status="";
  String trans_id="";
  String message="";
  String tras_type="";




  //book now
  String full_name="";
  String payment_made="";
  String paymentThrough="";




   All_transactions_Model.fromJson(Map<String, dynamic> json) {
     name= json["name"].toString().replaceAll("null", "");
     mobile= json["mobile"].toString().replaceAll("null", "");
     dr_acc= json["dr_acc"].toString().replaceAll("null", "");
     cr_acc= json["cr_acc"].toString().replaceAll("null", "");
     ifsc= json["ifsc"].toString().replaceAll("null", "");
     amount= json["amount"].toString().replaceAll("null", "");
     remark= json["remark"].toString().replaceAll("null", "");
     created_ip= json["created_ip"].toString().replaceAll("null", "");
     created_at= json["created_at"].toString()=="null"?AppUtils.dates(json["created_on"].toString().replaceAll("null", "")):AppUtils.dates(json["created_at"].toString().replaceAll("null", ""));
     created_by= json["created_by"].toString().replaceAll("null", "");
     status= json["status"].toString().replaceAll("null", "");
     trans_id= json["trans_id"].toString().replaceAll("null", "");
     message= json["message"].toString().replaceAll("null", "");
     tras_type= json["tras_type"].toString().replaceAll("null", "");
     full_name= json["builder_name"].toString().replaceAll("null", "");
     payment_made= json["payment_made"].toString().replaceAll("null", "");
     paymentThrough= json["paymentThrough"].toString().replaceAll("null", "");


   }

}


class Wallet_Model {
  String point="";
  String type="";
  String remark="";
  String datetime="";
  String logo="";




  Wallet_Model.fromJson(Map<String, dynamic> json) {
    point= json["point"].toString().replaceAll("null", "");
    type= json["type"].toString().replaceAll("null", "");
    remark= json["remark"].toString().replaceAll("null", "");
    datetime= json["datetime"].toString().replaceAll("null", "");
    logo= json["logo"].toString().replaceAll("null", "");


  }

}