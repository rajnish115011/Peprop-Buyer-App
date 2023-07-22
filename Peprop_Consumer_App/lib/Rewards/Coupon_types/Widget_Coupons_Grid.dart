import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Cost_Sheet/model/Builder_Detail_Model.dart';

import 'package:peprop_consumer_app/Rewards/ReferAndEarn.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';
import '../../Sheets/All_Bottom_Sheets.dart';
import '../../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../../wish_list/Styles.dart';
import '../My_Coupon/My_Coupon_Details.dart';
import '../My_Gift_Card/My_Gift_Card_Details.dart';
import '../Spin/Luck.dart';


class Widget_Coupons_Grid extends StatelessWidget {
   List<Coupons> unlocked_coupon=[];
   SectionBanner? section_banner;
  Widget_Coupons_Grid(List<Coupons> unlocked_coupon, SectionBanner? section_banner){
    this.unlocked_coupon=unlocked_coupon;
    this.section_banner=section_banner;





  }

  @override
  Widget build(BuildContext context) {

    print("size"+unlocked_coupon.length.toString());

    return

      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        itemCount: unlocked_coupon.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
          height: 200.0,),
        itemBuilder: (BuildContext context, int index) {
          return new
          InkWell(child: Container(alignment: Alignment.center,
            child:
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new SizedBox(height: 10,),
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8), // Border radius
                        child: ClipOval(child:CachedNetworkImage(
                          imageUrl:unlocked_coupon[index].BrandLogo,
                            width:80,
                            height: 80,

                        )),
                      ),
                    ),

                    // new Container(padding: EdgeInsets.all(10),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),border: new Border.all(width: 1,color: ColorFile.greens)),height: 80,width: 80,alignment: Alignment.center,child:   FadeInImage.assetNetwork(
                    //   placeholder: 'assets/loading.png',
                    //   image:unlocked_coupon[index].BrandLogo,
                    //   width:80,
                    //
                    //   height: 80,
                    //   imageErrorBuilder: (context, error, stackTrace) {
                    //     return Image.asset("assets/placeholder.png",
                    //         width: 80,
                    //         fit: BoxFit.cover,
                    //         height: 80);//do something
                    //   },
                    // )),


                    new SizedBox(height: 10,),
                    Expanded(flex: 3,child:new Container(alignment: Alignment.center,child: new Text(unlocked_coupon[index].BrandName,style: Styles().styles_bold(15, ColorFile.black),textAlign: TextAlign.center,),)),
                    Expanded(flex: 2,child:
                    new Container(
                        alignment: Alignment.centerLeft,
                        decoration: new BoxDecoration(borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.greens),
                        padding: EdgeInsets.only(left: 5,right: 5),height: 30,
                        child:new Text(unlocked_coupon[index].RewardTitle,style: Styles().styles_regular(10, ColorFile.white),maxLines: 2,)
                    ))
                  ],
                ),
                if(unlocked_coupon[index].is_locked==true) new Container(
                  height: 40,
                  color: ColorFile.hexblack,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.lock,color: ColorFile.white,),
                      new SizedBox(width: 10,),

                      new Text("Locked",style: Styles().styles_medium(12, ColorFile.white),)

                    ],
                  ),)
              ],
            ),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.blue_200)),),
            onTap: () async {
              if(unlocked_coupon[index].is_locked==false) {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => My_Coupon_Details(unlocked_coupon[index])));
              }else{
                var data=await All_Bottom_Sheets().Confirmation_dialog("Unlock Coupon", "Please book site visit or buy unit to unlock the coupon.", context);

              }



            },
          );
        },
      );
    // TODO: implement build




  }



}


class Widget_Order extends StatelessWidget {
  List<Orders> unlocked_coupon=[];
  String name="";

  Function(int)track;
  Function(int)cancel_order;

  Widget_Order(List<Orders> unlocked_coupon, String name,{required this.track,required this.cancel_order}){
    this.unlocked_coupon=unlocked_coupon;
    this.name=name;





  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return

      Expanded(child: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        itemCount: unlocked_coupon.length,
        itemBuilder: (BuildContext context, int index) {
          return new
          InkWell(child: Container(alignment: Alignment.center,
            child:Container(
              margin: EdgeInsets.only(top: 10),
              decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),border: new Border.all(width: 1,color: ColorFile.lightgray)),
              child: new Column(
                children: [
                  new Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    height: 50,child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      new Text("Ordered Date : ",style: Styles().styles_medium(17, Colors.black),),

                      new Text(AppUtils.server_dd_mm_yyyy(unlocked_coupon[index].created_at),style: Styles().styles_regular(15, Colors.black),)

                    ],
                  ),),
                  new Container(child: new Row(),height: 1,color: ColorFile.lightgray,),
                  new Container(
                    padding: EdgeInsets.only(top: 20,bottom: 20,left: 10),

                    child: new Row(
                    children: [


                      new Container(height: 100,width:120,padding: EdgeInsets.all(5),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10)),child: new Image.network(unlocked_coupon[index].image.toString(),fit: BoxFit.fill,),)


                      ,
                      new SizedBox(width: 20,),


                      Expanded(child: Container(child: new Column(
                        children: [
                          new Container(alignment: Alignment.centerLeft,child: new Text(unlocked_coupon[index].title,style: Styles().styles_medium(16, ColorFile.black)),),



                          new Container(
                            margin: EdgeInsets.only(top: 5),
                            alignment: Alignment.centerLeft,child: new Text("Seller : "+unlocked_coupon[index].seller_name,style: Styles().styles_regular(16, ColorFile.hint_color)),),



                          new Container(
                            margin: EdgeInsets.only(top: 5),
                            alignment: Alignment.centerLeft,child: new Text("₹"+unlocked_coupon[index].price,style: Styles().styles_regular(14, ColorFile.hint_color)),),


                          if(unlocked_coupon[index].ship_address.length>0)new Container(margin: EdgeInsets.only(top: 5),alignment: Alignment.centerLeft,child: new Text("Shipping Address : "+unlocked_coupon[index].ship_address,style: Styles().styles_regular(14, ColorFile.hint_color)),),



                        ],
                      ),))



                    ],
                  ),),
                  new Container(child: new Row(),height: 1,color: ColorFile.lightgray,),
                  new Container(

                    padding: EdgeInsets.only(left: 10),
                    child: new Column(
                      children: [
                        new Container(
                          margin: EdgeInsets.only(top: 5,),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(width: 120,child: new Text("Order ID : ",style: Styles().styles_bold(16, Colors.black),)),
                            Expanded(child: new Container(margin:EdgeInsets.only(left: 20),child: new Text("ORD"+unlocked_coupon[index].id,style: Styles().styles_regular(14, ColorFile.hexblack),),)),


                          ],
                        ),),
                        new Container(
                          margin: EdgeInsets.only(top: 5),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(width: 120,child: new Text("Total : ",style: Styles().styles_bold(16, Colors.black),)),
                            Expanded(child: new Container(margin:EdgeInsets.only(left: 20),child: new Text("₹"+unlocked_coupon[index].price,style: Styles().styles_regular(14, ColorFile.hexblack),),)),


                          ],
                        ),),
                        new Container(
                          margin: EdgeInsets.only(top: 5,bottom: 5),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(width: 120,child: new Text("Ship to : ",style: Styles().styles_bold(16, Colors.black),)),
                            Expanded(child: new Container(margin:EdgeInsets.only(left: 20),child: new Text(name.toString(),style: Styles().styles_regular(14, ColorFile.hexblack),),)),


                          ],
                        ),)
                      ],
                    ),
                  ),
                  new Container(child: new Row(),height: 1,color: ColorFile.lightgray,),
                  new Container(
                    padding: EdgeInsets.only(left: 10),
                    child: new Column(
                      children: [
                        new Container(
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            child: new Row(
                            children: [
                              new SizedBox(width: 10,),
                              Expanded(flex: 1,child:
                              unlocked_coupon[index].shipping=="1"?InkWell(child: new Container(alignment: Alignment.center,height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.yellowdark),child: new Text("Track Order",style: Styles().styles_regular(14, ColorFile.black),),),onTap: (){
                                track(index);

                              },):new Container()),
                              new SizedBox(width: 20,),
                              Expanded(flex: 1,child:unlocked_coupon[index].shipping=="0"?InkWell(
                                onTap: (){
                                  if(unlocked_coupon[index].cancel=="0"){
                                    cancel_order(index);

                                  }

                                },

                                child:
                                new Container(alignment: Alignment.center,height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.red_900),child: new Text(unlocked_coupon[index].cancel=="0"?"Cancel Order":"Order Canceled",style: Styles().styles_regular(14, ColorFile.white),),),


                              ):new Container()),
                              new SizedBox(width: 10,),

                            ],
                          ),),

                      ],
                    ),
                  ),





                ],
              ),






            )


          ));
        },
      ));
  }



}



class Widget_Gift_Grid extends StatelessWidget {
  List<Gift_Card> unlocked_coupon=[];
  bool is_purchaesd=false;
  SectionBanner? section_banner;
  bool is_window=false;
  Widget_Gift_Grid(List<Gift_Card> unlocked_coupon, bool is_purchaesd, SectionBanner? section_banner,bool is_window){
    this.unlocked_coupon=unlocked_coupon;
    this.is_purchaesd=is_purchaesd;
    this.section_banner=section_banner;
    this.is_window=is_window;





  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
            return 
              
              new Column(
                children: [
                  if(section_banner!=null)Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      child:new Stack(
                        alignment: Alignment.bottomCenter,
                        children: [


                          ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:section_banner!.my_giftcards_section.toString(),
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
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    itemCount: unlocked_coupon.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                      height: 200.0,),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(child: Container(alignment: Alignment.center,
                        child:

                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new SizedBox(height: 10,),

                                CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8), // Border radius
                                    child: ClipOval(child:CachedNetworkImage(
                                      imageUrl:unlocked_coupon[index].BrandLogo,
                                      width:80,
                                      height: 80,

                                    )),
                                  ),
                                ),




                                new SizedBox(height: 10,),
                                Expanded(flex: 3,child:new Container(alignment: Alignment.center,child: new Text(unlocked_coupon[index].BrandName,style: Styles().styles_bold(15, ColorFile.black),textAlign: TextAlign.center,),)),
                                Expanded(flex: 2,child:
                                new Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: new BoxDecoration(borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.greens),
                                    padding: EdgeInsets.only(left: 5,right: 5),height: 30,
                                    child:new Text(unlocked_coupon[index].RewardTitle,style: Styles().styles_regular(10, ColorFile.white),maxLines: 2,)
                                ))
                              ],
                            ),
                            if(unlocked_coupon[index].is_locked==true) new Container(
                              height: 40,
                              color: ColorFile.hexblack,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.lock,color: ColorFile.white,),
                                  new SizedBox(width: 10,),

                                  new Text("Locked",style: Styles().styles_medium(12, ColorFile.white),)

                                ],
                              ),)
                          ],
                        ),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.blue_200)),),
                        onTap: () async {
                          if(unlocked_coupon[index].is_locked==false) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => My_Gift_Card_Details(unlocked_coupon[index],is_purchaesd)));
                          }else{
                            var data=await All_Bottom_Sheets().Confirmation_dialog("Unlock Gift Card", "Please book site visit or buy unit to unlock the gift Card.", context);

                          }




                        },
                      );
                    },
                  )
                ],
              );
      },
    ));
  }



}

class Widget_Gift_Grid1 extends StatelessWidget {
  List<Gift_Card> unlocked_coupon=[];
  bool is_purchaesd=false;
  SectionBanner? section_banner;
  bool is_window=false;
  Widget_Gift_Grid1(List<Gift_Card> unlocked_coupon, bool is_purchaesd, SectionBanner? section_banner,bool is_window){
    this.unlocked_coupon=unlocked_coupon;
    this.is_purchaesd=is_purchaesd;
    this.section_banner=section_banner;
    this.is_window=is_window;





  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child:
    GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: unlocked_coupon.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        height: 200.0,),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(child: Container(alignment: Alignment.center,
          child:

          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new SizedBox(height: 10,),
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8), // Border radius
                      child: ClipOval(child:FadeInImage.assetNetwork(
                        placeholder: 'assets/loading.png',
                        image:unlocked_coupon[index].BrandLogo,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/placeholder.png",
                          );//do something
                        },
                      )),
                    ),
                  ),
                  new SizedBox(height: 10,),
                  Expanded(flex: 3,child:new Container(alignment: Alignment.center,child: new Text(unlocked_coupon[index].BrandName,style: Styles().styles_bold(15, ColorFile.black),textAlign: TextAlign.center,),)),
                  Expanded(flex: 2,child:
                  new Container(
                      alignment: Alignment.centerLeft,
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.greens),
                      padding: EdgeInsets.only(left: 5,right: 5),height: 30,
                      child:new Text(unlocked_coupon[index].RewardTitle,style: Styles().styles_regular(10, ColorFile.white),maxLines: 2,)
                  ))
                ],
              ),
              if(unlocked_coupon[index].is_locked==true) new Container(
                height: 40,
                color: ColorFile.hexblack,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.lock,color: ColorFile.white,),
                    new SizedBox(width: 10,),

                    new Text("Locked",style: Styles().styles_medium(12, ColorFile.white),)

                  ],
                ),)
            ],
          ),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.blue_200)),),
          onTap: () async {
            if(unlocked_coupon[index].is_locked==false) {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => My_Gift_Card_Details(unlocked_coupon[index],is_purchaesd)));
            }else{
              var data=await All_Bottom_Sheets().Confirmation_dialog("Unlock Gift Card", "Please book site visit or buy unit to unlock the gift Card.", context);

            }




          },
        );
      },
    ));
  }



}