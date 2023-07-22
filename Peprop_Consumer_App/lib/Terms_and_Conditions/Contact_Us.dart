import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/FireBase_Logs.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import '../Cost_Sheet/model/Builder_Detail_Model.dart';
import '../Global_connection/Global_connection.dart';
import '../wish_list/Shimmers_Effect.dart';
import '../wish_list/Styles.dart';
class Contact_Us extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}
class Build_state extends State{
  String tnc="";
  bool loading=false;
  Contact_details?contact_us;
  @override
  initState() {
    super.initState();
   get_tnc();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBarTitle(context, "Contact Us"),
      body:
      Stack(
       children: [
         if(loading==false&&contact_us!=null)
           new SingleChildScrollView(
           child:  new Container(
             padding: EdgeInsets.all(20),
             child: new Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 new Container(height: 200,decoration: new BoxDecoration(
                   image: DecorationImage(
                     image: NetworkImage(contact_us!.banner.toString())
                   )
                 ),),

                 new SizedBox(height: 20,),
                 
                 new Text(contact_us!.company_address.toString(),style: Styles().styles_medium(17, ColorFile.app_color),),
                 new SizedBox(height: 20,),


                 new Container(child: new Row(
                   children: [
                     new Container(height: 30,width:30,color: ColorFile.app_color,child: Icon(Icons.location_on,color: ColorFile.white,size: 20,),),
                     new SizedBox(width: 20,),
                     Expanded(child:new Container(child:new Text(contact_us!.addresss.toString(),style: Styles().styles_regular(15, ColorFile.black),)))
                   ],
                 ),),
                 new SizedBox(height: 20,),
                 new Container(child: new Row(
                   children: [
                     new Container(height: 30,width:30,color: ColorFile.app_color,child: Icon(Icons.email,color: ColorFile.white,size: 20,),),
                     new SizedBox(width: 20,),
                     Expanded(child:new Container(child:new Text(contact_us!.email.toString(),style: Styles().styles_regular(15, ColorFile.black),)))
                   ],
                 ),),
                 new SizedBox(height: 20,),

                 new Container(child: new Row(
                   children: [
                     new Container(height: 30,width:30,color: ColorFile.app_color,child: Icon(Icons.phone_android_rounded,color: ColorFile.white,size: 20,),),
                     new SizedBox(width: 20,),
                     Expanded(child:new Container(child:new Text("+"+contact_us!.cc.toString()+contact_us!.mobile.toString(),style: Styles().styles_regular(15, ColorFile.black),)))
                   ],
                 ),),
                 new SizedBox(height: 20,),

                 new Text("We are open",style: Styles().styles_medium(17, ColorFile.app_color),),
                 new SizedBox(height: 10,),
                 new Container(child: new Row(
                   children: [

                     Expanded(child:new Container(child:new Text(contact_us!.day.toString()+" from "+contact_us!.time.toString(),style: Styles().styles_regular(15, ColorFile.black),)))
                   ],
                 ),),






               ],
             )


            ,
           ),

         ),
         if(loading==true)Center(child: new Shimmers_Effect(),),
         if(loading==false&&contact_us==null)Center(child: No_Data_Placeholder("No Terms and conditions Found..!!"),)
       ],
     ),);
  }

  Future<void> get_tnc() async {

    await  FireBase_Logs().log_screen_view("View App Privacy Policy", "View App Privacy Policy");
    setState(() {
      loading=true;
    });

   var response=await Global_connection().get_method(context, API.appContactAddress);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      var inventorydata = response.data["data"];
       contact_us = Contact_details.fromJson(inventorydata);
    }
    setState(() {
      loading=false;
    });


  }

}