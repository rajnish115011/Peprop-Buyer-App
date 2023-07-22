import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/loan_model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Global_connection/Global_connection.dart';
import '../wish_list/Shimmers_Effect.dart';
import 'Loan_Widget.dart';


class My_Loan_List extends StatefulWidget {

  const My_Loan_List({Key? key}) : super(key: key);

  @override
  _LoanScreenState createState() => _LoanScreenState();

}

class _LoanScreenState extends State<My_Loan_List> {
  bool viewVisible = false;
  bool loading = false;
  List<LoanModel> loanList = [];

  @override
  void initState() {
    _getLoans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBar(context, 'Loan'),
      body: Stack(
        children: [
          (loading)
              ? Shimmers_Effect()
              : (loanList.isEmpty)
                  ? Center(child: No_Data_Placeholder('My Loan Enquiry Not Found'),)
                  :
                      ListView.builder(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                     itemCount: loanList.length,
                       itemBuilder: (context, i) {
                       return Loan_Widget(loanList[i]);
                      },
                    ),
        ],
      ),
    );
  }

  Future<void> _getLoans() async {
    setState(() {
      loading = true;
    });
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var _map = <String, String>{};
    _map['campaign_id'] = "6";
    _map['user_id'] = sharedPreferences.getString("user_id").toString();

    FormData customerData = FormData.fromMap(_map);
    var response=await Global_connection().post_method(customerData, context, API.getCampaignInquiryListByUserId);
    print(response.toString());
    if(response!=null&&response.data!=null&&response.statusCode == 200&&response.data["data"]!=""){
      Map map=response.data["data"];
      map.forEach((key, value) {
        String Name=value["Name"].toString();
        String Mobile=value["Mobile"].toString();
        String Email=value["Email"].toString();
        String Loan_amt=value["Loan Amount"].toString();
        String Loan_Type=value["Loan Type"].toString();
        String Loan_Tenure=value["Loan Tenure"].toString();
        String status=value["status"].toString();
        String created_on=value["created_on"].toString();

        LoanModel model=new LoanModel(name: Name, mobile: Mobile, email: Email, amount: Loan_amt, tenure: Loan_Tenure, type: Loan_Type, status: status, created_on: created_on);
        loanList.add(model);

      });


    }
    setState(() {
      loading=false;
    });

  }
}
