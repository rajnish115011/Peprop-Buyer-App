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
import '../../Cost_Sheet/model/Builder_Detail_Model.dart';
import '../../Global_connection/Global_connection.dart';
import '../../Search/Search_View_Custom.dart';
import '../../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../../wish_list/Styles.dart';
import '../Coupon_types/Widget_Coupons_Grid.dart';
import '../Spin/Luck.dart';


class All_Gift_Card extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<All_Gift_Card>{


  List<Gift_Card>my_giftcards=[];

  List<Gift_Card>all_giftcards=[];


  SectionBanner?section_banner;



  @override
  void initState() {
    super.initState();
    get_campaign();

  }

  bool loading=false;
  final search_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new   Stack(
      children: [
        if(loading)Center(child: new CircularProgressIndicator(),)
        else new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Search_Brand(search_controller,on_search: (value){
              onchanged(value.toString());

            }),
            if(my_giftcards.length>0)Widget_Gift_Grid(my_giftcards,false,section_banner,false)else No_Data_Placeholder("No Gift Card Available.!!"),

          ],
        ),
      ],
    );
  }

  get_campaign() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['user_id'] =sharedPreferences.getString("user_id").toString();





    FormData formData = new FormData.fromMap(map);
    setState(() {
      loading=true;
    });
    var response=await Global_connection().post_method(formData,context, API.getLevelsOffers);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["list"]!=null){
      if(response.data["section_banner"]!=null){
        var builder_details = response.data["section_banner"];
        section_banner = SectionBanner.fromJson(builder_details);

      }
      if(response.data["list"]["gift_cards"]!=null){
        var notify = response.data["list"]["gift_cards"] as List;
        my_giftcards = notify.map<Gift_Card>((json) => Gift_Card.fromJson(json)).toList();
        all_giftcards = notify.map<Gift_Card>((json) => Gift_Card.fromJson(json)).toList();

      }

    }
    setState(() {
      loading=false;
    });


  }
  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        my_giftcards.clear();
        my_giftcards.addAll(all_giftcards);
      });
    }else{
      my_giftcards.clear();
      all_giftcards.forEach((element) {
        if(element.BrandName.toString().toLowerCase().contains(value.toString().toLowerCase())){
          my_giftcards.add(element);
        }
      });
      setState(() {
      });
    }
  }
}