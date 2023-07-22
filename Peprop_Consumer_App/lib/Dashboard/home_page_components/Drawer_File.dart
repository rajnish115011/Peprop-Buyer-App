

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/All_transactions/All_transactions.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Login/Login.dart';
import 'package:peprop_consumer_app/Profile/Profile_Menu.dart';
import 'package:peprop_consumer_app/Profile/User_Profile.dart';
import 'package:peprop_consumer_app/Rewards/Campaign_List.dart';
import 'package:peprop_consumer_app/Rewards/Coupon_Lists.dart';
import 'package:peprop_consumer_app/Rewards/Orders/My_Orders.dart';
import 'package:peprop_consumer_app/Terms_and_Conditions/Contact_Us.dart';
import 'package:peprop_consumer_app/Terms_and_Conditions/Loan_Terms.dart';
import 'package:peprop_consumer_app/buy_sell/MY_Buy_Sell.dart';
import 'package:peprop_consumer_app/loan/Apply_Loan.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Rewards/ReferAndEarn.dart';
import '../../Terms_and_Conditions/Refund_Policy.dart';
import '../../Terms_and_Conditions/Tnc.dart';
import '../../loan/Apply_Loan.dart';
import '../../loan/My_Loan_List.dart';

class Drawer_File extends StatelessWidget{
  String token="";

  Drawer_File(String token){
    this.token=token;


  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
          physics: ScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/logo.png",
                    height: 100,
                  )),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            SizedBox(
              height: 20,
            ),


           if(token.toString()!="null")

             new InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Profile_Menu()));
              },
              child:build_child("Profile","assets/menu/profile.png"),
            ),

            if(token.toString()!="null") new InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => All_transactions()));
              },
              child:build_child("All Transactions","assets/pbanking.png"),
            ),


            // if(token.toString()!="null") new InkWell(
            //   onTap: (){
            //
            //
            //     Navigator.of(context).pop();
            //     if(token.toString()!="null"){
            //       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Apply_Loan(null)));
            //
            //     }else{
            //       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));
            //
            //     }
            //   },
            //
            //   child:build_child("Apply Loan","assets/menu/apply_loan.png"),
            // ),
            //
            //
            // if(token.toString()!="null")  new InkWell(
            //
            //   onTap: (){
            //     Navigator.of(context).pop();
            //     if(token.toString()!="null"){
            //       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => My_Loan_List()));
            //
            //
            //     }else{
            //       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));
            //
            //     }
            //   },
            //   child:build_child("My Loan","assets/menu/myloan.png"),
            // ),

            if(token.toString()!="null")new InkWell(
              onTap: (){


                Navigator.of(context).pop();
                if(token.toString()!="null"){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Coupon_Lists()));

                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

                }
              },

              child:build_child("Gift Cards & Coupons","assets/menu/giftcard.png"),
            ),


            if(token.toString()!="null")new InkWell(
              onTap: (){


                Navigator.of(context).pop();
                if(token.toString()!="null"){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => My_Orders()));

                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

                }
              },

              child:build_child("My Orders","assets/order.png"),
            ),


            if(token.toString()!="null")new InkWell(
              onTap: (){


                Navigator.of(context).pop();
                if(token.toString()!="null"){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ReferAndEarn(null)));

                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

                }
              },

              child:build_child("Refer & Earn","assets/refer.png"),
            ),

            new InkWell(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Tnc(false,null)));
              },
              child:build_child("Terms & Conditions","assets/menu/tandc.png"),
            ),
            new InkWell(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Refund_Policy()));
              },
              child:build_child("Refund Policy","assets/refund.png"),
            ),

              new InkWell(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Contact_Us()));
              },
              child:build_child("Contact Us","assets/contact_us.png"),
            ),

            // new InkWell(
            //   onTap: (){
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Loan_Terms()));
            //   },
            //   child:build_child("Loan Terms & Conditions","assets/menu/loan_terms.png"),
            // ),

            new InkWell(
              onTap: (){
                Navigator.of(context).pop();
                if(token.toString()!="null"){

                  showAlertDialog(context, "Are you sure, Do you want to logout?", "Logout");
                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));
                }





              },
              child:build_child(token.toString()!="null"?"Logout":"Login/Register","assets/menu/logout.png"),
            ),

            SizedBox(height: 20,),

            SizedBox(
              height: 20,
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).pop();
            //   },
            //   child: Text(
            //     'Version 1.0',
            //     style: TextStyle(
            //       fontFamily: 'regular',
            //       fontSize: 12,
            //       fontWeight: FontWeight.w700,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),

          ]));

  }
  void showAlertDialog(BuildContext ctx, message, title) {
    showCupertinoDialog(
        context: ctx,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: new TextStyle(fontFamily: "medium", fontSize: 15),
            ),
            content: Text(
              message,
              style: new TextStyle(fontFamily: "regular", fontSize: 12),
            ),
            actions: [
              // The "Yes" button
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(
                  'Cancel',
                  style: new TextStyle(fontFamily: "medium", fontSize: 15),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  SharedPreferences sp=await SharedPreferences.getInstance();
                  sp.setString("token", "null");
                  sp.setString("user_id", "null");




                  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()),(Route<dynamic> route) => false);

                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontFamily: "medium",
                    fontSize: 15,
                  ),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }
  build_child(String title,String image_path) {
    return new
    Container(child: Row(
      children: [
        new SizedBox(width: 20,),
        Image.asset(image_path,height: 25,width: 25,),
        new SizedBox(width: 20,),
        Text(title,style: new TextStyle(fontFamily: "regular",fontSize: 16,color: Colors.black),),

      ],
    ),margin: EdgeInsets.only(top: 30),);
  }
}