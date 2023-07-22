

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/BrokerPropertiesModel.dart';
import 'package:peprop_consumer_app/Models/CPModel.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import 'MyVerticalText.dart';

class My_Enquiry_Request extends StatelessWidget{

  late CPModel model;
  My_Enquiry_Request(CPModel model){
    this.model=model;

  }
  @override
  Widget build(BuildContext context) {
    String errorLatter = model.fullname.toString();

    String dateCredit = model.createdOn.toString();
    String neeDate = AppUtils.convert_date(dateCredit);
    String neeTime = AppUtils.convert_date_time(dateCredit);


    return new Container(
      margin: EdgeInsets.only(top: 20),
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
            new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 5,right: 5,top: 20,bottom: 20),child: new MyVerticalText(model.broker_Profile_model!.user_level=="3"?"Broker":"Developer"), decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),),


            Expanded(child: new Container(
              decoration: new BoxDecoration(borderRadius:new BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.white),
              padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
              child: new Row(
                children: [
                  Expanded(child: new Container(child: new Column(
                    children: [
                      new Container(child: new Row(children: [
                        Expanded(child: new Container(child: new Row(
                          children: [
                            Image.asset("assets/calendar.png",width: 12,height: 12,fit: BoxFit.cover,),
                            new SizedBox(width: 10,),
                            new Text(neeDate,style: new TextStyle(fontFamily: "regular", fontSize: 13, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
                            new SizedBox(width: 20,),
                          ],
                        ),)),

                        Image.asset("assets/clock.png",width: 12,height: 12,fit: BoxFit.cover,),
                        new SizedBox(width: 10,),
                        new Text(neeTime,style: new TextStyle(fontFamily: "regular", fontSize: 13, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),


                      ],),),
                      new SizedBox(height: 10,),
                      new Container(
                        child: new Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.png',
                                  image:model.broker_Profile_model!.user_level.toString()=="3"?(API.chnnale_partner_profile+model.broker_Profile_model!.profile_image.toString()):(API.builder_profile+model.broker_Profile_model!.profile_image.toString()),
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
                                new Container(child:new Text(model.broker_Profile_model!.full_name.toString(),style:Styles().styles_bold(15, ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),),
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
                            Expanded(flex: 6,child: new Container(child: new Text((model.broker_Profile_model!.user_level=="3"?"Broker":"Developer"),style:Styles().styles_medium(14, ColorFile.black),maxLines: 5,overflow: TextOverflow.ellipsis,),)),

                          ],),),

                      new Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 4,child: new Container(child: new Text("Company Name",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                            Expanded(flex: 6,child: new Container(child: new Text(model.broker_Profile_model!.comp_name.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 5,overflow: TextOverflow.ellipsis,),)),

                          ],),),
                      new Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 4,child: new Container(child: new Text("Mobile Number",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                            Expanded(flex: 6,child: new Container(child: new Text("+91-"+model.broker_Profile_model!.mobile.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 5,overflow: TextOverflow.ellipsis,),)),

                          ],),),


                      new Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 4,child: new Container(child: new Text("Project",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                            Expanded(flex: 6,child: new Container(child: new Text(model.PropertyTitle.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 5,overflow: TextOverflow.ellipsis,),)),

                          ],),),
                    ],
                  ),)),

                  new Container(height: 20,width: 20,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.greens),)
                 ,new SizedBox(width: 10,),


                ],
              )

            )),


          ],
        ),
      ),);



  }


}