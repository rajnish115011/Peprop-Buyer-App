

import 'package:flutter/cupertino.dart';
import 'package:peprop_consumer_app/Properties/View_Property_Model.dart';

import '../Color/ColorFile.dart';

class key_feature_widget extends StatelessWidget{
  View_Property_Model? view_property_model;
  key_feature_widget(View_Property_Model? view_property_model){
    this.view_property_model=view_property_model;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        if(view_property_model!.key_feature1!=""||view_property_model!.key_feature2!=""||view_property_model!.key_feature3!=""||view_property_model!.key_feature4!=""||view_property_model!.key_feature5!="")
          new Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(10),
                color: ColorFile.hex_cyan
            ),
            child: new Column(
              children: [
                if (view_property_model!.key_feature1!="")
                  new Container(margin: EdgeInsets.only(top: 0),child:new Row(children: [
                    new Container(height: 5,width: 5,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.black),),
                    new SizedBox(width: 5,),
                    new Text(view_property_model!.key_feature1!,style: new TextStyle(fontFamily: "regular",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.center,),

                  ],)),

                if (view_property_model!.key_feature2!="")
                  new Container(margin: EdgeInsets.only(top: 10),child:new Row(children: [
                    new Container(height: 5,width: 5,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.black),),
                    new SizedBox(width: 5,),
                    new Text(view_property_model!.key_feature2!,style: new TextStyle(fontFamily: "regular",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.center,),

                  ],)),
                if (view_property_model!.key_feature3!="")
                  new Container(margin: EdgeInsets.only(top: 10),child:new Row(children: [
                    new Container(height: 5,width: 5,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.black),),
                    new SizedBox(width: 5,),
                    new Text(view_property_model!.key_feature3!,style: new TextStyle(fontFamily: "regular",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.center,),

                  ],)),

                if (view_property_model!.key_feature4!="")
                  new Container(margin: EdgeInsets.only(top: 10),child:new Row(children: [
                    new Container(height: 5,width: 5,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.black),),
                    new SizedBox(width: 5,),
                    new Text(view_property_model!.key_feature4!,style: new TextStyle(fontFamily: "regular",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.center,),

                  ],)),

                if (view_property_model!.key_feature5!!="")
                  new Container(margin: EdgeInsets.only(top: 10),child:new Row(children: [
                    new Container(height: 5,width: 5,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.black),),
                    new SizedBox(width: 5,),
                    new Text(view_property_model!.key_feature5!,style: new TextStyle(fontFamily: "regular",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.center,),

                  ],)),

              ],
            ),
          ),
      ],
    );
  }

}