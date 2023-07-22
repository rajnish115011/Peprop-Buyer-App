import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:peprop_consumer_app/Rewards/ReferAndEarn.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';
import '../../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../../wish_list/Styles.dart';
import '../Spin/Luck.dart';


class Coupon_Detail_Widget extends StatelessWidget {

  String stepsToRedeem="";
  String rewardDescription="";

  String rewardCode="";
  String pin="";
  String is_viewed="";
  List banner_multiple=[];
  bool is_purchaesd=false;
  Function()on_view;

  Coupon_Detail_Widget(String stepsToRedeem, String rewardDescription, String rewardCode, String pin, List banner_multiple,bool is_purchaesd, String is_viewed,{required this.on_view}){
    this.stepsToRedeem=stepsToRedeem;
    this.rewardDescription=rewardDescription;
    this.rewardCode=rewardCode;
    this.pin=pin;
    this.banner_multiple=banner_multiple;

    this.is_purchaesd=is_purchaesd;
    this.is_viewed=is_viewed;




  }





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return

      new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(rewardCode!=""&&is_purchaesd==true&&is_viewed=="1") new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new SizedBox(height: 20,),
              new Text("CODE",style: Styles().styles_regular(12, ColorFile.hint_color),),
              new SizedBox(height: 5,),
              new Row(
                children: [
                  FDottedLine(
                    color: ColorFile.lightgray,
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    strokeWidth: 2.0,
                    dottedLength: 10.0,
                    space: 2.0,
                    child:new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 15,right: 15),height: 33,child: new Text(rewardCode.toString()),),
                  ),

                  InkWell(
                    onTap: (){
                      Clipboard.setData(ClipboardData(text: rewardCode.toString()));
                      AppUtils.toAst("Code Copied", context);
                    },

                    child:new Container(alignment: Alignment.center,height: 35,padding: EdgeInsets.only(left: 10,right: 10),decoration: new BoxDecoration(color: ColorFile.app_color,borderRadius: new BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5))),child: new Text("COPY",style: Styles().styles_medium(12, ColorFile.white),),),)

                ],
              ),




              new SizedBox(height: 20,),
              Container(child: new Row(children: [],),height: 1,color: ColorFile.lightgray,),
            ],
          ),

          if(rewardCode!=""&&is_purchaesd==true&&is_viewed=="0") new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new SizedBox(height: 20,),
              new Text("CODE",style: Styles().styles_regular(12, ColorFile.hint_color),),
              new SizedBox(height: 5,),
              new Row(
                children: [
                  FDottedLine(
                    color: ColorFile.lightgray,
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    strokeWidth: 2.0,
                    dottedLength: 10.0,
                    space: 2.0,
                    child:new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 15,right: 15),height: 33,child: new Text(AppUtils().arrays(rewardCode.toString())),),
                  ),

                  InkWell(
                    onTap: (){
                      on_view();

                    },

                    child:new Container(alignment: Alignment.center,height: 35,padding: EdgeInsets.only(left: 10,right: 10),decoration: new BoxDecoration(color: ColorFile.app_color,borderRadius: new BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5))),child: new Text("View",style: Styles().styles_medium(12, ColorFile.white),),),)

                ],
              ),




              new SizedBox(height: 20,),
              Container(child: new Row(children: [],),height: 1,color: ColorFile.lightgray,),
            ],
          ),

          if(pin!=""&&is_purchaesd==true&&is_viewed=="1") new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new SizedBox(height: 20,),
              new Text("PIN",style: Styles().styles_regular(12, ColorFile.hint_color),),
              new SizedBox(height: 5,),
              new Row(
                children: [
                  FDottedLine(
                    color: ColorFile.lightgray,
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    strokeWidth: 2.0,
                    dottedLength: 10.0,
                    space: 2.0,
                    child:new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 15,right: 15),height: 33,child: new Text(pin.toString()),),
                  ),

                  InkWell(
                    onTap: (){
                      Clipboard.setData(ClipboardData(text: pin.toString()));
                      AppUtils.toAst("Pin Copied", context);
                    },

                    child:new Container(alignment: Alignment.center,height: 35,padding: EdgeInsets.only(left: 10,right: 10),decoration: new BoxDecoration(color: ColorFile.app_color,borderRadius: new BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5))),child: new Text("COPY",style: Styles().styles_medium(12, ColorFile.white),),),)

                ],
              ),




              new SizedBox(height: 20,),
              Container(child: new Row(children: [],),height: 1,color: ColorFile.lightgray,),
            ],
          ),


          if(banner_multiple.length>0)new Container(
            margin: EdgeInsets.only(top: 20),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return Container(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(10)),
                    ),
                    margin: const EdgeInsets.all(8.0),
                    child:new Stack(
                      alignment: Alignment.topRight,
                      children: [
                        new Container(child: ClipRRect(
                          borderRadius: new BorderRadius.all(Radius.circular(10)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/loading.png',
                            image:banner_multiple[index].toString(),
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            height: 130,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return  new Container(height: 0,);
                            },
                          ),
                        ))

                      ],
                    )

                );

              },
              itemCount:banner_multiple.length, // Can be null
            ),height: 130,),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new SizedBox(height: 30,),
              if(stepsToRedeem.toString().length>0)new Text("How to Redeem",style: Styles().styles_bold(20, Colors.black),),
              if(stepsToRedeem.toString().length>0) new SizedBox(height: 10,),

              if(stepsToRedeem.toString().length>0) new Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(child: Html(data:stepsToRedeem.toString(),
                        onLinkTap: (url, _, __, ___) async {
                        AppUtils.toAst("message", context);
                        },

                        style: {
                          "link": Style(
                              fontFamily: "regular",
                              fontSize: FontSize(14.0),
                              color: ColorFile.app_color

                          ), "href": Style(
                              fontFamily: "regular",
                              fontSize: FontSize(14.0),
                              color: ColorFile.app_color

                          ),
                          "body": Style(
                              fontFamily: "regular",
                              fontSize: FontSize(14.0),
                              color: ColorFile.black

                          ),
                          'html': Style(textAlign: TextAlign.justify,color: ColorFile.black),
                          "table": Style(
                              color: ColorFile.black,
                              fontFamily: "Medium"
                          ),

                          "tr": Style(
                            fontFamily: "regular",
                            color: ColorFile.black,
                          ),
                          "th": Style(
                            fontFamily: "regular",
                            color: ColorFile.black,
                          ),
                          "td": Style(
                            fontFamily: "regular",
                            color: ColorFile.black,

                          ),
                          "h1": Style(
                              fontFamily: "medium"
                          ),
                        },





                      )),









                    ],
                  )),

              new SizedBox(height: 10,),
              if(rewardDescription.toString().length>0)new Text("Description",style: Styles().styles_bold(20, Colors.black),),
              if(rewardDescription.toString().length>0) new SizedBox(height: 10,),

              if(rewardDescription.toString().length>0)new Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(child: Html(data:rewardDescription.toString(),
                        style: {
                          "body": Style(
                              fontFamily: "regular",
                              fontSize: FontSize(14.0),
                              color: ColorFile.black

                          ),
                          'html': Style(textAlign: TextAlign.justify,color: ColorFile.black),
                          "table": Style(
                              color: ColorFile.black,
                              fontFamily: "Medium"
                          ),
                          "tr": Style(
                            fontFamily: "regular",
                            color: ColorFile.black,
                          ),
                          "th": Style(
                            fontFamily: "regular",
                            color: ColorFile.black,
                          ),
                          "td": Style(
                            fontFamily: "regular",
                            color: ColorFile.black,

                          ),
                          "h1": Style(
                              fontFamily: "medium"
                          ),
                        },





                      )),
                    ],
                  )),




            ],
          )
        ],
      );
  }



}