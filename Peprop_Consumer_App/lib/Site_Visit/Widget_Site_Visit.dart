

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Filters/Bottom_sheet_For_Area.dart';
import 'package:peprop_consumer_app/Site_Visit/Reschedule_Site_Visit.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../widgets/MyVerticalText.dart';
import 'My_Site_Visit_Model.dart';

class Widget_Site_Visit extends StatelessWidget{

  My_Site_Visit_Model? sitevisitModel;
  Function () accept;
  Function () reject;
  Function () reschedule;
  String name="";
  String user_id="";

  Widget_Site_Visit(My_Site_Visit_Model sitevisitModel, String name, String user_id,{required this.accept,required this.reject,required this.reschedule}){
    this.sitevisitModel=sitevisitModel;
    this.name=name;
    this.user_id=user_id;



  }

  @override
  Widget build(BuildContext context) {
    print(sitevisitModel!.cus_status);
    print(sitevisitModel!.status);


    return new Container(
      margin: EdgeInsets.only(top: 20,left: 5,right: 5),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.white,border: new Border.all(width: 1,color: ColorFile.hint_color)),
      child: Column(
        children: [
          new Container(padding: EdgeInsets.only(right: 10),decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),color:sitevisitModel!.cus_status=="1"?ColorFile.greens:sitevisitModel!.cus_status=="2"?ColorFile.red_900:sitevisitModel!.status=="1"?ColorFile.app_color:sitevisitModel!.status=="1"?ColorFile.greens:ColorFile.app_color),height: 30
          ,child:new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                        if(sitevisitModel!.cus_status!="0")new Text(sitevisitModel!.cus_status.toString()=="1"?"Accepted":"Canceled",style: Styles().styles_medium(12, ColorFile.white),)

                        else if(sitevisitModel!.status=="1"||sitevisitModel!.status=="2")new Text(sitevisitModel!.status.toString()=="1"?"Upcoming":"Completed",style: Styles().styles_medium(12, ColorFile.white),),

              ],
            ),

          ),
          new Container(child: new Row(
            children: [
              new Container(child: ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
                child:
                FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.png',
                  image:API.property_image+sitevisitModel!.FeaturedImage.toString(),
                  width: 100,
                  fit: BoxFit.cover,
                  height: 140,

                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/placeholder.png",
                      width: 100,
                      fit: BoxFit.cover,
                      height: 180,);//do something
                  },
                ),
              ),margin: EdgeInsets.only(top: 10,bottom: 10,left: 10),),
              new SizedBox(width: 10,),
              Expanded(child: new Container(
                padding: EdgeInsets.only(right: 10,bottom: 10,top: 10),
                child: Column(
                  children: [
                    new Container(margin: EdgeInsets.only(top: 5),child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.app_color),child:Image.asset("assets/left_properties.png",color: ColorFile.white,width: 15,height: 15,),padding: EdgeInsets.all(5),),
                      new SizedBox(width: 10,),
                      Expanded(child: new Container(child: new Text(sitevisitModel!.propertyName.toString(),style: Styles().styles_medium(14, ColorFile.black),),))
                    ],),),

                    new Container(margin: EdgeInsets.only(top: 5),child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.app_color),child:Icon(Icons.location_on_rounded,size: 15,color: ColorFile.white,),padding: EdgeInsets.all(5),),
                      new SizedBox(width: 10,),

                      Expanded(child: new Container(child: new Text(sitevisitModel!.Address.toString(),style: Styles().styles_medium(14, ColorFile.black),),))
                    ],),),
                    new Container(margin: EdgeInsets.only(top: 5),child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.app_color),child:Icon(Icons.call,size: 15,color: ColorFile.white,),padding: EdgeInsets.all(5),),
                      new SizedBox(width: 10,),

                      new Text("+91-"+sitevisitModel!.rm_mobile.toString(),style: Styles().styles_medium(14, ColorFile.black),)
                    ],),),

                      new Container(margin: EdgeInsets.only(top: 5),child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                        new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.app_color),child:Icon(Icons.supervised_user_circle,size: 15,color: ColorFile.white,),padding: EdgeInsets.all(5),),
                        new SizedBox(width: 10,),

                        Expanded(child: new Container(child: new Text("Scheduled With "+sitevisitModel!.rmName.toString(),style: Styles().styles_medium(14, ColorFile.black),),))


                    ],),),


                    new Container(margin: EdgeInsets.only(top: 10),child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.app_color),child:Icon(Icons.watch_later_outlined,size: 15,color: ColorFile.white,),padding: EdgeInsets.all(5),),
                      new SizedBox(width: 10,),
                      Expanded(child: new Container(child: new Text(AppUtils().convert(sitevisitModel!.fromSchedule.toString())+" "+ AppUtils.visit_Time(sitevisitModel!.from_time.toString())+" - "+AppUtils.visit_Time(sitevisitModel!.to_time.toString()),style: Styles().styles_medium(14, ColorFile.black),),))


                    ],),),


                  ],
                ),
              ))
            ],
          ),),
          if(user_id!=sitevisitModel!.created_by)
          new Container(
                          padding: EdgeInsets.only(left: 5,right: 5,bottom: 10),

                          child: new Column(
                          children: [
                            if(sitevisitModel!.status.toString()=="2")new Container(child: new Row(children: [new Expanded(child:new Container(
                              decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.lightgray,),
                              alignment: Alignment.center,
                              height: 40,
                              child: new Text("COMPLETED",style: Styles().styles_medium(10,ColorFile.greens),),
                            ))],),)

                            else new Container(child: new Row(
                              children: [

                                if(sitevisitModel!.cus_status.toString()=="0"&&user_id!=sitevisitModel!.owner_id) new Expanded(child:InkWell(child: new Container(
                                    decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.yellowdark,),
                                    alignment: Alignment.center,
                                    height: 40,
                                    child: new Text("ACCEPT",style: Styles().styles_medium(10, ColorFile.greens),)),onTap: (){
                                  accept();
                                },)),


                                if(sitevisitModel!.cus_status.toString()=="0") Container(width: 5,height: 40,color: ColorFile.white,),
                                if(sitevisitModel!.cus_status.toString()=="0")new Expanded(child:
                                InkWell(child: new Container(
                                  decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.yellowdark,),
                                  alignment: Alignment.center,
                                  height: 40,
                                  child: new Text("CANCEL",style: Styles().styles_medium(10, ColorFile.red_900),),
                                ),onTap: (){
                                  reject();
                                },)),

                                if(sitevisitModel!.cus_status.toString()!="0")new Expanded(child:new Container(
                                  decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.lightgray,),
                                  alignment: Alignment.center,
                                  height: 40,
                                  child: new Text(sitevisitModel!.cus_status.toString()=="1"?"ACCEPTED":"CANCELED",style: Styles().styles_medium(10, sitevisitModel!.cus_status.toString()=="1"?ColorFile.greens:ColorFile.red_900),),
                                )),

                                Container(width: 5,height: 40,color: ColorFile.white,),

                                if(sitevisitModel!.cus_status.toString()=="0")
                                  new Expanded(child:
                                  InkWell(child: new Container(
                                  decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.yellowdark,),

                                  alignment: Alignment.center,
                                  height: 40,
                                  child: new Text("RESCHEDULE",style: Styles().styles_medium(10, ColorFile.black),),
                                ),onTap: () async {
                                  reschedule();




                                },)

                                ),

                              ],
                            ),)





                          ],
                        ),)else new Container(
                          child: new Row(
                            children: [
                              new Expanded(child:
                              InkWell(child: new Container(
                                decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.yellowdark,),

                                alignment: Alignment.center,
                                height: 40,
                                child: new Text("RESCHEDULE",style: Styles().styles_medium(10, ColorFile.black),),
                              ),onTap: () async {
                                reschedule();




                              },)

                              ),
                            ],
                          ),


                        )

        ],
      ),
    );


    // return new Container(
    //   margin: EdgeInsets.only(top: 20,left: 10,right: 10),
    //   decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.white),
    //   child: Container(
    //     decoration:new BoxDecoration(
    //         borderRadius: new BorderRadius.circular(10),
    //         color:sitevisitModel!.cus_status=="1"?ColorFile.greens:sitevisitModel!.cus_status=="2"?ColorFile.red_900:sitevisitModel!.status=="1"?ColorFile.app_color:sitevisitModel!.status=="1"?ColorFile.greens:ColorFile.app_color
    //     ),
    //     child: new Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //
    //

    //
    //         Expanded(child: new Container(
    //           decoration: new BoxDecoration(borderRadius:new BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.white),
    //
    //           child:
    //           new Column(
    //             children: [
    //               new Container(
    //                 padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
    //                 child: new Column(
    //                   children: [
    //                     new Container(child: new Row(children: [
    //                       Expanded(child: new Container(child: new Row(
    //                         children: [
    //                           Expanded(child: new Container(child:new Text("" + "Site Visit : "+sitevisitModel!.leadName.toString(),style: new TextStyle(fontFamily: "semi", fontSize: 16, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
    //
    //                         ],
    //                       ),)),
    //
    //
    //
    //                     ],),),
    //
    //                     new SizedBox(height: 10,),
    //                     new Container(child: new Row(children: [
    //                       Expanded(child: new Container(child: new Row(
    //                         children: [
    //                           Expanded(child: new Container(child:new Text("" + sitevisitModel!.propertyName.toString(),style: new TextStyle(fontFamily: "medium", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),
    //
    //                         ],
    //                       ),)),
    //
    //
    //
    //                     ],),),
    //                     new SizedBox(height: 10,),
    //                     new Container(child: new Row(children: [
    //                       Expanded(child: new Container(child: new Row(
    //                         children: [
    //                           Expanded(child: new Container(child:new Text("Visit Time : "+AppUtils().convert(sitevisitModel!.fromSchedule.toString())+" "+ AppUtils.visit_Time(sitevisitModel!.from_time.toString())+" - "+AppUtils.visit_Time(sitevisitModel!.to_time.toString()),style: new TextStyle(fontFamily: "regular", fontSize: 12, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),
    //
    //                         ],
    //                       ),)),
    //
    //
    //
    //                     ],),),
    //                     new SizedBox(height: 10,),
    //                     new Container(child: new Row(children: [
    //                       Expanded(child: new
    //
    //                       InkWell(child: Container(child: new Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Expanded(child: new Container(child:new Text("Address : "+sitevisitModel!.Address.toString(),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),
    //                           new Container(child: Icon(Icons.location_on_rounded,color: ColorFile.white,size: 20,),decoration: new BoxDecoration(borderRadius:new BorderRadius.circular(100),color: ColorFile.yellowdark),padding: EdgeInsets.all(2),)
    //
    //                         ],
    //                       ),),onTap: (){
    //                         AppUtils().launchMap(sitevisitModel!.Address.toString());
    //
    //                       },)),
    //
    //
    //
    //                     ],),),
    //
    //
    //                     if(sitevisitModel!.rmName.toString()!="null") new SizedBox(height: 10,),
    //                       name!=""?new Container(child: new Row(children: [
    //                         Expanded(child:
    //                         InkWell(child: new Container(child: new Row(
    //                           children: [
    //                             Expanded(child: new Container(child:new Text("Scheduled With : "+name.toString(),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
    //                             if(sitevisitModel!.rm_mobile!="") new Container(child: Icon(Icons.call,color: ColorFile.white,size: 20,),decoration: new BoxDecoration(borderRadius:new BorderRadius.circular(100),color: ColorFile.greens),padding: EdgeInsets.all(2),)
    //                           ],
    //                         ),),onTap: (){
    //                           if(sitevisitModel!.rm_mobile!=""){
    //                             AppUtils().open_dialer(sitevisitModel!.rm_mobile.toString());
    //                           }
    //                         },)),
    //
    //                     ],),):
    //                       new Container(child: new Row(children: [
    //                       Expanded(child:
    //                       InkWell(child: new Container(child: new Row(
    //                         children: [
    //                           Expanded(child: new Container(child:new Text("Scheduled With : "+sitevisitModel!.rmName.toString(),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
    //                           if(sitevisitModel!.rm_mobile!="")new Container(child: Icon(Icons.call,color: ColorFile.white,size: 20,),decoration: new BoxDecoration(borderRadius:new BorderRadius.circular(100),color: ColorFile.greens),padding: EdgeInsets.all(2),)
    //                         ],
    //                       ),),onTap: (){
    //                         if(sitevisitModel!.rm_mobile!=""){
    //                           AppUtils().open_dialer(sitevisitModel!.rm_mobile.toString());
    //                         }
    //
    //                         },)),
    //
    //                     ],),),
    //
    //
    //                   ],
    //                 ),
    //               ),
    //

    //
    //
    //
    //
    //                   // new Container(
    //                   // margin: EdgeInsets.only(bottom: 10),
    //                   // child:  new Row(
    //                   //   crossAxisAlignment: CrossAxisAlignment.end,
    //                   //   mainAxisAlignment: MainAxisAlignment.end,
    //                   //   children: [
    //                   //
    //                   //
    //                   //
    //                   //     if(sitevisitModel!.status.toString()!="0")new Expanded(child:InkWell(child: new Container(
    //                   //       decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.lightgray,),
    //                   //       alignment: Alignment.center,
    //                   //       height: 40,
    //                   //       child: new Text(sitevisitModel!.status.toString()=="1"?"ACCEPTED":"REJECTED",style: Styles().styles_medium(10, sitevisitModel!.status.toString()=="1"?ColorFile.greens:ColorFile.red_900),),
    //                   //     ),onTap: (){
    //                   //
    //                   //     },)),
    //                   //
    //                   //     Container(width: 5,height: 40,color: ColorFile.white,),
    //                   //     if(sitevisitModel!.status.toString()!="2")new Expanded(child:
    //                   //     InkWell(child: new Container(
    //                   //       decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.yellowdark,),
    //                   //
    //                   //       alignment: Alignment.center,
    //                   //       height: 40,
    //                   //       child: new Text("RESCHEDULE",style: Styles().styles_medium(10, ColorFile.black),),
    //                   //     ),onTap: () async {
    //                   //       reschedule();
    //                   //
    //                   //
    //                   //
    //                   //
    //                   //     },)
    //                   //
    //                   //     ),
    //                   //
    //                   //   ],
    //                   // ))
    //
    //
    //
    //
    //
    //               // new Container(
    //               //   margin: EdgeInsets.only(bottom: 10),
    //               //
    //               //   child:  new Row(
    //               //   crossAxisAlignment: CrossAxisAlignment.end,
    //               //   mainAxisAlignment: MainAxisAlignment.end,
    //               //   children: [
    //               //     Container(width: 5,height: 40,color: ColorFile.white,),
    //               //     if(sitevisitModel!.status.toString()!="2") new Expanded(child:
    //               //       InkWell(child: new Container(
    //               //       decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.yellowdark,),
    //               //       alignment: Alignment.center,
    //               //       height: 40,
    //               //       child: new Text("ACCEPT",style: Styles().styles_medium(10, ColorFile.greens),)),onTap: (){
    //               //       accept();
    //               //     },)),
    //               //     if(sitevisitModel!.status.toString()!="2") Container(width: 5,height: 40,color: ColorFile.white,),
    //               //     if(sitevisitModel!.status.toString()!="2")new Expanded(child:
    //               //     InkWell(child: new Container(
    //               //       decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.yellowdark,),
    //               //       alignment: Alignment.center,
    //               //       height: 40,
    //               //       child: new Text("REJECT",style: Styles().styles_medium(10, ColorFile.red_900),),
    //               //     ),onTap: (){
    //               //       reject();
    //               //     },)),
    //               //
    //               //
    //               //     if(sitevisitModel!.status.toString()!="0")new Expanded(child:
    //               //     InkWell(child: new Container(
    //               //       decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.lightgray,),
    //               //       alignment: Alignment.center,
    //               //       height: 40,
    //               //       child: new Text(sitevisitModel!.status.toString()=="1"?"ACCEPTED":"REJECTED",style: Styles().styles_medium(10, sitevisitModel!.status.toString()=="1"?ColorFile.greens:ColorFile.red_900),),
    //               //     ),onTap: (){
    //               //
    //               //     },)),
    //               //
    //               //     Container(width: 5,height: 40,color: ColorFile.white,),
    //               //     if(sitevisitModel!.status.toString()!="2")new Expanded(child:
    //               //     InkWell(child: new Container(
    //               //       decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)),color: ColorFile.yellowdark,),
    //               //
    //               //       alignment: Alignment.center,
    //               //       height: 40,
    //               //       child: new Text("RESCHEDULE",style: Styles().styles_medium(10, ColorFile.black),),
    //               //     ),onTap: () async {
    //               //        reschedule();
    //               //
    //               //
    //               //
    //               //
    //               //     },)
    //               //
    //               //     ),
    //               //
    //               //   ],
    //               // ))
    //
    //             ],
    //           ),
    //         ))
    //       ],
    //     ),
    //   ),);
  }

}

