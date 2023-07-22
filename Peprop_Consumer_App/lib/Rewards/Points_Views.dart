


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Cost_Sheet/model/Builder_Detail_Model.dart';
import 'package:peprop_consumer_app/Rewards/Coupon_Lists.dart';

import '../Color/ColorFile.dart';
import '../wish_list/Styles.dart';

class Points_Views extends StatelessWidget{
  wallet_data? wallet_data_model;
  Points_Views(wallet_data? wallet_data_model){
    this.wallet_data_model=wallet_data_model;
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new

    Container(
      color: ColorFile.dark_blue,
      child: new Column(
        children: [
          new Container(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
            width: MediaQuery.of(context).size.width,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text:  TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                          text: 'Welcome to',
                          style:TextStyle(fontFamily: "medium",fontSize: 20,color: ColorFile.white)
                      ),
                      TextSpan(
                          text: ' Peprop.Money',
                          style:TextStyle(fontFamily: "bold",fontSize: 20,color: ColorFile.white)
                      ),
                      TextSpan(
                          text: '\nRewards Program',
                          style:TextStyle(fontFamily: "medium",fontSize: 20,color: ColorFile.white)
                      ),
                    ],
                  ),
                )
              ],
            ),),
          new Container(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: new Row(children: [
              InkWell(child: new Container(child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text("Points Earned",style: Styles().styles_regular(10, ColorFile.white),),
                  new SizedBox(height: 5,),
                  new Container(alignment: Alignment.center,height: 30,padding: EdgeInsets.only(left: 25,right: 25),child:new Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.star,color: ColorFile.yellowdark,size: 15,),new SizedBox(width: 5,), new Text(wallet_data_model!.balance_points.toString(),style: Styles().styles_bold(13, ColorFile.black,),),new SizedBox(width: 5,),Icon(Icons.arrow_forward_ios,size: 15,color: ColorFile.app_color,)],),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),color: ColorFile.white),)
                ],
              ),),onTap: (){

              },),



            ],),)

        ],
      ),);
  }

}