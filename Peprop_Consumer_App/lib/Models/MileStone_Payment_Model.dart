


class MileStone_Payment_Model{







    String? id;
    String? lead_inventory_id;
    String? lead_id;
    String? payment_plan_id;
    String? payment_plan_name;
    String? payment_plan_milestone_id;
    String? milestone_name;
    String? net_amount;
    String? plan_percent;
    String? basic_installment_amt;
    String? gst_amount;
    String? installment_amt_incl_gst;
    String? after_date;
    String? stage;

  String? paid_status;
  String? penalty_on_due;
  String? interest_on_due;
  String? bounce_charge;
  String? other_charges;
  String? customer_id;
  String? milestone_emi_amount;
  String? milestone_paid_amounts;
  String? milestone_due_amounts;
  String? milestone_net_due_amount;
  List<Payment_Details_Model>payment=[];

  List<dynamic>documents=[];




  MileStone_Payment_Model.fromJson(Map<String, dynamic> json) {
     id=json["id"].toString();
     lead_inventory_id=json["lead_inventory_id"].toString();
     lead_id=json["lead_id"].toString();
     payment_plan_id=json["payment_plan_id"].toString();
     payment_plan_name=json["payment_plan_name"].toString();
     payment_plan_milestone_id=json["payment_plan_milestone_id"].toString();
     milestone_name=json["milestone_name"].toString();
     net_amount=json["net_amount"].toString();
     plan_percent=json["plan_percent"].toString();
     basic_installment_amt=json["basic_installment_amt"].toString();
     gst_amount=json["gst_amount"].toString();
     installment_amt_incl_gst=json["installment_amt_incl_gst"].toString();
     after_date=json["after_date"].toString();
     stage=json["stage"].toString();
     paid_status=json["paid_status"].toString();
     penalty_on_due=json["penalty_on_due"].toString();
     interest_on_due=json["interest_on_due"].toString();
     bounce_charge=json["bounce_charge"].toString();
     other_charges=json["other_charges"].toString();
     customer_id=json["customer_id"].toString();
     milestone_emi_amount=json["milestone_emi_amount"].toString();
     milestone_paid_amounts=json["milestone_paid_amounts"].toString();
     milestone_due_amounts=json["milestone_due_amounts"].toString();
     milestone_net_due_amount=json["milestone_net_due_amount"].toString();

     if(json["payments"]!=null){
       var value = json["payments"];
       payment = value.map<Payment_Details_Model>((json) =>Payment_Details_Model.fromJson(json)).toList();
     }
     if(json["documents"]!=null){
       documents=json["documents"];
     }





  }


}


class Payment_Details_Model{
  String? id;
  String? payment_made;
  String? payment_date;
  String? mode_type;
  String? utr_no;
  String? cheque_number;
  String? receipt_number;
  String? bank_name;
  String? account_number;
  String? bank_holder_name;
  String? notes;
  String? payment_status;
  String? approved_on;
  String? approved_by;

  Payment_Details_Model.fromJson(Map<String, dynamic> json) {
    id=json["id"].toString();
    payment_made=json["payment_made"].toString();
    payment_date=json["payment_date"].toString();
    mode_type=json["mode_type"].toString();
    utr_no=json["utr_no"].toString().replaceAll("null", "N/A");
    cheque_number=json["cheque_number"].toString().replaceAll("null", "N/A");
    receipt_number=json["receipt_number"].toString().replaceAll("null", "N/A");
    bank_name=json["bank_name"].toString().replaceAll("null", "N/A");
    account_number=json["account_number"].toString().replaceAll("null", "N/A");
    bank_holder_name=json["bank_holder_name"].toString().replaceAll("null", "N/A");
    notes=json["notes"].toString();
    payment_status=json["payment_status"].toString();
    approved_on=json["approved_on"].toString();
    approved_by=json["approved_by"].toString();






  }


}