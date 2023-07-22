



import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Banking/Banking_Dashboard.dart';
import 'package:peprop_consumer_app/Models/Dashboard_grid_model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/loan/Apply_Loan.dart';
import 'package:peprop_consumer_app/loan/My_Loan_List.dart';
import 'package:peprop_consumer_app/widgets/Generate_Grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Color/ColorFile.dart';
import '../../Kyc/Banking_Steps.dart';
import '../../widgets/DashBoard_List_Widget.dart';

class Banking_Widget extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                child: new Text(
                  "Banking/Loans",
                  style: new TextStyle(
                      fontSize: 16,
                      color: ColorFile.black,
                      fontFamily: "bold"),
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Powered By ',
                      style: TextStyle(
                        fontFamily: 'semi',
                        fontSize: 14,
                      ),
                    ),

                    Image.asset('assets/dashboard/powerdbyicici.png',scale: 15,)
                  ],
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          itemCount:Generate_Grid().generate_banking().length,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10, right: 10),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return new InkWell(
                child:DashBoard_List_Widget(Generate_Grid().generate_banking()[index]),
                onTap: () async {
                  if(index==0){
                    _checkForBankingEnabled(context,index);
                  }if(index==1){
                    var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Apply_Loan(null)));

                  }if(index==2){
                    var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Loan_List()));

                  }

                });
          },
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1.2),
        ),
      ],
    );
  }
  _checkForBankingEnabled(BuildContext context, int index) async {
    final prefs = await SharedPreferences.getInstance();

   String _mobile = prefs.getString('mobile').toString();
    AppUtils().showProgressDialog(context);
    var _map = <String, String>{};
    _map['mobile'] = _mobile;
    FormData customerData = FormData.fromMap(_map);
    print("mobile$_mobile");
    ServiceConfig().postApiBodyAuthJson(API.checkUser, customerData, context)
        .then((value) async {
      Response response = value;
      print('response message $response');
      if (response != null && response.statusCode == 200) {
        bool status = response.data["success"];
        if (status) {
          var data = response.data["data"];
          if (data == null) {
            Navigator.of(context, rootNavigator: true).pop("Discard");
            var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Banking_Steps()));
          } else {
            var data = response.data["data"];
            var accNo = data["acc_no"];
            var name = data["name"];


            final prefs = await SharedPreferences.getInstance();
            prefs.setString('acc_no', accNo);
            Navigator.of(context, rootNavigator: true).pop("Discard");

          }
        } else {
          Navigator.of(context, rootNavigator: true).pop("Discard");
        }
      } else {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      }
    });
  }


}