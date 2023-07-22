


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/notification/Notification_List.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import 'App_Filters.dart';
class Dashboard_App_Bar extends StatelessWidget implements PreferredSizeWidget {
  final Function onSelectionChanged;
  final Function notification_click;
  final Function scan;
  final Function choose_city;
  String city="";
  String token="";
  String notificationNewCount="";
  Dashboard_App_Bar(String city, String token, String notificationNewCount, {required this.scan,required this.onSelectionChanged,required this.choose_city,required this.notification_click}){
    this.city=city;
    this.token=token;
    this.notificationNewCount=notificationNewCount;

  }
  @override
  Widget build(BuildContext context) {
        return new AppBar(
            elevation: 0,
            centerTitle: false,
            systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:ColorFile.white,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            toolbarHeight: 90,
            leadingWidth: 55,
            backgroundColor: Colors.white,
            // pinned: false,
            // centerTitle: false,
          leading:InkWell(child: new Row(
              children: [
                new SizedBox(width: 10,),
                Container(
                    width: 45,
                    height: 45,
                    child: Icon(Icons.menu,color: ColorFile.black,)
                ),

              ],
            ),onTap: (){
              onSelectionChanged();
            },),
           title:InkWell(child:   new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [

               new Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Icon(Icons.location_on_rounded,color: ColorFile.hint_color,size: 15,),
                   new Text(city,style: Styles().styles_regular(12, ColorFile.hint_color),),

                 ],
               )

             ],
           ),onTap: (){
             choose_city();
           },),

           
           actions: [
               if(token!=null)
                 new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     InkWell(child:new Stack(
                       alignment: Alignment.topRight,
                       children: [
                         new Icon(Icons.notifications_rounded,color: ColorFile.black,size: 30,),
                         if(notificationNewCount!=""&&notificationNewCount!="null"&&notificationNewCount!="0")new Container(
                           alignment: Alignment.center,
                           margin: EdgeInsets.only(right: 5),
                           child: new Text(notificationNewCount.toString(),style: Styles().styles_regular(10, ColorFile.white),),
                           decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: Colors.red),height: 15,width: 15,)

                       ],),onTap: (){
                       notification_click();

                     },),
                   ],
                 ),


               InkWell(child: new Row(
               children: [
                 new SizedBox(width: 10,),
                 Container(
                     decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.lightgray),
                     width: 45,
                     height: 45,
                     child: Icon(Icons.search,color: ColorFile.black,)
                 ),
                 new SizedBox(width: 20,),
               ],
             ),onTap: (){
               App_Filters().check_location("1", true, city, context,false,"","");



             },),
             //   InkWell(child: new Row(
             //   children: [
             //
             //     Container(
             //       padding: EdgeInsets.all(10),
             //         decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.lightgray),
             //         width: 45,
             //         height: 45,
             //         child: Image.asset("assets/qrcode.png")
             //     ),
             //     new SizedBox(width: 20,),
             //   ],
             // ),onTap: (){
             //    scan();
             //
             //
             //
             // },),
           ],


          );
  }

  @override
  Size get preferredSize => Size.fromHeight(65);
}
