


class Loan_Model {

  String loan_type="";
  Loan_Model({required this.loan_type});
  factory Loan_Model.fromJson(Map<String, dynamic> json) {
    return Loan_Model(
      loan_type: json["loan_type"].toString(),


    );
  }

}