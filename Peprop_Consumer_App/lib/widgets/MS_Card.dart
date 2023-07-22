

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Terms_and_Conditions/MIles_Descriptions.dart';

import '../Models/Tower_Model.dart';
import '../wish_list/Styles.dart';

class MS_Card extends StatelessWidget{
  late Payment_milestones payment_milestones;
  int index=0;
  MS_Card(Payment_milestones payment_milestones, int index){
    this.payment_milestones=payment_milestones;
    this.index=index;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      InkWell(child: Container(
        margin: EdgeInsets.only(left: 15,right: 15),
        child: Container(



          child:
          new Column(
            children: [
              if(index==0)new Container(
                height: 50,
                color: ColorFile.app_color,

                alignment: Alignment.center,

                child: new Container(child:  new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(alignment: Alignment.center,child: new Text("S. No.",style: Styles().styles_medium(12, ColorFile.white),),width: 60,),
                    new Container(height: 50,width: 1,color: ColorFile.white,) ,


                    Expanded(child: new Container(alignment: Alignment.center,child: new Text("Milestone",style: Styles().styles_regular(12, ColorFile.white),),)),
                    new Container(height: 50,width: 1,color: ColorFile.white,) ,

                    Expanded(child: new Container(alignment: Alignment.centerRight,child: new Text("Amount(%)",style: Styles().styles_regular(12, ColorFile.white),),))


                  ],
                ),padding: EdgeInsets.all(10),)
               
              ),
              new Container(
                padding: EdgeInsets.all(10),
                height: 50,
                color: ColorFile.white,

                alignment: Alignment.center,

                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(alignment: Alignment.center,child: new Text((index+1).toString(),style: Styles().styles_medium(12, ColorFile.black),),width: 60,),
                    new Container(height: 50,width: 1,color: ColorFile.black,) ,


                    Expanded(child: new Container(alignment: Alignment.center,child: new Text(payment_milestones.milestone_name.toString(),style: Styles().styles_regular(12, ColorFile.black),textAlign: TextAlign.center,),)),
                    new Container(height: 50,width: 1,color: ColorFile.black,) ,

                    Expanded(child: new Container(alignment: Alignment.centerRight,child: new Text(payment_milestones.amount.toString()+"%",style: Styles().styles_regular(12, ColorFile.black),),))


                  ],
                ),
              ),
              new Container(child: new Row(),color: ColorFile.black,height: 1,)
            ],
          ),

        ),
      ),onTap: (){
        var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => MIles_Descriptions(payment_milestones.stage_description.toString())));

      },);
  }

}
