

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Utils/FireBase_Logs.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/CustomDateRangePicker.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';


import '../Color/ColorFile.dart';
import '../Models/Account_Statement_Medels.dart';
import '../Utils/AppUtils.dart';


class Account_Statement extends StatefulWidget{
  String acc_no="";
  Account_Statement(String acc_no){
    this.acc_no=acc_no;
  }




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Account_Statement>{

  bool _isLoading=false;
  DateTime start_date=DateTime.now();
  DateTime end_date=DateTime.now();
  List<Account_Statement_Medels>statement_list=[];

  @override
  void initState() {

    _getAccountDetails(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Scaffold(
      appBar: AppUtils.appBarTitle(context,"Account Statement"),
      backgroundColor: ColorFile.white,
      body: Stack(
       children: [
         _isLoading==true?Center(child: new CircularProgressIndicator(),):new SingleChildScrollView(
           child:new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               new Container(
                 padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                 color: ColorFile.app_color,
                 child: new Row(
                   children: [
                     Expanded(flex: 1,child: new Container(
                       alignment: Alignment.center,
                       child: new Text("Date",style: new TextStyle(fontFamily: "bold",color: ColorFile.white,fontSize: 14),),

                     )),
                     SizedBox(width: 5,),
                     Expanded(flex: 2,child: new Container(
                       alignment: Alignment.center,
                       child: new Text("Transaction ID",style: new TextStyle(fontFamily: "bold",color: ColorFile.white,fontSize: 14),),

                     )),
                     SizedBox(width: 5,),
                     Expanded(flex: 1,child: new Container(
                       alignment: Alignment.center,
                       child: new Text("Amount",style: new TextStyle(fontFamily: "bold",color: ColorFile.white,fontSize: 14),),

                     )),
                     SizedBox(width: 5,),
                     Expanded(flex: 1,child: new Container(
                       alignment: Alignment.center,
                       child: new Text("Balance",style: new TextStyle(fontFamily: "bold",color: ColorFile.white,fontSize: 14),),

                     )),
                     SizedBox(width: 5,),

                   ],
                 ),
               ),
               ListView.builder(
                   shrinkWrap: true,
                   physics:NeverScrollableScrollPhysics(),
                   itemCount: statement_list.length,
                   itemBuilder: (context, index) {
                     return new Container(
                       padding: EdgeInsets.only(left: 10,right: 10),
                       height: 70,
                       color: (index % 2 == 0)?ColorFile.lightgray:ColorFile.white,
                       child: new Row(
                         children: [
                           Expanded(flex: 1,child: new Container(
                             alignment: Alignment.center,
                             child: new Text(AppUtils.server_utc_date_parse(statement_list[index].created_at).toString(),style: new TextStyle(fontFamily: "regular",color: ColorFile.black,fontSize: 10),),

                           )),
                           new Container(width: 1,height: 70,color: ColorFile.hint_color,),
                           Expanded(flex: 2,child: new Container(
                             alignment: Alignment.center,
                             child: new Text(statement_list[index].trans_id,style: new TextStyle(fontFamily: "regular",color: ColorFile.black,fontSize: 10),),

                           )),
                           new Container(width: 1,height: 70,color: ColorFile.hint_color,),
                           if(widget.acc_no==statement_list[index].dr_acc)
                             Expanded(flex: 1, child: new Container(
                               alignment: Alignment.center,
                               child: new Text("₹ - "+statement_list[index].amount,
                                 style: new TextStyle(fontFamily: "regular",
                                     color: ColorFile.red_900,
                                     fontSize: 10),),

                             )),

                           if(widget.acc_no!=statement_list[index].dr_acc)
                             Expanded(flex: 1, child: new Container(
                               alignment: Alignment.center,
                               child: new Text("₹ + "+statement_list[index].amount,
                                 style: new TextStyle(fontFamily: "regular",
                                     color: ColorFile.greens,
                                     fontSize: 10),),

                             )),
                           new Container(width: 1,height: 70,color: ColorFile.hint_color,),
                           Expanded(flex: 1,child: new Container(
                             alignment: Alignment.center,
                             child: new Text("₹"+statement_list[index].balance,style: new TextStyle(fontFamily: "regular",color: ColorFile.black,fontSize: 10),),

                           )),
                           SizedBox(width: 5,),

                         ],
                       ),
                     );




                   }),
               if(statement_list.length==0)Center(child: No_Data_Placeholder("You have not done any transaction..!!"),)



             ],
           ),

         ),
       ],
     ),
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child:new Icon(Icons.filter_alt_outlined),
          backgroundColor: new Color(0xFFE57373),
          onPressed: () async {
            showCustomDateRangePicker(
              context,
              minimumDate: DateTime(1900),
              maximumDate:  DateTime(2050),
              dismissible: true,
              endDate: start_date,
              startDate: end_date,
              onApplyClick: (s, e) {
                setState(() {
                  start_date=s;
                  end_date=e;
                  _getAccountDetails(context);
                });
              },
              onCancelClick: () {
                setState(() {

                });
              },
            );
          }
      ),


    );
  }
  _getAccountDetails(BuildContext context) async {

    await FireBase_Logs().log_screen_view("Account Statement", "View Account Statement");


    statement_list.clear();
    var map = new Map<String, dynamic>();
    map['acc_no'] = widget.acc_no;
    map['start_date'] = DateFormat("yyyy-MM-dd").format(start_date).toString();
    map['last_date'] = DateFormat("yyyy-MM-dd").format(end_date).toString();
    FormData formData = new FormData.fromMap(map);
    setState(() {
      _isLoading=true;
    });

    ServiceConfig().postApiBodyAuthJson(API.accountHistory,formData, context).then((value) {
      Response response = value;
      print('resoponse  message $response');
      setState(() {
        _isLoading=false;
      });
      if (response != null && response.statusCode == 200) {
        print(response.data.toString());
        var notify = response.data["data"] as List;
        statement_list = notify.map<Account_Statement_Medels>((json) => Account_Statement_Medels.fromJson(json)).toList();

      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((error, stackTrace) async {
       AppUtils.toAst("Something Went Wrong..!!",context);
      setState(() {
        _isLoading=false;
      });
    });
  }

}