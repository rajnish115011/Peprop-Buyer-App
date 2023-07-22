




import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/Rewards/Spin/Luck.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';
import '../../Sheets/All_Bottom_Sheets.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/Form_Fields.dart';
import '../../wish_list/Styles.dart';
import '../Coupon_types/Coupon_Detail_Widget.dart';


class My_Coupon_Details extends StatefulWidget{
  Coupons? my_coupon;

  My_Coupon_Details(Coupons my_coupon){
    this.my_coupon=my_coupon;



  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<My_Coupon_Details>{

  int selected=0;
  bool loading=false;
  bool update=false;




  int walletBalance=0;

  bool self=true;
  final address=TextEditingController();
  final name=TextEditingController();
  final mobile=TextEditingController();


  @override
  void initState() {
    super.initState();
    get_points();
    create_log();


  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: AppUtils.appBar_points(context, "Details",walletBalance.toString()),
      body:Stack(children: [
        if(loading)Center(child: new CircularProgressIndicator(),)else SingleChildScrollView(child:
        Padding(child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            new Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8), // Border radius
                      child: ClipOval(child:FadeInImage.assetNetwork(
                        placeholder: 'assets/loading.png',
                        image:widget.my_coupon!.BrandLogo,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/placeholder.png",
                          );//do something
                        },
                      )),
                    ),
                  ),
                  new SizedBox(width: 10,),
                  Expanded(child: new Container(child: new Column(
                    children: [
                      new Container(child: new Row(children: [
                        Expanded(child: new Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child:new Text(widget.my_coupon!.RewardTitle,style: Styles().styles_bold(20, ColorFile.black),maxLines: 2,)
                        ))

                      ],),),
                     if(widget.my_coupon!.assigned_at.toString().length>0) new Column(
                        children: [
                          new SizedBox(height: 10,),
                          new Container(child: new Row(children: [
                            Expanded(child: new Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,right: 5),
                                child:new Text("Assigned on : "+AppUtils.convert_yyyy_mm_dd(widget.my_coupon!.assigned_at.toString()),style: Styles().styles_medium(16, ColorFile.black),maxLines: 2,)
                            ))

                          ],),),

                        ],
                      ),
                    ],
                  ),))
                ],
              ),
            ),
























            new SizedBox(height: 20,),
            new Container(child:new Row(children: [ Icon(Icons.calendar_today,size: 13,),new SizedBox(width: 10,),new Text("Valid till : "+AppUtils().convert_date_forexpiry(widget.my_coupon!.ExpiryDate.toString()),style: Styles().styles_regular(12, ColorFile.black),)],),) ,
            new SizedBox(height: 20,),
            Container(child: new Row(children: [],),height: 1,color: ColorFile.lightgray,),








            Coupon_Detail_Widget(widget.my_coupon!.StepsToRedeem.toString(),widget.my_coupon!.RewardDescription,widget.my_coupon!.RewardCode,widget.my_coupon!.pin,widget.my_coupon!.banner_multiple,true,widget.my_coupon!.is_viewed,on_view: (){

              set_view();
            },),








          ],
        ),padding: EdgeInsets.all(10),)),
        if(update)Center(child: new CircularProgressIndicator(),)

      ],),
      bottomNavigationBar: Bottom_Button("Redeem Now",onclick: (int){

        AppUtils().open_url(widget.my_coupon!.Link.toString(), context);



      },) ,

    );

  }

  Future<void> get_points() async {
     setState(() {
      loading=true;
    });
    var response=await Global_connection().post_method(new Map(),context, API.walletBalance);
    print(response.data.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["walletBalance"]!=null&&response.data["walletBalance"]!=""){
      walletBalance=int.parse(response.data["walletBalance"].toString());
    }

    setState(() {
      loading=false;
    });


  }

  Future<void> set_view() async {

    var map = new Map<String, dynamic>();
    map['reward_type'] ="2";
    map['reward_id'] =widget.my_coupon!.id.toString();
    FormData formData = new FormData.fromMap(map);
    setState(() {
      update=true;
    });
    var response=await Global_connection().post_method(formData,context, API.markCouponViewed);
    print(response.data.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200){
      widget.my_coupon!.is_viewed="1";

    }

    setState(() {
      update=false;
    });


  }


  Future<void> create_log() async {

    var map = new Map<String, dynamic>();
    map['giftcard_id'] =widget.my_coupon!.id.toString();
    map['is_coupon'] ="1";

    FormData formData = new FormData.fromMap(map);
    var response=await Global_connection().post_method(formData,context, API.logGiftcardsView);



  }


}