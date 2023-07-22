import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/FireBase_Logs.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import '../widgets/Accept_Button.dart';
import '../wish_list/Shimmers_Effect.dart';




class Payment_tnc extends StatefulWidget{

  bool is_checked=false;
  Payment_tnc(bool is_checked){
    this.is_checked=is_checked;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}
class Build_state extends State<Payment_tnc>{
  String tnc="";
  bool loading=false;
  bool is_checked=false;
  @override
  initState() {
    super.initState();
    is_checked=widget.is_checked;
   get_tnc();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Terms & Conditions"),
      body: Stack(
       children: [
         if(loading==false&&tnc.length>0)
           new SingleChildScrollView(
           child:  new Container(
             padding: EdgeInsets.all(10),
             child:new Column(
               children: [
                 new Container(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[
                         Flexible(child: Html(data: tnc,
                           style: {
                             "body": Style(
                                 fontFamily: "regular",
                                 fontSize: FontSize(14.0),
                                 color: ColorFile.black

                             ),
                             'html': Style(textAlign: TextAlign.justify,color: ColorFile.black),
                             "table": Style(
                                 color: ColorFile.black,
                                 fontFamily: "Medium"
                             ),
                             "tr": Style(
                               fontFamily: "regular",
                               color: ColorFile.black,
                             ),
                             "th": Style(
                               fontFamily: "regular",
                               color: ColorFile.black,
                             ),
                             "td": Style(
                               fontFamily: "regular",
                               color: ColorFile.black,

                             ),
                             "h1": Style(
                                 fontFamily: "medium"
                             ),
                           },





                         )),
                       ],
                     )),
                 new InkWell(child: new Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     is_checked==true?Icon(Icons.check_box,color: ColorFile.app_color,):Icon(Icons.check_box_outline_blank),
                     new SizedBox(width: 10,),
                     new Container(child:new Text("I accept Terms & Conditions of Peprop.Money",style: new TextStyle(fontFamily: "medium",fontSize: 15,color: ColorFile.app_color,decoration: TextDecoration.underline),))


                   ],
                 ),onTap: (){
                 setState(() {
                     is_checked=!is_checked;
                   });},),
                 Accept_Button("Continue",is_checked,onclick: (value){
                   if(value==0){
                     Navigator.pop(context,is_checked);

                   }

                 },),
                 new SizedBox(height: 50,),


               ],
             ),
           ),

         ),
         if(loading==true)Center(child: new Shimmers_Effect(),),
         if(loading==false&&tnc.length==0)Center(child: No_Data_Placeholder("No Terms and conditions Found..!!"),)
       ],
     ),);
  }

  Future<void> get_tnc() async {

    await  FireBase_Logs().log_screen_view("View App Privacy Policy", "View App Privacy Policy");
    setState(() {
      loading=true;
    });
    ServiceConfig().postApiBodyAuthJson(API.tnc,new Map(), context).then((value) {
      Response response = value;
      setState(() {
        loading=false;
      });
      if (response != null && response.statusCode == 200) {
        tnc=response.data["data"]["peprop_tnc"].toString().replaceAll("null", "");
        print("response$tnc");

      }
    }).catchError((error, stackTrace) {
      setState(() {
        AppUtils.toAst("Something Went Wrong..",context);
        loading=false;


      });
    });

  }

}