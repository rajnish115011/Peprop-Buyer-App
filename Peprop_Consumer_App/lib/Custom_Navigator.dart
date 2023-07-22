
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/All_transactions/All_transactions.dart';
import 'package:peprop_consumer_app/Banking/Banking_Dashboard.dart';
import 'package:peprop_consumer_app/Login/Login.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Categeory.dart';
import 'package:peprop_consumer_app/Rewards/My_Gift_Card/Gift_Tab.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/builder_profile/Builder_Profile.dart';
import 'package:peprop_consumer_app/buy_sell/Buy_Sell_Form.dart';
import 'package:peprop_consumer_app/buy_sell/MY_Buy_Sell.dart';
import 'package:peprop_consumer_app/legal/My_Legal_Enquiry_List.dart';
import 'package:peprop_consumer_app/widgets/App_Filters.dart';
import 'package:peprop_consumer_app/wish_list/Wish_List.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Banking/Account_Statement.dart';
import 'Book_Now/my_booking/My_Booking.dart';
import 'Enquiry/My_Enquiry.dart';
import 'Kyc/Banking_Steps.dart';
import 'My_Inrested_Projects/MyBrokerProperties.dart';
import 'Rewards/Campaign_List.dart';
import 'Rewards/My_Coupon/My_Coupon.dart';
import 'Rewards/My_Gift_Card/My_Gift_Card.dart';
import 'Rewards/ReferAndEarn.dart';
import 'Site_Visit/My_Site_Visit.dart';
import 'Utils/AppUtils.dart';
import 'bill_payment/All_Services/All_Services.dart';
import 'bill_payment/Operator_List/Operator_List.dart';
import 'dashboard_model/Home_Model.dart';
import 'legal/Legals.dart';
import 'loan/Apply_Loan.dart';
import 'loan/My_Loan_List.dart';

class Custom_Navigator {

  String city="Choose City";
  int index=0;
  int subindex=0;
  List<Home_Model>list=[];
  late BuildContext context;
  Custom_Navigator(String city,int index, int subindex,List<Home_Model>list, BuildContext context){
    this.city=city;
    this.index=index;
    this.subindex=subindex;
    this.list=list;
    this.context=context;
  }

    navigator() async {
    String id=list[index].list[subindex].id;
    String main_id=list[index].section_id;
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String token=sharedPreferences.getString("token").toString();
    if(main_id=="10"){
      var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Operator_List(list[index].list[subindex])));
    }if(main_id=="19"){
      App_Filters().check_location("2", false, city, context,true,"1",id);
    }

    //resedential
    switch (id) {
      case "1":
      //search resedential
        App_Filters().check_location("1", true, city, context,false,"","");
        break;
      case "5":
      // new resedential
        App_Filters().check_location("1", false, city, context,true,"","");
        break;

      case "6":
      //residential my project
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wish_List("1")));
        break;

      case "7":
      //book now
        Book_Now().check_location("1",  city, context,);
        break;

      case "8":
      //my booking
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Booking(1)));

        break;

      case "9":
        App_Filters().check_location("2", true, city, context,false,"","");
        break;


      case "10":
        App_Filters().check_location("2", false, city, context,true,"","");
        break;

      case "11":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wish_List("2")));
        break;
      case "13":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Booking(2)));
        break;
      case "12":
        Book_Now().check_location("2",  city, context);
        break;

      case "17":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Enquiry()));

        break;
      case "18":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Site_Visit()));
        break;

      case "19":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyBrokerProperties()));
        break;

      case "37":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Apply_Loan(null)));

        break;
      case "38":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Apply_Loan(null)));
        break;

      case "39":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Loan_List()));
        break;


      case "14":
        Home_Model? home_model=list.firstWhereOrNull((element) => element.section_id =="10");

        _checkForBankingEnabled(context,list[index].list[subindex],home_model,"dash");

        break;
      case "33":
        Home_Model? home_model=list.firstWhereOrNull((element) => element.section_id =="10");

        _checkForBankingEnabled(context,list[index].list[subindex],home_model,"trans");
        break;

      case "36":
        Home_Model? home_model=list.firstWhereOrNull((element) => element.section_id =="10");

        _checkForBankingEnabled(context,list[index].list[subindex],home_model,"dash");
        break;

      case "28":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MY_Buy_Sell("1")));

        break;
      case "29":

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MY_Buy_Sell("2")));
        break;

      case "30":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Buy_Sell_Form("",list[index].list[subindex])));

        break;


      case "49":
        var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Legals()));

        break;

      case "50":
        var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Legal_Enquiry_List()));

        break;

      case "41":
        if(token.toString()!="null") {
          var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => Apply_Loan(null)));
        }else{
          var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));

        }
        break;
      case "58":
        var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => All_transactions()));

        break;
      case "59":
        var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Site_Visit()));

        break;

      case "60":
        var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => Apply_Loan(null)));

        break;

      case "61":
        var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => Ecommerce_Categeory()));

        break;

      case "62":
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Buy_Sell_Form("",null)));

        break;

      case "74":
        var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => Gift_Tab()));

        break;

      case "75":
        var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Coupon()));

        break;

      case "76":
        var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => Ecommerce_Categeory()));
        break;

      case "77":
        var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReferAndEarn(null)));
        break;


    }
  }

  // check_kyc(BuildContext context, Home_List_Model? list, Home_Model? home_model, String type) async {
  //   var res=await AppUtils().check_banking(context);
  //   if(res==true){
  //     var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Account_Statement(accNo)));
  //   }else{
  //
  //   }
  //
  //
  // }


  _checkForBankingEnabled(BuildContext context, Home_List_Model? list, Home_Model? home_model, String type) async {
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
            var accNo = data["acc_no"].toString();
            var name = data["name"];
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('acc_no', accNo);
            Navigator.of(context, rootNavigator: true).pop("Discard");
            if(type=="dash"){
              var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Banking_Dashboard(list,home_model)));

            }else{
              var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Account_Statement(accNo)));

            }

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