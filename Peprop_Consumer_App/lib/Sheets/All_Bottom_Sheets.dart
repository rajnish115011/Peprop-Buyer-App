


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Requirements/Show_Area_type.dart';
import 'package:peprop_consumer_app/Rewards/Spin/Luck.dart';

import '../Color/ColorFile.dart';
import '../Models/Campaign_Model.dart';
import '../Models/User_Model.dart';
import '../Rewards/Coupon_types/TermsConditionsSheet.dart';
import '../Rewards/Spin/Spin_Sheet.dart';

class All_Bottom_Sheets {


  Future<dynamic> show_spin(Offers_List_Refer? list,BuildContext context) async {

    var return_value;
    await showModalBottomSheet(
        // isScrollControlled: true,

        shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
    ),
    context: context, builder: (_) =>Container(

    decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white),
    child:Spin_Sheet(list!,onupdate: (value){
    return_value=value;

    },),


    ));
    return return_value;


  }


  Future<dynamic> show_user_details(User_Model? user_model,BuildContext context) async {

    var return_value;
    await showModalBottomSheet(
       isScrollControlled: true,

        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        context: context, builder: (_) =>Container(
      height: MediaQuery.of(context).size.height-200,
      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white),
      child:User_Form(user_model!,onupdate: (value){
        return_value=value;

      },),


    ));
    return return_value;


  }


  Future<dynamic> show_area(List<dynamic> list,String value,BuildContext context) async {
    var return_value;
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        context: context, builder: (_) =>Container(
      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white),
      child:Show_Area_type(list,value.toString(),onSelectionChanged: (value){
        return_value=value;

      },),


    ));
    return return_value;

  }

  Future<dynamic> show_terms_and_conditions(Offers offer, BuildContext context) async {
    var return_value;
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        context: context, builder: (_) =>Container(
        height: MediaQuery.of(context).size.height-100,
        decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white),
        child:TermsConditionsSheet(offer,onSelectionChanged: (){


      },),


    ));
    return return_value;

  }



  Future<dynamic> Confirmation_dialog(String title,String message,BuildContext context) async {
    var retrun_value=null;
       await showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: new TextStyle(fontFamily: "bold", fontSize: 15,color: ColorFile.red_900),
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
                  Navigator.pop(ctx,false);
                  retrun_value=false;

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
                  Navigator.pop(ctx,true);
                  retrun_value=true;

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

    return retrun_value;



  }
  Future<dynamic> accept_dialog(String title,String message,BuildContext context) async {
    var retrun_value=null;
    await showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: new TextStyle(fontFamily: "bold", fontSize: 15,color: ColorFile.red_900),
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
                  Navigator.pop(ctx,false);
                  retrun_value=false;

                },
                child: Text(
                  'Reject',
                  style: new TextStyle(fontFamily: "medium", fontSize: 15),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  Navigator.pop(ctx,true);
                  retrun_value=true;

                },
                child: const Text(
                  'Accept and Order',
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

    return retrun_value;



  }


  Future<dynamic> Success_dialog(String message,BuildContext context) async {
    var retrun_value=null;
    await showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              "Success",
              style: new TextStyle(fontFamily: "bold", fontSize: 15,color: ColorFile.red_900),
            ),
            content: Text(
              message,
              style: new TextStyle(fontFamily: "regular", fontSize: 12),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () async {
                  Navigator.pop(ctx,true);
                  retrun_value=true;

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

    return retrun_value;



  }

  Future<dynamic> error(String message,BuildContext context) async {
    var retrun_value=null;
    await showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(

            content: Text(
              message,
              style: new TextStyle(fontFamily: "regular", fontSize: 12),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () async {
                  Navigator.pop(ctx,true);
                  retrun_value=true;

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

    return retrun_value;



  }


}