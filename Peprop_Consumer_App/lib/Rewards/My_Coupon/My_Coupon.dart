import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Cost_Sheet/model/Builder_Detail_Model.dart';
import '../../Global_connection/Global_connection.dart';

import '../../Search/Search_View_Custom.dart';
import '../../wish_list/Styles.dart';
import '../Coupon_types/Widget_Coupons_Grid.dart';
import '../Spin/Luck.dart';


class My_Coupon extends StatefulWidget{


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

class Build_State extends State<My_Coupon>{

  List<Coupons>unlocked_coupon=[];
  List<Coupons>locked_coupon=[];



  List<Coupons>all_coupon=[];

  SectionBanner?section_banner;


  @override
  void initState() {
    super.initState();
    get_campaign();

  }

  bool loading=false;
  final search_controller =TextEditingController();
  @override
  Widget build(BuildContext context) {




    return new Scaffold(

      backgroundColor: ColorFile.white,
      appBar: new AppBar(
        leading: new Container(),
        backgroundColor: ColorFile.white,
        toolbarHeight: 150,
        flexibleSpace: new Container(
          child: new Column(
            children: [
             AppUtils.appBarTitle(context, "Coupons"),
              Search_Brand(search_controller,on_search: (value){
                onchanged(value.toString());
              }),
            ],
          ),
        ),
        elevation: 0,
      ),

      body:Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)else
           SingleChildScrollView(
            child:new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                if(section_banner!=null)Container(
                    margin: const EdgeInsets.only(bottom: 8.0,left: 10,right: 10),
                    child:new Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl:section_banner!.my_coupons_section.toString(),
                            height: 170,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,

                            errorWidget: (context, url, error) =>Image.asset(
                              "assets/placeholder.png",
                              height: 0,

                            ),
                          ),
                        ),



                      ],
                    )

                ),
                if(unlocked_coupon.length>0)Widget_Coupons_Grid(unlocked_coupon,section_banner)else No_Data_Placeholder("No Coupons Available.!!"),



              ],
            ) ,
          )
        ],
      ),

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



      //   "section_banner": {
    // "my_coupons_section": "https://demo.drmactive.in/uploads/sections/COUPON_BANNER.png",
    // "my_giftcards_section": "https://demo.drmactive.in/uploads/sections/BANNER.png"
    // }
      if(response.data["list"]["unlocked_coupons"]!=null){
        var notify = response.data["list"]["unlocked_coupons"] as List;
        unlocked_coupon = notify.map<Coupons>((json) => Coupons.fromJson(json)).toList();

      }
      if(response.data["list"]["locked_coupons"]!=null){
        var notify = response.data["list"]["locked_coupons"] as List;
        locked_coupon = notify.map<Coupons>((json) => Coupons.fromJson(json)).toList();
        locked_coupon.forEach((element) {
         element.is_locked=true;
       });



      }
      unlocked_coupon.addAll(locked_coupon);
      all_coupon.addAll(unlocked_coupon);



    }
    setState(() {
      loading=false;
    });


  }


  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        unlocked_coupon.clear();
        unlocked_coupon.addAll(all_coupon);
      });
    }else{
      unlocked_coupon.clear();
      all_coupon.forEach((element) {
        if(element.BrandName.toString().toLowerCase().contains(value.toString().toLowerCase())){
          unlocked_coupon.add(element);
        }
      });
      setState(() {
      });
    }
  }
  SliverAppBar header() {
    return
      SliverAppBar(
          backgroundColor: ColorFile.dark_blue,
          pinned: false,

          centerTitle: true,
          title:new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: new Container(alignment: Alignment.center,child:  Text("My Coupons",style: Styles().styles_bold(18, ColorFile.white),),)),
              new SizedBox(width: 50,)
            ],
          )
      );
  }
  SliverAppBar search_bar() {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 100,
      elevation: 0,
      backgroundColor: ColorFile.dark_blue,
      leadingWidth: 0,
      leading: new Container(),
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 55,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(1.1, 1.1),
                blurRadius: 5.0),
          ],
        ),
        child: CupertinoTextField(
          controller: search_controller,
          onChanged: (value){
            onchanged(value.toString());
          },
          keyboardType: TextInputType.text,
          placeholder: 'Search',
          style: new TextStyle(fontSize: 16,color: ColorFile.black),
          placeholderStyle: TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 12.0,
            fontFamily: 'regular',
          ),
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
            child: Icon(
              Icons.search,
              size: 18,
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}