



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Cost_Sheet/Cost_Property.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/widgets/Form_Title.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../../Properties/Properties_Detail.dart';
import '../../Sheets/All_Bottom_Sheets.dart';
import '../../Utils/AppUtils.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../Utils/ServiceConfig.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/Form_Fields.dart';
import '../../widgets/My_Booking_Payment_Widget.dart';
import '../../widgets/My_Booking_Property.dart';

class Refund_To_Bank extends StatefulWidget{
  My_Booking_Models? list;
  String id="";
  String notes="";
  String property_id="";
  Refund_To_Bank(My_Booking_Models list, String id, String notes, String property_id){
    this.list=list;
    this.id=id;
    this.notes=notes;
    this.property_id=property_id;


  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }



}
class Build_State extends State<Refund_To_Bank>{

 int selected_reason=-1;
 final upi_id=TextEditingController();

 bool is_upi=true;


 final account_holder_name=TextEditingController();
 final bank_name=TextEditingController();
 final bank_branch=TextEditingController();
 final bank_account_no=TextEditingController();
 final bank_ifsc=TextEditingController();
 bool loading=false;
  @override
  void initState()   {
    super.initState();
    create_log();




  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Back"),
      body:

      Stack(children: [
        new SingleChildScrollView(
          child:  new Column(
            children: [
              My_Booking_Property(widget.list,on_click: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Properties_Detail(widget.list!.property_id,"false")));

              },),
              new Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),
                    border: new Border.all(width: 1,color: ColorFile.lightgray)

                ),
                child: Column(
                  children: [
                    new InkWell(child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),
                          border: new Border.all(width: 1,color: ColorFile.lightgray)

                      ),
                      margin: EdgeInsets.all(10),
                      child: new Row(
                        children: [
                          is_upi==true? new Icon(Icons.radio_button_checked,color: ColorFile.app_color):new Icon(Icons.radio_button_off,),
                          new SizedBox(width: 10,),
                          Expanded(child: new Container(child:new Text("UPI ID",style: Styles().styles_regular(14, ColorFile.black),)))


                        ],
                      ),
                    ),onTap: (){
                      setState(() {
                        is_upi=true;
                      });
                    },),
                    new SizedBox(height: 10,),
                    new InkWell(child:Container(
                      padding: EdgeInsets.all(10),
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),
                          border: new Border.all(width: 1,color: ColorFile.lightgray)

                      ),
                      margin: EdgeInsets.all(10),
                      child: new Row(
                        children: [
                          is_upi==false? new Icon(Icons.radio_button_checked,color: ColorFile.app_color):new Icon(Icons.radio_button_off),
                          new SizedBox(width: 10,),

                          Expanded(child: new Container(child:new Text("Bank Details",style: Styles().styles_regular(14, ColorFile.black),)))

                        ],
                      ),
                    ),onTap: (){
                      setState(() {
                        is_upi=false;
                      });
                    },)


                  ],
                ),),
              new SizedBox(height: 10,),
              if(is_upi)Form_Fields().book_filed("Enter Your UPI ID", upi_id, 50, false, false),
              if(is_upi==false)new Column(
                children: [
                  Form_Fields().book_filed("Account Holder Name", account_holder_name, 50, false, false),
                  Form_Fields().book_filed("Bank Name", bank_name, 50, false, false),
                  Form_Fields().book_filed("Bank Branch", bank_branch, 50, false, false),
                  Form_Fields().book_numric("Bank Account No.", bank_account_no, 20, false, false),
                  Form_Fields().book_filed("Bank IFSC Code", bank_ifsc, 50, false, false),


                ],
              )


            ],
          ),
        ),
        if(loading)Center(child: new CircularProgressIndicator(),)
      ],),
      bottomNavigationBar:
      Bottom_Button("Submit",onclick: (value){
        if(validate()){
           showAlertDialog(context,"You are about to cancel your booking in","Refund Confirmation");
        }






      },)

    );
  }

 Widget descr(String hint, TextEditingController controller) {
   return Container(
     height: 100,
     child: TextField(
       controller: controller,
       enabled: true,
       maxLength: 100,
       style:
       TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.black),
       decoration: InputDecoration(
           counterText: "",
           contentPadding: EdgeInsets.only(left: 10, right: 10),
           hintStyle: TextStyle(
               fontSize: 12, fontFamily: "regular", color: Colors.grey),
           hintText: hint,
           border: InputBorder.none,
           enabledBorder: InputBorder.none,
           focusedBorder: InputBorder.none,
           errorBorder: InputBorder.none,
           disabledBorder: InputBorder.none),
     ),
   );
 }


 void showAlertDialog(BuildContext ctx, message, title) {
   showCupertinoDialog(
       context: ctx,
       builder: (BuildContext ctx) {
         return CupertinoAlertDialog(
           title: Text(
             title+"\n",
             style: new TextStyle(fontFamily: "medium", fontSize: 15),
           ),
           content: Text(
             message+" "+widget.list!.PropertyTitle.toString(),
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
                 'No',
                 style: new TextStyle(fontFamily: "medium", fontSize: 15),
               ),
               isDefaultAction: false,
               isDestructiveAction: false,
             ),
             CupertinoDialogAction(
               onPressed: () async {
                 Navigator.pop(ctx);
                 submit_request();

               },
               child: const Text(
                 'Yes',
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

  bool validate() {
    if(is_upi==true){
      if(upi_id.text.length==0){
        AppUtils.toAst("Please Enter UPI ID",context);
        return false;
      }

    }
    if(is_upi==false){
      if(account_holder_name.text.length==0){
        AppUtils.toAst("Please Enter Account Holder Name",context);
        return false;
      }
      if(bank_name.text.length==0){
        AppUtils.toAst("Please Enter Bank Name",context);
        return false;
      }  if(bank_branch.text.length==0){
        AppUtils.toAst("Please Enter Bank Branch",context);
        return false;
      }  if(bank_account_no.text.length==0){
        AppUtils.toAst("Please Enter Bank Account Number",context);
        return false;
      }  if(bank_ifsc.text.length==0){
        AppUtils.toAst("Please Enter IFSC Code",context);
        return false;
      }
    }


    return true;
  }

  void submit_request() {
    var map = new Map<String, dynamic>();


    if(is_upi==true){
      map['upi_id'] =upi_id.text.toString();
      map['pay_option'] ="UPI ID";


    }else{
      map['bank_account_holder_name'] =account_holder_name.text.toString();
      map['bank_name'] =bank_name.text.toString();
      map['branch_name'] =bank_branch.text.toString();
      map['bank_account_no'] =bank_account_no.text.toString();
      map['bank_ifsc_code'] =bank_ifsc.text.toString();
      map['pay_option'] ="Bank Account";

    }
    map['payment_id'] =widget.list!.id;
    map['reason_id'] =widget.id.toString();
    map['comments'] =widget.notes.toString();
    map['property_id'] =widget.property_id.toString();

    print(json.encode(map));
    FormData formData = new FormData.fromMap(map);
    AppUtils().showProgressDialog(context);
    ServiceConfig().postApiBodyAuthJson(API.paymentRefund, formData, context)
        .then((value) async {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
      Response response = value;
      print(response.data.toString());
      if(response!=null&&response.statusCode==200){
        var data=await All_Bottom_Sheets().Success_dialog("Your refund request submitted successfully..!!", context);
        if(data!=null&&data==true){
          Navigator.pop(context,"saved");
        }

      }


    }).catchError((onError){
      print(onError.toString());
      AppUtils.toAst("Something Went Wrong",context);
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
    });


  }
 Future<void> create_log() async {
   await FireBase_Logs().log_screen_view("Fill Refund Booking Form", "Fill Refund Booking Form");

 }

}