class BankListModel {
  String? id;
  String? bankid;
  String? bankname;
  String? processingfee;
  String? loantype;
  String? intrate;
  String? imageLink;

  BankListModel({this.id, this.bankid, this.bankname, this.processingfee, this.loantype, this.intrate, this.imageLink});

  BankListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankid = json['bank_id'];
    bankname = json['bank_name'];
    processingfee = json['processing_fee'];
    loantype = json['loan_type'];
    intrate = json['interest'];
    imageLink = json['bank_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['bank_id'] = this.bankid.toString();
    data['bank_name'] = this.bankname;
    data['processing_fee'] = this.processingfee.toString();
    data['loan_type'] = this.loantype;
    data['interest'] = this.intrate.toString();
    data['bank_image'] = this.imageLink;
    return data;
  }
}