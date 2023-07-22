




import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/Kyc/Aadhar_Verification.dart';
import 'package:peprop_consumer_app/Kyc/Pan_Verification.dart';
import 'package:peprop_consumer_app/Rewards/Spin/Luck.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';
import '../../Sheets/All_Bottom_Sheets.dart';
import '../../Utils/ServiceConfig.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/Form_Fields.dart';
import '../../wish_list/Styles.dart';
import '../Coupon_types/Coupon_Detail_Widget.dart';


class My_Gift_Card_Details extends StatefulWidget{
  Gift_Card? my_coupon;
  bool is_purchaesd=false;

  My_Gift_Card_Details(Gift_Card my_coupon, bool is_purchaesd){
    this.my_coupon=my_coupon;
    this.is_purchaesd=is_purchaesd;





  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<My_Gift_Card_Details>{

  int selected=0;
  bool loading=false;
  bool update=false;




  int walletBalance=0;

  bool self=true;
  final address=TextEditingController();
  final name=TextEditingController();
  final mobile=TextEditingController();

  bool is_show=false;




  @override
  void initState() {
    super.initState();
    get_points();
    create_log();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppUtils.appBar_points(context, "Details",walletBalance.toString()),
      body:Stack(children: [
        if(loading)Center(child: new CircularProgressIndicator(),)else SingleChildScrollView(child:
        Padding(child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            new Container(
              child: new Row(
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
                      if(widget.is_purchaesd==true) new Container(child: new Row(children: [
                        Expanded(child: new Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child:new Text(widget.my_coupon!.BrandName+" of ₹ "+widget.my_coupon!.Denomination,style: Styles().styles_bold(20, ColorFile.black),maxLines: 2,)
                        ))
                      ],),),
                      if(widget.is_purchaesd==true) new Column(
                        children: [
                          new SizedBox(height: 10,),
                          new Container(child: new Row(children: [
                            Expanded(child: new Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,right: 5),height: 30,
                                child:new Text("Purchased on : "+AppUtils.convert_yyyy_mm_dd(widget.my_coupon!.request_time.toString()),style: Styles().styles_medium(16, ColorFile.black),maxLines: 2,)
                            ))

                          ],),),

                        ],
                      ),
                      if(widget.is_purchaesd==false) new Container(child: new Row(children: [
                        Expanded(child: new Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child:new Text(widget.my_coupon!.BrandName.toString(),style: Styles().styles_bold(20, ColorFile.black),maxLines: 2,)
                        ))
                      ],),),
                      if(widget.my_coupon!.denomination.length>0&&widget.is_purchaesd==false)new Container(child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Expanded(child: new Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,right: 5),
                              child:new Text("Gift card Worth Rs."+widget.my_coupon!.denomination[selected].Denomination.toString(),style: Styles().styles_medium(13, ColorFile.hint_color),maxLines: 2,)
                          )),



                        ],),),



                    ],
                  ),))


                ],
              ),
            ),

            if(widget.my_coupon!.denomination.length>0&&widget.is_purchaesd==false)

              new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new SizedBox(height: 20,),
                    new Container(child: new Text("Change Amount",style: Styles().styles_bold(17, Colors.black),),),
                    new SizedBox(height: 20,),
                    new Container(child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:widget.my_coupon!.denomination.length ,
                      itemBuilder: (ctx,int){
                        return new InkWell(child:    Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(selected!=int)Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.center,height: 40,padding: EdgeInsets.only(left: 20,right: 20),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),border: new Border.all(width: .5,color: ColorFile.hint_color)),child: new Text("₹ "+widget.my_coupon!.denomination[int].Denomination.toString(),style: Styles().styles_medium(14, Colors.black),),),
                            if(selected==int)Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.center,height: 40,padding: EdgeInsets.only(left: 20,right: 20),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),border: new Border.all(width: .5,color: ColorFile.hint_color),color: ColorFile.selectd_color),child: new Text("₹ "+widget.my_coupon!.denomination[int].Denomination.toString(),style: Styles().styles_medium(14, ColorFile.white),),)


                          ],
                        ),onTap: (){
                          setState(() {
                            selected=int;
                          });


                        },);

                      },
                    ),height: 40,),
                    new SizedBox(height: 20,),

                    new Container(child: new Row(),height: 1,color: ColorFile.lightgray,)


                  ],
                ),
              ),

            if(widget.is_purchaesd==false)

              new Column(
                children: [
                  new Container(
                    margin: EdgeInsets.only(top: 20),
                    child: new Row(
                      children: [
                        Expanded(child: new Container(child: new Column(
                          children: [
                            new Container(padding: EdgeInsets.all(15),height: 55,width: 55,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100), color: ColorFile.bgs),
                              child: new Image.asset("assets/gif1.png"),

                            ),
                            new SizedBox(height: 10,),

                            new Text(widget.my_coupon!.validity_duration.toString()+"\n",style: Styles().styles_medium(12, ColorFile.black),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)


                          ],
                        ),)),

                        Expanded(child: new Container(child: new Column(
                          children: [
                            new Container(padding: EdgeInsets.all(15),height: 55,width: 55,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100), color: ColorFile.bgs),
                              child: new Image.asset("assets/gif2.png"),

                            ),
                            new SizedBox(height: 10,),

                            new Text(widget.my_coupon!.valid_on.toString()+"\n",style: Styles().styles_medium(12, ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)


                          ],
                        ),)),


                        Expanded(child: new Container(child: new Column(
                          children: [
                            new Container(padding: EdgeInsets.all(15),height: 55,width: 55,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100), color: ColorFile.bgs),
                              child: new Image.asset("assets/shield.png"),

                            ),
                            new SizedBox(height: 10,),

                            new Text(widget.my_coupon!.payment_info.toString()+"\n",style: Styles().styles_medium(12, ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)


                          ],
                        ),)),

                      ],
                    ),),
                  new SizedBox(height: 20,),
                  new Container(child: new Row(),height: 1,color: ColorFile.lightgray,)
                ],
              ),

























            if(widget.is_purchaesd==true)new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new SizedBox(height: 20,),
              new Container(child:new Row(children: [ Icon(Icons.calendar_today,size: 13,),new SizedBox(width: 10,),new Text("Valid till : "+AppUtils().convert_date_forexpiry(widget.my_coupon!.use_validity.toString()),style: Styles().styles_regular(12, ColorFile.black),)],),) ,
              new SizedBox(height: 20,),
              Container(child: new Row(children: [],),height: 1,color: ColorFile.lightgray,),
            ],
          ),
            
            Coupon_Detail_Widget(widget.my_coupon!.StepsToRedeem.toString(),widget.my_coupon!.RewardDescription,widget.my_coupon!.coupon_code,widget.my_coupon!.coupon_pin,widget.my_coupon!.banner_multiple,widget.is_purchaesd,widget.my_coupon!.is_viewed,on_view: (){
              set_view();

            },),








          ],
        ),padding: EdgeInsets.all(10),)),
        if(update)Center(child: new CircularProgressIndicator(),)

      ],),
      bottomNavigationBar: Bottom_Button(widget.is_purchaesd==true?"Redeem Now":"Buy Now",onclick: (int){
        if(widget.is_purchaesd==true){
          AppUtils().open_url(widget.my_coupon!.Link.toString(), context);
        }else{

          if(widget.my_coupon!.denomination.length>0){
            validate();
          }else{


          }



        }




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

  Future<void> validate() async {
    if(walletBalance>=int.parse(widget.my_coupon!.denomination[selected].Denomination)){

      check_kyc();




    }else{
      var data=await All_Bottom_Sheets().error("Your Peprop.Money points are insufficient to make this purchase. Please fund your Peprop.Money point", context);
    }




  }

  Future<void> purchase() async {
    setState(() {
      update=true;

    });



    var map = new Map<String, dynamic>();
    map['giftcard_id'] =widget.my_coupon!.denomination[selected].id.toString();
    map['giftcard_value'] =widget.my_coupon!.denomination[selected].Denomination.toString();
    print(map.toString());
    FormData formData = new FormData.fromMap(map);
    var response=await Global_connection().post_method(formData,context, API.redeemGiftcard);
    setState(() {
      update=false;
    });
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["status"]==true){
      var data=await All_Bottom_Sheets().Success_dialog(response.data["message"].toString(), context);
      if(data!=null&&data==true){
        Navigator.pop(context,"response");
      }

    }else{
      AppUtils().show_error(context,response.data["data"] );
    }




  }


  check_kyc() async {

    var response=await AppUtils().check_kyc(context);
    if(response==true){
      var data=await All_Bottom_Sheets().accept_dialog("Gift Card", "I accept "+widget.my_coupon!.BrandName.toString()+" gift Card of worth ₹ "+widget.my_coupon!.denomination[selected].toString()+" payment terms and condition  for this purchase.", context);
      if(data!=null&&data==true){
        purchase();
      }
    }else{
      var data=await All_Bottom_Sheets().Confirmation_dialog("KYC Verification", "You need to Complete KYC verification First..!!!", context);
      if(data!=null&&data==true){
        var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pan_Verification()));
      }
    }

  }



  Future<void> set_view() async {

    var map = new Map<String, dynamic>();
    map['reward_type'] ="3";
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
    map['is_coupon'] ="0";

    FormData formData = new FormData.fromMap(map);
    var response=await Global_connection().post_method(formData,context, API.logGiftcardsView);



  }

}