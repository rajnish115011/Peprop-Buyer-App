

class My_Booking_Models {
  String PropertyTitle = "";
  String logo = "";
  String FeaturedImage = "";
  String address = "";
  String city_name = "";
  String state_name = "";
  String country_name = "";
  String builder_name = "";
  String booking_date = "";
  String mode_type = "";
  String booking_amount = "";

  String cheque_number = "";
  String payment_date = "";
  String bank_name = "";
  String account_number = "";
  String bank_holder_name = "";


  String payment_type = "";
  String receipt_number = "";
  String utr_no = "";
  String booking_option = "";



  List<Reason_Model>reason_list = [];


  List<Customer_Details_Models>list = [];
  List<Booking_status_data>booking_status_data = [];




  String tower_name = "";
  String unit_name_number = "";
  String floor_no = "";
  String plan_name = "";
  String unit_type = "";
  String id = "";
  String payment_status = "";
  String property_id = "";

  String refund_status = "";
  String refundable_status = "";

  List<dynamic>payment_option_mode=[];


  My_Booking_Models(
      {required this.PropertyTitle, required this.logo, required this.FeaturedImage, required this.address, required this.city_name, required this.state_name, required this.country_name, required this.builder_name, required this.booking_date, required this.mode_type,
        required this.booking_amount,

        required this.cheque_number,
        required this.payment_date,
        required this.bank_name,
        required this.account_number,
        required this.bank_holder_name,

        required this.payment_type,
        required this.receipt_number,


        required this.tower_name,
        required this.unit_name_number,
        required this.floor_no,
        required this.plan_name,
        required this.utr_no,
        required this.unit_type,
        required this.id,
        required this.payment_status,
        required this.property_id,
        required this.refund_status,
        required this.refundable_status,
        required this.booking_option,




      });

  My_Booking_Models.fromJson(Map<String, dynamic> json) {
    PropertyTitle = json["PropertyTitle"].toString();
    logo = json["logo"].toString().replaceAll("null", "");
    FeaturedImage = json["FeaturedImage"].toString().replaceAll("null", "");
    address = json["address"].toString().replaceAll("null", "");
    city_name = json["city_name"].toString().replaceAll("null", "");
    state_name = json["state_name"].toString().replaceAll("null", "");
    country_name = json["country_name"].toString().replaceAll("null", "");
    builder_name = json["builder_name"].toString().replaceAll("null", "");
    booking_date = json["booking_date"].toString().replaceAll("null", "");
    mode_type = json["mode_type"].toString().replaceAll("null", "");
    booking_amount = json["booking_amount"].toString().replaceAll("null", "");


    cheque_number = json["cheque_number"].toString().replaceAll("null", "");
    payment_date = json["payment_date"].toString().replaceAll("null", "");
    bank_name = json["bank_name"].toString().replaceAll("null", "");
    account_number = json["account_number"].toString().replaceAll("null", "");
    bank_holder_name =json["bank_holder_name"].toString().replaceAll("null", "");

    payment_type = json["payment_type"].toString().replaceAll("null", "");
    receipt_number = json["receipt_number"].toString().replaceAll("null", "");
    tower_name = json["tower_name"].toString().replaceAll("null", "");
    unit_name_number =
        json["unit_name_number"].toString().replaceAll("null", "");
    floor_no = json["floor_no"].toString().replaceAll("null", "");
    plan_name = json["plan_name"].toString().replaceAll("null", "");
    utr_no = json["utr_no"].toString().replaceAll("null", "");
    unit_type = json["unit_type"].toString().replaceAll("null", "");
    id= json["id"].toString().replaceAll("null", "");
    payment_status= json["booking_status"].toString().replaceAll("null", "");
    property_id= json["property_id"].toString().replaceAll("null", "");

    refund_status= json["refund_status"].toString();
    refundable_status= json["refundable_status"].toString().replaceAll("null", "");
    booking_option= json["booking_option"].toString().replaceAll("null", "");



    if (json['customer_details'] != null) {
      list = <Customer_Details_Models>[];
      json['customer_details'].forEach((v) {
        list.add(new Customer_Details_Models.fromJson(v));
      });
    } if (json['booking_status_data'].toString() != "false") {
      booking_status_data = <Booking_status_data>[];
      json['booking_status_data'].forEach((v) {
        booking_status_data.add(Booking_status_data.fromJson(v));
      });
    }


    if (json['reason_data'] != null) {
      reason_list = <Reason_Model>[];
      json['reason_data'].forEach((v) {
        reason_list.add(new Reason_Model.fromJson(v));
      });
    }
    if(json["payment_option_mode"]!=null){
      payment_option_mode=json["payment_option_mode"];

    }
  }

}
class Reason_Model {

  String id="";
  String property_id="";
  String reason="";


  Reason_Model({required this.id, required this.property_id,required this.reason});
  Reason_Model.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    property_id= json["property_id"].toString().replaceAll("null", "");
    reason=  json["reason"].toString().replaceAll("null", "0");

  }

}
class Booking_status_data {

  String status_history="";
  String comments="";
  String created_on="";
  String unit_name_number="";


  Booking_status_data({required this.status_history, required this.comments,required this.created_on,required this.unit_name_number});
  Booking_status_data.fromJson(Map<String, dynamic> json) {
    status_history= json["status_history"].toString();
    comments= json["comments"].toString().replaceAll("null", "");
    created_on=  json["created_on"].toString().replaceAll("null", "0");
    unit_name_number=  json["unit_name_number"].toString().replaceAll("null", "0");
  }

}

class Customer_Details_Models{
  String id="";
  String full_name="";
  String father_name="";
  String gender="";
  String address="";
  String bank_loan_required="";
  String d_o_b="";
  String pancard_details="";
  String aadharcard_details="";

  String form_type="";



  Customer_Details_Models({required this.id, required this.full_name,required this.father_name,required this.gender,required this.address,required this.bank_loan_required,required this.d_o_b,required this.pancard_details,required this.aadharcard_details,required this.form_type});
  Customer_Details_Models.fromJson(Map<String, dynamic> json) {
    id= json["PropertyTitle"].toString();
    full_name= json["full_name"].toString().replaceAll("null", "");
    father_name=  json["father_name"].toString().replaceAll("null", "N/A");
    gender=  json["gender"].toString().replaceAll("null", "N/A");
    address=  json["address"].toString().replaceAll("null", "N/A");
    bank_loan_required=  json["bank_loan_required"].toString().replaceAll("null", "N/A");
    d_o_b=  json["d_o_b"].toString().replaceAll("null", "N/A");
    pancard_details=  json["pancard_details"].toString().replaceAll("null", "N/A");
    aadharcard_details=  json["aadharcard_details"].toString().replaceAll("null", "N/A");
    form_type=json["form_type"].toString().replaceAll("null", "N/A");

  }
}