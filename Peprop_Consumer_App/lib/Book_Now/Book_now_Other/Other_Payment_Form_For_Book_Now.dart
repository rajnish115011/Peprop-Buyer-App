import 'package:async/async.dart';
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
import 'package:peprop_consumer_app/Properties/Extra_json.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/Tower_Model.dart';
import '../../Thanks/Thank_You_Booking.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/Developer_Bank_sheet.dart';
class Other_Payment_Form_For_Book_Now extends StatefulWidget{
  Book_Now_Model? book_now_model;
  Other_Payment_Form_For_Book_Now(Book_Now_Model? book_now_model){
    this.book_now_model=book_now_model;
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }

}
class Build_State extends State<Other_Payment_Form_For_Book_Now> {


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
    other_list=widget.book_now_model!.form_property_model!.view_property_model!.payment_option_mode;
    payment_type.text=widget.book_now_model!.form_property_model!.view_property_model!.payment_option_mode[0].toString();
    transaction_type_list.add("RTGS");
    transaction_type_list.add("NEFT");
    transaction_type_list.add("IMPS");

    create_log();



  }

  @override
  Widget build(BuildContext context) {
    amount.text =widget.book_now_model!.booking_amount.toString();
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



                      new Text("Select Developer Bank", style: new TextStyle(fontFamily: "medium", fontSize: 16,),),
                      new SizedBox(height: 5,),
                      new Container(
                        child: new Row(
                          children: [
                            Expanded(child:
                            new Container(
                              height: 60,
                              child: TextFormField(
                                  controller: developer_bank,
                                  onTap: () {
                                    developer_account();
                                  },
                                  readOnly: true,
                                  style: TextStyle(fontSize: 12,
                                      fontFamily: "regular",
                                      color: Colors.black),
                                  decoration: AppUtils.dec_drop(
                                      "Select Developer Bank")
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
                      new Text("Amount", style: new TextStyle(fontFamily: "medium", fontSize: 16,),),
                      new SizedBox(height: 5,),
                      new Container(
                        child: new Row(
                          children: [
                            Expanded(child:
                            new Container(
                              height: 60,
                              child: TextFormField(
                                  controller: amount,

                                  readOnly: true,
                                  style: TextStyle(fontSize: 12,
                                      fontFamily: "regular",
                                      color: Colors.black),
                                  decoration: AppUtils.dec("Amount")
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

                if(developer_bank.text.length>0)
                 new Container(child:  new Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     new Container(child:new Row(children: [
                       new Text("Developer account details",style:Styles().styles_bold(15, ColorFile.black)),

                     ],),),
                     new SizedBox(height: 10,),
                     new Container(
                       padding: EdgeInsets.only(right: 10),
                       color: ColorFile.calls,
                       height: 40,
                       child:new Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           new SizedBox(width: 10,),
                           Expanded(child: new Container(child:new Row(children: [
                             new Text("Bank Name",style:Styles().styles_bold(13, ColorFile.hint_color)),

                           ],),)),

                           new Container(child: new Text(widget.book_now_model!.form_property_model!.view_property_model!.payment_option_other[selected_account].bank_name.toString(),style:Styles().styles_bold(16, ColorFile.hint_color)),),


                         ],
                       ),

                     ),
                     new Container(
                       padding: EdgeInsets.only(right: 10),
                       color: ColorFile.calls,
                       height: 40,
                       child:new Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           new SizedBox(width: 10,),
                           Expanded(child: new Container(child:new Row(children: [
                             new Text("Account Number",style:Styles().styles_bold(13, ColorFile.hint_color)),

                           ],),)),

                           new Container(child: new Text(widget.book_now_model!.form_property_model!.view_property_model!.payment_option_other[selected_account].account_no.toString(),style:Styles().styles_bold(16, ColorFile.hint_color)),),


                         ],
                       ),

                     ),
                     new Container(
                       padding: EdgeInsets.only(right: 10),
                       color: ColorFile.calls,
                       height: 40,
                       child:new Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           new SizedBox(width: 10,),
                           Expanded(child:
                           new Container(child:new Row(children: [
                             new Text("IFSC Code",style:Styles().styles_bold(13, ColorFile.hint_color)),

                           ],),)),

                           new Container(child: new Text(widget.book_now_model!.form_property_model!.view_property_model!.payment_option_other[selected_account].ifsc_code.toString(),style:Styles().styles_bold(16, ColorFile.hint_color)),),


                         ],
                       ),

                     ),
                   ],
                 ),margin: EdgeInsets.all(10),)


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
                if (payment_type.text.toString() == "Cheque"||payment_type.text.toLowerCase().trim().contains("demand")) {
                  if (validate_cheq()) {
                    var request = await generate_checq();
                    submit_request(request);
                  }
                }
                if (payment_type.text.toString().trim().toLowerCase() == "cash") {
                  if (validate_cash()) {
                    var request = await generate_Cash_request();
                    submit_request(request);
                  }
                }
                if (payment_type.text.toString() == "Online") {
                  if (validate_online()) {
                    var request =await generate_online_request();
                    submit_request(request);
                  }


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
    if (date.text.length == 0) {
      AppUtils.toAst("Please Select Date",context);
      return false;
    }
    if (reciept_number.text.length == 0) {
      AppUtils.toAst("Please Enter Receipt Number..!!",context);
      return false;
    }

    return true;
  }

  bool validate_cheq() {
    if (date.text.length == 0) {
      AppUtils.toAst("Please Select Date",context);
      return false;
    }



    if (cheque_number.text.length == 0) {
      if(payment_type.text.toLowerCase().trim().contains("demand")){
        AppUtils.toAst("Please Enter DD Number..!!",context);
      }else{
        AppUtils.toAst("Please Enter Cheque Number..!!",context);
      }

      return false;
    }
    if (bank_name.text.length == 0) {
      AppUtils.toAst("Please Enter Bank Name..!!",context);
      return false;
    }
    if (account_number.text.length == 0) {
      AppUtils.toAst("Please Enter Account Number..!!",context);
      return false;
    }
    if (account_holder_name.text.length == 0) {
      AppUtils.toAst("Please Enter Account Holder Name..!!",context);
      return false;
    }
    return true;
  }


  bool validate_online() {
    if (date.text.length == 0) {
      AppUtils.toAst("Please Select Date",context);
      return false;
    }
    if (bank_name.text.length == 0) {
      AppUtils.toAst("Please Enter Bank Name..!!",context);
      return false;
    }
    if (online_transaction_type.text.length == 0) {
      AppUtils.toAst("Please Enter Transaction type..!!",context);
      return false;
    }

    if (utr_number.text.length == 0) {
      AppUtils.toAst("Please Enter UTR Number..!!",context);
      return false;
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

  void developer_account() {
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
            child: Developer_Bank_sheet(
              widget.book_now_model!.form_property_model!.view_property_model!.payment_option_other,
              developer_bank.text.toString(),

              onSelectionChanged: (value) {

                if (value != null) {
                  setState(() {
                    selected_account=value;
                    developer_bank.text =widget.book_now_model!.form_property_model!.view_property_model!.payment_option_other[value].bank_name.toString();
                  });
                }
              },
            ),
          );
        });
  }


  generate_checq() async {
    var uri = Uri.parse(API.payOnlineOfflineFormData);
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
    request.fields['property_id'] = widget.book_now_model!.form_property_model!.property_id;
    request.fields['amt'] = widget.book_now_model!.booking_amount.toString();
    request.fields['sel_pay_by'] = "pay_by_other";
    request.fields['mode_type'] = payment_type.text.toString();
    request.fields['chq_number'] = cheque_number.text.toString();
    request.fields['chq_issue_date'] = date.text.toString();
    request.fields['chq_bank_name'] = bank_name.text.toString();
    request.fields['chq_ac_number'] = account_number.text.toString();
    request.fields['bank_holder_name'] = account_holder_name.text.toString();
    return request;
  }

  generate_Cash_request() async {
    var uri = Uri.parse(API.payOnlineOfflineFormData);
    var request = new http.MultipartRequest("POST", uri);
    if (document_file != null) {
      String fileName = document_file!.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(document_file!.openRead()));
      var length = await document_file!.length(); //imageFile is your image file
      var multipartFileSign = new http.MultipartFile('document', stream, length, filename: fileName);
      request.files.add(multipartFileSign);
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {"Accept": "application/json", "Authorization": sharedPreferences.getString("token").toString()}; // ignore this headers if there is no authentication
    request.headers.addAll(headers);

    request.fields['property_id'] = widget.book_now_model!.form_property_model!.property_id;
    request.fields['amt'] = widget.book_now_model!.booking_amount.toString();
    request.fields['sel_pay_by'] = "pay_by_other";
    request.fields['mode_type'] = "cash";
    request.fields['csh_recpt'] = reciept_number.text.toString();
    request.fields['csh_date'] = date.text.toString();
    return request;
  }

  generate_online_request() async {
    var uri = Uri.parse(API.payOnlineOfflineFormData);
    var request = new http.MultipartRequest("POST", uri);
    if (document_file != null) {
      String fileName = document_file!.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(document_file!.openRead()));
      var length = await document_file!.length(); //imageFile is your image file
      var multipartFileSign = new http.MultipartFile('document', stream, length, filename: fileName);
      request.files.add(multipartFileSign);
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {"Accept": "application/json", "Authorization": sharedPreferences.getString("token").toString()}; // ignore this headers if there is no authentication
    request.headers.addAll(headers);
    request.fields['mode_type'] = "online";
    request.fields['property_id'] = widget.book_now_model!.form_property_model!.property_id;
    request.fields['amt'] =widget.book_now_model!.booking_amount.toString();
    request.fields['sel_pay_by'] = "pay_by_other";
    request.fields['oth_bank_name'] = bank_name.text.toString();
    request.fields['oth_date_pay'] = date.text.toString();
    request.fields['oth_type'] = online_transaction_type.text.toString();
    request.fields['oth_pay_mode'] = "";
    request.fields['oth_ut_num'] = utr_number.text.toString();
    return request;
  }




  submit_request(request) async {
    request.fields['full_name'] = widget.book_now_model!.customer_detail_model!.full_name.toString();
    request.fields['father_name'] = widget.book_now_model!.customer_detail_model!.father_name.toString();
    request.fields['gender'] = widget.book_now_model!.customer_detail_model!.gender_name.toString()=="Male"?"M":"F";
    request.fields['address'] = widget.book_now_model!.customer_detail_model!.address.toString();
    request.fields['d_o_b'] = widget.book_now_model!.customer_detail_model!.dob.toString();
    request.fields['city'] = widget.book_now_model!.customer_detail_model!.city_id.toString();
    request.fields['state'] = widget.book_now_model!.customer_detail_model!.state_id.toString();
    request.fields['pancard_details'] = widget.book_now_model!.customer_detail_model!.pan.toString();;
    request.fields['bank_loan_required'] = widget.book_now_model!.customer_detail_model!.funding_id.toString();
    request.fields['aadharcard_details'] = widget.book_now_model!.customer_detail_model!.aadhar.toString();
    request.fields['co_applicant_details'] = widget.book_now_model!.customer_detail_model!.co_name.toString();
    if(widget.book_now_model!.lead_id!=null){
      request.fields['lead_id'] = widget.book_now_model!.lead_id.toString();
    }
    if (widget.book_now_model!.form_property_model!.booking_option.toString() == "1") {


     List<String> selected_invetory = [];
     List<String> total_amount = [];

      List<Book_Now_all_Tower_Model>unit_no_list=[];
     List<Map>list=[];

      widget.book_now_model!.online_model!.unit_no_list.forEach((element) {
        if(element.is_checked){
          unit_no_list.add(element);
          selected_invetory.add(element.unit_id);
          element.extra_charges_details.forEach((element2) {
            list.add( new Extra_json(element2.amenity_id.toString(), element2.edit_qty.toString()).TojsonData());
          });
          total_amount.add(AppUtils().net_pay1(widget.book_now_model!.form_property_model!.view_property_model!.discount_value.toString(),widget.book_now_model!.form_property_model!.view_property_model!.discount_value.toString(),widget.book_now_model!.form_property_model!.view_property_model!.cashback_value.toString(),element.total_unit_price.toString(),element));
        }

      });
      request.fields['invid'] = selected_invetory.join(",");
      request.fields['total_amount'] = total_amount.join(",");
      request.fields['planid'] = widget.book_now_model!.online_model!.plan_id.toString();
      request.fields['milid'] = "0";
      request.fields['builderid'] =widget.book_now_model!.form_property_model!.BuilderId.toString();
      request.fields['form_type'] = "online";
      print(request.toString());
      request.fields['extra_charges'] = json.encode(list);
    }else{
      request.fields['form_type'] = "offline";
    }


    AppUtils().showProgressDialog(context);
    var response = await request.send();
    Navigator.of(context, rootNavigator: true).pop("Discard");
    response.stream.transform(utf8.decoder).listen((value) {
      print("response"+value.toString());

    });
    if (response.statusCode == 200) {
      AppUtils.toAst("Application Request Submit Successfully..!!",context);
      var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Thank_You_Booking()));

    } else {
      AppUtils.toAst("Connection Timeout!",context);
    }
  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("Book Now with cash/cheque", "Book Now with cash/cheque");

  }


}
