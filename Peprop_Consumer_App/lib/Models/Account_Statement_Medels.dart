

class Account_Statement_Medels{
  String created_at="";
  String trans_id="";
  String amount="";
  String balance="";
  String dr_acc="";


  Account_Statement_Medels({required this.created_at, required this.trans_id,required this.amount,required this.balance,required this.dr_acc});
  factory Account_Statement_Medels.fromJson(Map<String, dynamic> json) {
    return Account_Statement_Medels(
      created_at: json["created_at"].toString(),
      trans_id: json["trans_id"].toString().replaceAll("null", ""),
      amount: json["amount"].toString().replaceAll("null", "0"),
      balance: json["balance"].toString().replaceAll("null", "0"),
      dr_acc: json["dr_acc"].toString().replaceAll("null", "0"),



    );
  }
}