import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';

import '../../Search/Search_View_Custom.dart';
import '../../Sheets/All_Bottom_Sheets.dart';
import '../Coupon_types/Widget_Coupons_Grid.dart';
import '../Spin/Luck.dart';


class My_Orders extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<My_Orders>{

  List<Orders>my_order=[];




  List<Orders>all_order=[];
  String  name="";


  @override
  void initState() {
    super.initState();
    get_campaign();

  }

  bool loading=false;
  bool update=false;
  final search_controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarcolor(context, "My Orders", ColorFile.dark_blue),
      body:Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)
          else new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Search_Brand(search_controller,on_search: (value){
                 onchanged(value.toString());

              }),
              new SizedBox(height: 20,),

              if(my_order.length>0)Widget_Order(my_order,name,track: (int){
                track(int);
              },cancel_order: (int){
                cancel_confirmation(int);

              },)else No_Data_Placeholder("No Orders Available.!!"),


            ],
          ),
          if(update)Center(child: new CircularProgressIndicator(),)

        ],
      ),

    );
  }

  get_campaign() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['user_id'] =sharedPreferences.getString("user_id").toString();

    name=sharedPreferences.getString("full_name").toString();
    print(sharedPreferences.getString("user_id").toString());
    FormData formData = new FormData.fromMap(map);
    setState(() {
      loading=true;
    });
    var response=await Global_connection().post_method(formData,context, API.my_order);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      if(response.data["data"]!=null){
        var notify = response.data["data"] as List;
        my_order = notify.map<Orders>((json) => Orders.fromJson(json)).toList();
        all_order = notify.map<Orders>((json) => Orders.fromJson(json)).toList();






      }


    }
    setState(() {
      loading=false;
    });


  }


  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        my_order.clear();
        my_order.addAll(all_order);
      });
    }else{
      my_order.clear();
      all_order.forEach((element) {
        if(element.title.toString().toLowerCase().contains(value.toString().toLowerCase())){
          my_order.add(element);
        }
      });
      setState(() {
      });
    }
  }

  Future<void> cancel_confirmation(int int) async {

    var data=await All_Bottom_Sheets().Confirmation_dialog("Cancel Order", "Are you sure,Do you want to cancel this order?", context);
    if(data!=null&&data==true){

      cancel(int);



    }

  }

  Future<void> cancel(int int) async {

    setState(() {
      update=true;
    });
    var map = new Map<String, dynamic>();

    map['order_id'] =my_order[int].id.toString();
    FormData formData = new FormData.fromMap(map);
    print(map);
    var response=await Global_connection().post_method(formData,context, API.cancel_order);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      my_order[int].cancel="1";
      AppUtils.toAst("Order Canceled..!!!", context);
    }
    setState(() {
      update=false;
    });


  }


  Future<void> track(int int) async {
    setState(() {
      update=true;
    });
    var map = new Map<String, dynamic>();
    map['order_id'] =my_order[int].id.toString();
    FormData formData = new FormData.fromMap(map);
    var response=await Global_connection().post_method(formData,context, API.track_order);
    print(response.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["message"]!=null){
      AppUtils().show_error(context, response.data["message"].toString());

    }
    setState(() {
      update=false;
    });


  }



}