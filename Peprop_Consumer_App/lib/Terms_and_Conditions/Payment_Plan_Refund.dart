import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import '../wish_list/Shimmers_Effect.dart';




class Payment_Plan_Refund extends StatefulWidget{

  bool is_checked=false;
  String text="";
  Payment_Plan_Refund(bool is_checked,String text){
    this.is_checked=is_checked;
    this.text=text;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}
class Build_state extends State<Payment_Plan_Refund>{
  String tnc="";
  bool loading=false;
  bool is_checked=false;
  @override
  initState() {
    super.initState();
    is_checked=widget.is_checked;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Terms & Conditions"),
      body: Stack(
       children: [
         if(loading==false&&widget.text.toString().length>0)
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
                         Flexible(child: Html(data: widget.text.toString(),
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
                 // new InkWell(child: new Row(
                 //   mainAxisAlignment: MainAxisAlignment.start,
                 //   crossAxisAlignment: CrossAxisAlignment.center,
                 //   children: [
                 //     is_checked==true?Icon(Icons.check_box,color: ColorFile.app_color,):Icon(Icons.check_box_outline_blank),
                 //     new SizedBox(width: 10,),
                 //     new Container(child:new Text("I accept the refund policy",style: new TextStyle(fontFamily: "medium",fontSize: 15,color: ColorFile.app_color,decoration: TextDecoration.underline),))
                 //
                 //
                 //   ],
                 // ),onTap: (){setState(() {
                 //     is_checked=!is_checked;
                 //   });},),
                 // Accept_Button("Continue",is_checked,onclick: (value){
                 //   if(value==0){
                 //     Navigator.pop(context,is_checked);
                 //
                 //   }
                 //
                 // },),
                 // new SizedBox(height: 50,),
                 //

               ],
             ),
           ),

         ),
         if(loading==true)Center(child: new Shimmers_Effect(),),

       ],
     ),);
  }



}