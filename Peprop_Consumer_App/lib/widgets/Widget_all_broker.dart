


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/All_Brokers_Model.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../wish_list/Styles.dart';
import 'MyVerticalText.dart';

class Widget_all_broker extends StatelessWidget{
  late All_Brokers_Model brokerModel;
  Widget_all_broker(All_Brokers_Model brokerModel){
    this.brokerModel=brokerModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20,left: 10,right: 10),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.white),
      child: Container(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10),
            color: ColorFile.app_color
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),child: new MyVerticalText(brokerModel.broker_Profile_model!.user_level.toString()=="3"?"Broker":brokerModel.broker_Profile_model!.user_level.toString()=="8"?"Developer":""), decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),),
            Expanded(child: new Container(
              decoration: new BoxDecoration(borderRadius:new BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.white),
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              child:
              new Column(
                children: [
                  new Container(
                    child: new Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/loading.png',
                              image:brokerModel.broker_Profile_model!.user_level.toString()=="3"?(API.chnnale_partner_profile+brokerModel.broker_Profile_model!.profile_image.toString()):(API.builder_profile+brokerModel.broker_Profile_model!.profile_image.toString()),
                              width:70,
                              height: 70,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset("assets/placeholder.png",
                                    width: 70,
                                    fit: BoxFit.cover,
                                    height: 70);//do something
                              },
                            ),
                          ),
                        ),
                        new SizedBox(width: 10,),
                        Expanded(child: new Container(child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(child:new Text(brokerModel.broker_Profile_model!.full_name.toString(),style:Styles().styles_bold(15, ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                            new SizedBox(height: 5,),

                          ],
                        ),)),






                      ],
                    ),
                  ),

                  new Container(
                    margin: EdgeInsets.only(top: 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4,child: new Container(child: new Text("Company Type",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text((brokerModel.broker_Profile_model!.user_level=="3"?"Broker":"Developer"),style:Styles().styles_medium(14, ColorFile.black),maxLines: 5,overflow: TextOverflow.ellipsis,),)),

                      ],),),

                  new Container(
                    margin: EdgeInsets.only(top: 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4,child: new Container(child: new Text("Company Name",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text(brokerModel.broker_Profile_model!.comp_name.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 5,overflow: TextOverflow.ellipsis,),)),

                      ],),),



                  new Container(
                    margin: EdgeInsets.only(top: 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4,child: new Container(child: new Text("Mobile Number",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text("+91-"+brokerModel.broker_Profile_model!.mobile.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 5,overflow: TextOverflow.ellipsis,),)),

                      ],),),




                  new Container(
                    margin: EdgeInsets.only(top: 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4,child: new Container(child: new Text("RERA Number",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text(brokerModel.broker_Profile_model!.rera_number.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 5,overflow: TextOverflow.ellipsis,),)),

                      ],),),


                  new Container(margin:EdgeInsets.only(top: 10),child: new Row(
                    children: [
                      Expanded(child: new Container(
                        child: new Column(
                          children: [
                            new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 5,right: 5),height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(50),color: ColorFile.bgs),child: new Text("INVENTORY SHARED\n"+brokerModel.incentory_count.toString(),style: Styles().styles_bold(10, ColorFile.black,),textAlign: TextAlign.center,maxLines: 2,),),
                            new SizedBox(height: 5,),

                          ],
                        ),)),
                      new SizedBox(width: 10,),


                      Expanded(child: new Container(
                        child: new Column(
                          children: [
                            new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 5,right: 5),height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(50),color: ColorFile.yellowdark),child: new Text("SITE VISIT\n"+brokerModel.broker_tasks_count.toString(),style: Styles().styles_bold(10, ColorFile.black),textAlign: TextAlign.center,),),
                            new SizedBox(height: 5,),

                          ],
                        ),)),



                    ],
                  ),)




                  // new Container(
                  //   child: new Row(
                  //     children: [
                  //       Expanded(child: new Container(
                  //         child: new Column(
                  //           children: [
                  //             if(brokerModel.broker_Profile_model!=null)new Container(child: new Row(children: [
                  //               Expanded(child: new Container(child: new Row(
                  //                 children: [
                  //                   Expanded(child:
                  //                   new Container(child:new Text(("" + brokerModel.broker_Profile_model!.full_name.toString()),style: new TextStyle(fontFamily: "semi", fontSize: 16, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                  //
                  //                 ],
                  //               ),)),
                  //
                  //
                  //
                  //             ],),),
                  //             new SizedBox(height: 10,),
                  //
                  //             if(brokerModel.broker_Profile_model!=null)new Container(child: new Row(children: [
                  //               Expanded(child: new Container(child: new Row(
                  //                 children: [
                  //                   Expanded(child: new Container(child:new Text(("Company Type : "+(brokerModel.broker_Profile_model!.user_level=="3"?"Broker":"Developer")),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                  //
                  //                 ],
                  //               ),)),
                  //
                  //
                  //
                  //             ],),),
                  //             new SizedBox(height: 10,),
                  //             if(brokerModel.broker_Profile_model!=null)new Container(child: new Row(children: [
                  //               Expanded(child: new Container(child: new Row(
                  //                 children: [
                  //                   Expanded(child: new Container(child:new Text(("Company Name : " + brokerModel.broker_Profile_model!.comp_name.toString()),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),
                  //
                  //                 ],
                  //               ),)),
                  //
                  //
                  //
                  //             ],),),
                  //             new SizedBox(height: 10,),
                  //             if(brokerModel.broker_Profile_model!=null)new Container(child: new Row(children: [
                  //               Expanded(child: new Container(child: new Row(
                  //                 children: [
                  //                   Expanded(child: new Container(child:new Text(("M - +91-" + brokerModel.broker_Profile_model!.mobile.toString()),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                  //
                  //                 ],
                  //               ),)),
                  //
                  //
                  //
                  //             ],),),
                  //             new SizedBox(height: 10,),
                  //
                  //            if(brokerModel.propertyDetail!.length>0) new Column(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 new Container(child: new Row(children: [
                  //                   Expanded(child: new Container(child: new Row(
                  //                     children: [
                  //                       Expanded(child: new Container(child:new Text("Project : "+(brokerModel.propertyDetail![0].propertyname.toString())+(brokerModel.propertyDetail!.length>1?"...":""),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                  //
                  //                     ],
                  //                   ),)),
                  //
                  //
                  //
                  //                 ],),),
                  //                 new SizedBox(height: 10,),
                  //               ],
                  //             ),
                  //             if(brokerModel.propertyDetail!.length>0) new Column(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 new Container(child: new Row(children: [
                  //                   Expanded(child: new Container(child: new Row(
                  //                     children: [
                  //                       Expanded(child: new Container(child:new Text("By : "+brokerModel.propertyDetail![0].builder_name.toString()+(brokerModel.propertyDetail!.length>1?"...":""),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                  //
                  //                     ],
                  //                   ),)),
                  //
                  //
                  //
                  //                 ],),),
                  //                 new SizedBox(height: 10,),
                  //               ],
                  //             ),
                  //
                  //
                  //
                  //             new Row(
                  //               children: [
                  //                 new Text("Status : "),
                  //                 new Text(brokerModel.brokerage_rm_accept_reject.toString()=="1"?"Accepted":"Rejected",style: Styles().styles_medium(12, brokerModel.brokerage_rm_accept_reject.toString()=="1"?ColorFile.greens:ColorFile.red_900),)
                  //               ],
                  //             ),
                  //             new SizedBox(height: 10,),
                  //             if(brokerModel.propertyDetail!.length>0) new Column(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 new Container(child: new Row(children: [
                  //                   Expanded(child: new Container(child: new Row(
                  //                     children: [
                  //                       new Container(alignment: Alignment.center,height: 50,width: 50,child: new Text(sum.toString(),style: Styles().styles_bold(15, ColorFile.white),),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.greens),),
                  //                       new SizedBox(width: 10,),
                  //                       Expanded(child: new Container(alignment: Alignment.centerLeft,child: new Text((" Inventory Shared"+" of "+brokerModel.propertyDetail![0].propertyname.toString())+(brokerModel.propertyDetail!.length>1?"...":""),style: Styles().under_line_styles_bold(15, ColorFile.greens,),textAlign: TextAlign.start,maxLines: 3,),)),
                  //
                  //
                  //
                  //                     ],
                  //                   ),)),
                  //
                  //
                  //
                  //                 ],),),
                  //                 new SizedBox(height: 10,),
                  //               ],
                  //             ),
                  //
                  //
                  //
                  //           ],
                  //         ),
                  //       )),
                  //
                  //
                  //       if(brokerModel.propertyDetail!.length==1)
                  //         new Container(
                  //           alignment: Alignment.center,
                  //           height: 70,
                  //           width: 70,
                  //           padding:EdgeInsets.only(right: 5,top: 5),
                  //           decoration:brokerModel.propertyDetail!.length>0? new BoxDecoration(
                  //             image: DecorationImage(
                  //               image: AssetImage(brokerModel.propertyDetail![0].PropertyFor=="1"?"assets/residentail_stamp.png":"assets/commercial_stamp.png"),
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ):new BoxDecoration(),
                  //           child:Text(
                  //             brokerModel.propertyDetail!.length.toString(),
                  //             style:Styles().styles_bold(15, ColorFile.black),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       if(brokerModel.propertyDetail!.length>1)new Container(
                  //           alignment: Alignment.center,
                  //           height: 100,
                  //           width: 100,
                  //           padding:EdgeInsets.only(right: 5,top: 5),
                  //           decoration: new BoxDecoration(
                  //             image: DecorationImage(
                  //               image: AssetImage("assets/projects.png",),
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //           child:Text(
                  //             brokerModel.propertyDetail!.length.toString(),
                  //             style:Styles().styles_bold(15, ColorFile.black),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //
                  //
                  //
                  //
                  //
                  //
                  //     ],
                  //   ),
                  // ),







                ],
              ),
            )),

          ],
        ),
      ),);
    // return new Container(
    //   margin: EdgeInsets.only(top: 20,left: 10,right: 10),
    //   decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.white,border: new Border.all(width: 1,color: ColorFile.hint_color)),
    //   child: Column(
    //     children: [
    //       new Container(padding: EdgeInsets.only(right: 10),decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),color:ColorFile.app_color),height: 40
    //         ,child:new Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             new Text((broker.userlevel.toString()=="RM"?"Developer":"Channel Partner"),style: Styles().styles_medium(12, ColorFile.white),)
    //
    //
    //           ],
    //         ),
    //
    //       ),
    //       new Container(child: new Row(
    //         children: [
    //           new SizedBox(width: 10,),
    //           Expanded(child: new Container(
    //             padding: EdgeInsets.only(right: 10,bottom: 10,top: 10),
    //             child: Column(
    //               children: [
    //
    //                 new Container(
    //                   child: new Row(
    //                     children: [
    //                       CircleAvatar(
    //                         radius: 25,
    //                         child: ClipOval(
    //                           child: FadeInImage.assetNetwork(
    //                             placeholder: 'assets/loading.png',
    //                             image:broker.broker_Profile_model!.user_level.toString()=="3"?(API.chnnale_partner_profile+broker.broker_Profile_model!.profile_image.toString()):(API.builder_profile+broker.broker_Profile_model!.profile_image.toString()),
    //                             width:70,
    //                             height: 70,
    //                             imageErrorBuilder: (context, error, stackTrace) {
    //                               return Image.asset("assets/placeholder.png",
    //                                   width: 70,
    //                                   fit: BoxFit.cover,
    //                                   height: 70);//do something
    //                             },
    //                           ),
    //                         ),
    //                       ),
    //                       new SizedBox(width: 10,),
    //                       Expanded(child: new Container(child: new Column(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           new Container(child:new Text(broker.broker_Profile_model!.full_name.toString(),style:Styles().styles_bold(15, ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),),
    //                           new SizedBox(height: 5,),
    //
    //                         ],
    //                       ),)),
    //
    //
    //
    //
    //
    //
    //                     ],
    //                   ),
    //                 ),
    //
    //                 new Container(margin: EdgeInsets.only(top: 5),child: new Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.app_color),child:Icon(Icons.settings_cell_rounded,size: 15,color: ColorFile.white,),padding: EdgeInsets.all(5),),
    //                     new SizedBox(width: 10,),
    //
    //                     Expanded(child: new Container(child: new Text(broker.broker_Profile_model!.comp_name.toString(),style: Styles().styles_medium(14, ColorFile.black),),))
    //                   ],),),
    //
    //                 new Container(margin: EdgeInsets.only(top: 5),child: new Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.app_color),child:Icon(Icons.settings_cell_rounded,size: 15,color: ColorFile.white,),padding: EdgeInsets.all(5),),
    //                     new SizedBox(width: 10,),
    //
    //                     Expanded(child: new Container(child: new Text("+91-"+broker.broker_Profile_model!.mobile.toString(),style: Styles().styles_medium(14, ColorFile.black),),))
    //                   ],),),
    //                 new Container(margin: EdgeInsets.only(top: 5),child: new Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.app_color),child:Icon(Icons.email,size: 15,color: ColorFile.white,),padding: EdgeInsets.all(5),),
    //                     new SizedBox(width: 10,),
    //
    //                     Expanded(child: new Container(child: new Text(broker.broker_Profile_model!.email.toString(),style: Styles().styles_medium(14, ColorFile.black),),))
    //
    //                   ],),),
    //                 new Container(margin: EdgeInsets.only(top: 5),child: new Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.app_color),child:Icon(Icons.email,size: 15,color: ColorFile.white,),padding: EdgeInsets.all(5),),
    //                     new SizedBox(width: 10,),
    //
    //                     Expanded(child: new Container(child: new Text(broker.broker_Profile_model!.rera_number.toString(),style: Styles().styles_medium(14, ColorFile.black),),))
    //
    //                   ],),),
    //
    //
    //
    //               ],
    //             ),
    //           )),
    //           new SizedBox(width: 10,),
    //           new Container(
    //             alignment: Alignment.center,
    //             height: 70,
    //             width: 70,
    //             padding:EdgeInsets.only(right: 5,top: 5,left: 5),
    //             decoration: new BoxDecoration(
    //               image: DecorationImage(
    //                 image: AssetImage("assets/inv.png"),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //             child:Text(
    //               broker.incentory_count.toString(),
    //               style:Styles().styles_bold(15, ColorFile.white),
    //               textAlign: TextAlign.center,
    //             ),
    //           ),
    //           new SizedBox(width: 10,),
    //
    //         ],
    //       ),)
    //
    //
    //     ],
    //   ),
    // );

  }

}