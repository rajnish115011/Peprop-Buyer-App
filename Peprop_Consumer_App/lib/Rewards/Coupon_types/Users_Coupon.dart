import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:peprop_consumer_app/Rewards/ReferAndEarn.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/Bottom_Button.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';
import '../../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../../wish_list/Styles.dart';
import '../Spin/Luck.dart';
import 'Widget_Coupons_Grid.dart';


class Users_Coupon extends StatefulWidget{


  String type="";
  Users_Coupon(String type){
    this.type=type;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Users_Coupon>{


  List<Gift_Card>gift_cards=[];





  @override
  void initState() {
    super.initState();
    get_campaign();

  }

  bool loading=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarcolor(context, "Gift Cards", ColorFile.dark_blue),
      body:Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)
          else new
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(gift_cards.length>0)Widget_Gift_Grid1(gift_cards,false,null,true) else No_Data_Placeholder("Gift Card Not Available.!!"),

            ],
          )
        ],
      ),

    );
  }

  get_campaign() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['category_id'] =widget.type;
    
    
    print(json.encode(map));
    FormData formData = new FormData.fromMap(map);
    setState(() {
      loading=true;
    });
    var response=await Global_connection().post_method(formData,context, API.getLevelsOffers);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["list"]!=null){
        if(response.data["list"]["gift_cards"]!=null){
        var notify = response.data["list"]["gift_cards"] as List;
        gift_cards = notify.map<Gift_Card>((json) => Gift_Card.fromJson(json)).toList();
        }






    }


    setState(() {
      loading=false;
    });


  }

}