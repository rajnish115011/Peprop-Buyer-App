import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert' show json, utf8;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Book_Now_Model.dart';
import 'package:peprop_consumer_app/Book_Now/Other_Payment_Sheet.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:peprop_consumer_app/Cost_Sheet/model/Builder_Detail_Model.dart';
import 'package:peprop_consumer_app/Models/MileStone_Payment_Model.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/Properties/Extra_json.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/Tower_Model.dart';
import '../../Thanks/Thank_You_Booking.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/Developer_Bank_sheet.dart';
class Pay_Milestones extends StatefulWidget{
 late  MileStone_Payment_Model model;
 My_Booking_Models? booking_details;
  Pay_Milestones(MileStone_Payment_Model model, My_Booking_Models? booking_details){
    this.model=model;
    this.booking_details=booking_details;

  }



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }

}
class Build_State extends State<Pay_Milestones> {


  final payment_type = TextEditingController();
  final amount = TextEditingController();


  //cheque
  final date = TextEditingController();
  final cheque_number = TextEditingController();
  final bank_name = TextEditingController();
  final account_number = TextEditingController();
  final account_holder_name = TextEditingController();
  final attachemnt = TextEditingController();


  //cash
  final reciept_number = TextEditingController();


  //online
  final utr_number = TextEditingController();
  final developer_bank = TextEditingController();



  final online_transaction_type = TextEditingController();


  XFile? document_file;


  List<dynamic>other_list = [];

  List<String>transaction_type_list = [];


  var selectedDate = DateTime.now();
  bool loading=false;


  int selected_account=-1;


  @override
  void initState() {
    super.initState();
    other_list=widget.booking_details!.payment_option_mode;
    amount.text=widget.model.milestone_net_due_amount.toString();


    if(other_list.length>0){
      payment_type.text=other_list[0].toString();
    }
    transaction_type_list.add("RTGS");
    transaction_type_list.add("NEFT");
    transaction_type_list.add("IMPS");
    create_log();



  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppUtils.appBar(context, "Payment Details"),
      body: new Stack(
        children: [
          new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text("Payment Mode", style: new TextStyle(fontFamily: "medium", fontSize: 16,),),
                      new SizedBox(height: 5,),
                      new Container(
                        child: new Row(
                          children: [
                            Expanded(child:
                            new Container(
                              height: 60,
                              child: TextFormField(
                                  controller: payment_type,
                                  onTap: () {
                                    method_show();
                                  },
                                  readOnly: true,
                                  style: TextStyle(fontSize: 12,
                                      fontFamily: "regular",
                                      color: Colors.black),
                                  decoration: AppUtils.dec_drop(
                                      "Select Payment Mode")
                              ),
                            ))
                          ],
                        ),
                      ),






                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text("Amount (₹)", style: new TextStyle(fontFamily: "medium", fontSize: 16,),),
                      new SizedBox(height: 5,),
                      new Container(
                        child: new Row(
                          children: [
                            Expanded(child:
                            new Container(
                              height: 60,
                              child: TextFormField(
                                keyboardType:TextInputType.numberWithOptions(decimal: true),
                                  controller: amount,
                                  inputFormatters: [
                                    CustomRangeTextInputFormatter(widget.model.milestone_net_due_amount.toString()),
                                ],
                                  readOnly: false,
                                  style: TextStyle(fontSize: 12,
                                      fontFamily: "regular",
                                      color: Colors.black),
                                  decoration: AppUtils.dec("Amount"),

                              ),
                            ))
                          ],
                        ),
                      )


                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text("Issue Date", style: new TextStyle(
                        fontFamily: "medium", fontSize: 16,),),
                      new SizedBox(height: 5,),
                      new Container(
                        child: new Row(
                          children: [
                            Expanded(child:
                            new Container(
                              height: 60,
                              child: TextFormField(
                                  onTap: () {
                                    choose_date();
                                  },
                                  controller: date,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 12,
                                      fontFamily: "regular",
                                      color: Colors.black),
                                  decoration: AppUtils.dec_calender(
                                      "mm/dd/yyyy")
                              ),
                            ))
                          ],
                        ),
                      )


                    ],
                  ),
                ),


                if(payment_type.text.toLowerCase().toString() == "cheque"||payment_type.text.toLowerCase().trim().contains("demand"))cheq(),
                if(payment_type.text.toString().trim().toLowerCase() == "cash")cash_widget(),
                if(payment_type.text.toString().toLowerCase() == "online")online_widget(),
                new Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(child: new Text("Document",
                        style: new TextStyle(
                          fontFamily: "medium", fontSize: 16,),),),
                      new SizedBox(height: 10,),
                      new Container(
                        height: 60,
                        child: TextFormField(
                            onTap: () {
                              pick_gallery_images();
                            },
                            controller: attachemnt,
                            readOnly: true,
                            style: TextStyle(fontSize: 12,
                                fontFamily: "regular",
                                color: Colors.black),
                            decoration: AppUtils.dec("Select Document")
                        ),
                      )


                    ],
                  ),
                ),



              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(child: Container(
                height: 56,
                alignment: Alignment.center,
                color: Colors.red,
                child: Text(
                    "Submit", style: Styles().styles_bold(12, ColorFile.white)),
              ), onTap: () async {
                if(validate_cash()){
                  var request = await generate_checq();
                }
              },),
            ),
          ],
        ),
      ),

    );
  }


  Future<void> choose_date() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formatter = DateFormat('yyyy-MM-dd').format(selectedDate);
        date.text = formatter;
      });
    }
  }

  bool validate_cash() {
    if(payment_type.text.toString().length==0){
      AppUtils.toAst("Please Select Payment Type", context);

      return false;

    }
    if(date.text.toString().length==0){
      AppUtils.toAst("Please Select Date", context);

      return false;

    }
    if(payment_type.text.toString().trim().toLowerCase().contains("cash")){
      if(reciept_number.text.length==0){
        AppUtils.toAst("Please Enter Receipt Number", context);
        return false;
      }


    }if(payment_type.text.toString().trim().toLowerCase().contains("cheque")){
      if(cheque_number.text.length==0){
        AppUtils.toAst("Please Enter Cheque Number", context);
        return false;
      }  if(bank_name.text.length==0){
        AppUtils.toAst("Please Enter Bank Name", context);
        return false;
      } if(account_number.text.length==0){
        AppUtils.toAst("Please Enter Account Number", context);
        return false;
      } if(account_holder_name.text.length==0){
        AppUtils.toAst("Please Enter Account Holder Name", context);
        return false;
      }

    } if(payment_type.text.toString().trim().toLowerCase().contains("demand draft")){
      if(cheque_number.text.length==0){
        AppUtils.toAst("Please Enter DD number", context);
        return false;
      }  if(bank_name.text.length==0){
        AppUtils.toAst("Please Enter Bank Name", context);
        return false;
      } if(account_number.text.length==0){
        AppUtils.toAst("Please Enter Account Number", context);
        return false;
      } if(account_holder_name.text.length==0){
        AppUtils.toAst("Please Enter Account Holder Name", context);
        return false;
      }
    }
    if(payment_type.text.toString().trim().toLowerCase().contains("online")){
        if(bank_name.text.length==0){
        AppUtils.toAst("Please Enter Bank Name", context);
        return false;
      } if(online_transaction_type.text.length==0){
        AppUtils.toAst("Please Select Transaction Type", context);
        return false;
      } if(utr_number.text.length==0){
        AppUtils.toAst("Please Enter UTR Number", context);
        return false;
      }
    }

    return true;
  }



  Future<void> pick_gallery_images() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        document_file = file;
        attachemnt.text = document_file!.name.toString();
      });
    }
  }



  Widget cheq() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text(payment_type.text.toLowerCase().trim().contains("demand")?"DD Number":"Cheque Number", style: new TextStyle(
                fontFamily: "medium", fontSize: 16,),),
              new SizedBox(height: 5,),
              new Container(
                child: new Row(
                  children: [
                    Expanded(child:
                    new Container(
                      height: 60,
                      child: TextFormField(
                          controller: cheque_number,

                          readOnly: false,
                          style: TextStyle(fontSize: 12,
                              fontFamily: "regular",
                              color: Colors.black),
                          decoration: AppUtils.dec(payment_type.text.toLowerCase().trim().contains("demand")?"DD Number":"Cheque Number")
                      ),
                    ))
                  ],
                ),
              )


            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("Bank Name", style: new TextStyle(
                fontFamily: "medium", fontSize: 16,),),
              new SizedBox(height: 5,),
              new Container(
                child: new Row(
                  children: [
                    Expanded(child:
                    new Container(
                      height: 60,
                      child: TextFormField(
                          controller: bank_name,

                          style: TextStyle(fontSize: 12,
                              fontFamily: "regular",
                              color: Colors.black),
                          decoration: AppUtils.dec(
                              "Enter Bank Name")
                      ),
                    ))
                  ],
                ),
              )


            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("A/C Number", style: new TextStyle(
                fontFamily: "medium", fontSize: 16,),),
              new SizedBox(height: 5,),
              new Container(
                child: new Row(
                  children: [
                    Expanded(child:
                    new Container(
                      height: 60,
                      child: TextFormField(
                          controller: account_number,

                          style: TextStyle(fontSize: 12,
                              fontFamily: "regular",
                              color: Colors.black),
                          decoration: AppUtils.dec("A/C Number")
                      ),
                    ))
                  ],
                ),
              )


            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("A/C Holder Name", style: new TextStyle(
                fontFamily: "medium", fontSize: 16,),),
              new SizedBox(height: 5,),
              new Container(
                child: new Row(
                  children: [
                    Expanded(child:
                    new Container(
                      height: 60,
                      child: TextFormField(
                          controller: account_holder_name,

                          style: TextStyle(fontSize: 12,
                              fontFamily: "regular",
                              color: Colors.black),
                          decoration: AppUtils.dec(
                              "A/C Holder Name")
                      ),
                    ))
                  ],
                ),
              )


            ],
          ),
        ),


      ],
    );
  }

  Widget cash_widget() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("Receipt Number", style: new TextStyle(
                fontFamily: "medium", fontSize: 16,),),
              new SizedBox(height: 5,),
              new Container(
                child: new Row(
                  children: [
                    Expanded(child:
                    new Container(
                      height: 60,
                      child: TextFormField(
                          controller: reciept_number,
                          readOnly: false,
                          style: TextStyle(fontSize: 12,
                              fontFamily: "regular",
                              color: Colors.black),
                          decoration: AppUtils.dec("Receipt Number")
                      ),
                    ))
                  ],
                ),
              )


            ],
          ),
        ),


      ],
    );
  }

  Widget online_widget() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("Bank Name", style: new TextStyle(
                fontFamily: "medium", fontSize: 16,),),
              new SizedBox(height: 5,),
              new Container(
                child: new Row(
                  children: [
                    Expanded(child:
                    new Container(
                      height: 60,
                      child: TextFormField(
                          controller: bank_name,
                          style: TextStyle(fontSize: 12,
                              fontFamily: "regular",
                              color: Colors.black),
                          decoration: AppUtils.dec(
                              "Enter Bank Name")
                      ),
                    ))
                  ],
                ),
              )


            ],
          ),
        ),

        new Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("Transaction Type", style: new TextStyle(
                fontFamily: "medium", fontSize: 16,),),
              new SizedBox(height: 5,),
              new Container(
                child: new Row(
                  children: [
                    Expanded(child:
                    new Container(
                      height: 60,
                      child: TextFormField(
                          controller: online_transaction_type,
                          onTap: () {
                            show_transaction_type();
                          },
                          readOnly: true,
                          style: TextStyle(fontSize: 12,
                              fontFamily: "regular",
                              color: Colors.black),
                          decoration: AppUtils.dec_drop(
                              "Select Payment Type")
                      ),
                    ))
                  ],
                ),
              ),


            ],
          ),
        ),



        new Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("UTR Number", style: new TextStyle(
                fontFamily: "medium", fontSize: 16,),),
              new SizedBox(height: 5,),
              new Container(
                child: new Row(
                  children: [
                    Expanded(child: new Container(
                      height: 60,
                      child: TextFormField(
                          controller: utr_number,
                          style: TextStyle(fontSize: 12,
                              fontFamily: "regular",
                              color: Colors.black),
                          decoration: AppUtils.dec(
                              "Enter UTR Number")
                      ),
                    ))
                  ],
                ),
              )


            ],
          ),
        ),
      ],
    );
  }

  void show_transaction_type() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return new Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Other_Payment_Sheet(
              transaction_type_list,
              online_transaction_type.text.toString(),
              onSelectionChanged: (value) {
                if (value != null) {
                  setState(() {
                    online_transaction_type.text =
                        transaction_type_list[value].toString();
                  });
                }
              },
            ),
          );
        });
  }

  void method_show() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return new Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Other_Payment_Sheet1(
              other_list,
              payment_type.text.toString(),

              onSelectionChanged: (value) {
                if (value != null) {
                  setState(() {
                    payment_type.text = other_list[value].toString();
                  });
                }
              },
            ),
          );
        });
  }



  generate_checq() async {
    var uri = Uri.parse(API.updatePayment);
    var request = new http.MultipartRequest("POST", uri);
    if (document_file != null) {String fileName = document_file!.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(document_file!.openRead()));
      var length = await document_file!.length(); //imageFile is your image file
      var multipartFileSign = new http.MultipartFile('document', stream, length, filename: fileName);
      request.files.add(multipartFileSign);
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {"Accept": "application/json", "Authorization": sharedPreferences.getString("token").toString()}; // ignore this headers if there is no authentication
    print( sharedPreferences.getString("token").toString());
    request.headers.addAll(headers);
    if(payment_type.text.toString().trim().toLowerCase().contains("cash")){
      request.fields['payment_reciept_number'] =reciept_number.text.toString();

    }if(payment_type.text.toString().trim().toLowerCase().contains("cheque")){
      request.fields['cheque_number'] =cheque_number.text.toString();
      request.fields['bank_name'] =bank_name.text.toString();
      request.fields['account_number'] =account_number.text.toString();
      request.fields['account_holder_name'] =account_holder_name.text.toString();
    } if(payment_type.text.toString().trim().toLowerCase().contains("demand draft")){
      request.fields['dd_number'] =cheque_number.text.toString();
      request.fields['bank_name'] =bank_name.text.toString();
      request.fields['account_number'] =account_number.text.toString();
      request.fields['account_holder_name'] =account_holder_name.text.toString();
    }
    if(payment_type.text.toString().trim().toLowerCase().contains("online")){
      request.fields['bank_name'] =bank_name.text.toString();
      request.fields['transaction_type'] =online_transaction_type.text.toString();
      request.fields['utr_number'] =utr_number.text.toString();
    }
    request.fields['prop_id'] =widget.booking_details!.property_id.toString();
    request.fields['inventory_id'] =widget.model.lead_inventory_id.toString();
    request.fields['paymnet_plan_id'] =widget.model.payment_plan_id.toString();
    request.fields['milestone_id'] = widget.model.payment_plan_milestone_id.toString();
    request.fields['payment_amount'] =widget.model.milestone_net_due_amount.toString();
    request.fields['payment_issue_date'] =AppUtils().yyyy_mm_dd_to_dd_mm_yyyy(date.text.toString());
    request.fields['payment_mode'] =payment_type.text.toString();
    print(request.fields);
    AppUtils().showProgressDialog(context);
    var response = await request.send();
    Navigator.of(context, rootNavigator: true).pop("Discard");
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    if (response.statusCode == 200) {
      AppUtils.toAst("Application Request Submit Successfully..!!",context);
      var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Thank_You_payment()));

    } else {
      AppUtils.toAst("Connection Timeout!",context);
    }
  }








  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("Book Now with cash/cheque", "Book Now with cash/cheque");

  }


}
class CustomRangeTextInputFormatter extends TextInputFormatter {

  String amount="";
  CustomRangeTextInputFormatter(String amount){
    this.amount=amount;
  }


  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue,) {
    if(newValue.text == '')
      return TextEditingValue();
    else if(int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > double.parse(amount) ? TextEditingValue().copyWith(text: amount) : newValue;
  }
}

