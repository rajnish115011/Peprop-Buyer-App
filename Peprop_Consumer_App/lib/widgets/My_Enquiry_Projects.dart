

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Models/BrokerPropertiesModel.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

class My_Enquiry_Projects extends StatelessWidget{

  late BrokerPropertiesModel enqurylist;
  bool is_broker=false;
  BrokerModelEn? brokerModelList;
  My_Enquiry_Projects(BrokerPropertiesModel enqurylist, bool is_broker, BrokerModelEn? brokerModelList){
    this.enqurylist=enqurylist;
    this.is_broker=is_broker;
    this.brokerModelList=brokerModelList;



  }
  @override
  Widget build(BuildContext context) {
      return new Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.white,border: new Border.all(width: .1,color: ColorFile.app_color)),
      child: new Row(
      children: [
      Container(
                    width: 60,
                    height: 60,
                    child: CachedNetworkImage(
                      imageUrl: API.property_image+'${enqurylist.image.toString()}',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            //colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                          ),
                        ),
                      ))),
      new SizedBox(width: 10,),
      Expanded(child: new Container(child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(enqurylist.propertyname.toString(), style:Styles().styles_bold(14, ColorFile.black)),
          new SizedBox(height: 5,),
          Text("By "+enqurylist.fullname.toString(), style:Styles().styles_regular(14, ColorFile.hint_color)),
          new SizedBox(height: 5,),
          Text(enqurylist.address.toString(), style:Styles().styles_regular(14, ColorFile.hint_color)),


          ],
        ),)),
      new SizedBox(width: 10,),


      if(brokerModelList==null)new Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          padding:EdgeInsets.only(right: 5,top: 5,left: 5),
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: AssetImage(is_broker==true?"assets/enq.png":"assets/inv.png"),
              fit: BoxFit.cover,
            ),
          ),
          child:Text(
            is_broker==true? enqurylist.broker_count.toString():enqurylist.inv_count.toString(),
            style:Styles().styles_bold(15, ColorFile.white),
            textAlign: TextAlign.center,
          ),
        ),
      if(brokerModelList!=null)
      Icon(Icons.remove_red_eye)
      ],
    ),);

  }


}