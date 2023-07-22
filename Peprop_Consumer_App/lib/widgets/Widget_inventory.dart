

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Enquiry/Lead_Detail_Tabs/Inv_Cost_Model.dart';
import 'package:peprop_consumer_app/Models/Broker_profile_Model.dart';

import '../Color/ColorFile.dart';
import '../Models/RM_Inventory_Model.dart';
import '../Requirements/Requirements_Descriptions.dart';
import '../wish_list/Styles.dart';

class Widget_inventory  extends StatelessWidget{
 late RM_Inventory_Model list;
 Broker_Profile_Model? broker_profile_model;
  Widget_inventory(RM_Inventory_Model list, Broker_Profile_Model? broker_profile_model){
    this.list=list;
    this.broker_profile_model=broker_profile_model;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new InkWell(child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(padding: EdgeInsets.all(10),child: new Column(
          children: [
            new Container(
              child: new Row(
                children: [


                   new Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      padding:EdgeInsets.only(right: 5,top: 5),
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(list.PropertyFor.toString()=="1"?"assets/residentail_stamp.png":"assets/commercial_stamp.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child:Text(
                       list.inventory_count.toString(),
                        style:Styles().styles_bold(15, ColorFile.black),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  new SizedBox(width: 10,),
                   Expanded(child: new Container(child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(child:new Text("" +list.PropertyTitle.toString(),style: new TextStyle(fontFamily: "medium", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),),
                      new SizedBox(height: 5,),
                      if(broker_profile_model!=null)new Container(child: new Row(children: [
                        Expanded(child: new Container(child: new Row(
                          children: [
                            Expanded(child: new Container(child:new Text(("Inventory Shared By : " + broker_profile_model!.full_name.toString())+(broker_profile_model!.user_level=="3"?" (Channel Partner)":"(Builder RM)"),style: new TextStyle(fontFamily: "medium", fontSize: 14, color: ColorFile.hint_color),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                          ],
                        ),)),



                      ],),),


                    ],
                  ),)),
                  new Icon(Icons.remove_red_eye)
                ],
              ),
            )
          ],
        ),)),onTap: () async {
      var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Requirements_Descriptions(list.prop_id.toString(),list.lead_id.toString())));

    },);

  }


}