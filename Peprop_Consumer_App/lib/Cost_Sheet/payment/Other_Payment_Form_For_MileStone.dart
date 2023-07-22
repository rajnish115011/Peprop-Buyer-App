import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert' show json, utf8;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Book_Now_Model.dart';
import 'package:peprop_consumer_app/Book_Now/Other_Payment_Sheet.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:peprop_consumer_app/Cost_Sheet/Pay_Milestone_Model.dart';
import 'package:peprop_consumer_app/Cost_Sheet/model/Builder_Detail_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Thanks/Thank_You_Booking.dart';
class Other_Payment_Form_For_MileStone extends StatefulWidget{

  Pay_Milestone_Model? model;
  Other_Payment_Form_For_MileStone(Pay_Milestone_Model? model){
    this.model=model;
  }




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }

}
class Build_State extends State<Other_Payment_Form_For_MileStone> {


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
  final online_transaction_type = TextEditingController();


  XFile? document_file;


  List<String>other_list = [];

  List<String>transaction_type_list = [];


  var selectedDate = DateTime.now();
  bool loading=false;

  @override
  void initState() {
    super.initState();


    other_list.add("Cheque");
    other_list.add("Online Banking Details");
    other_list.add("Cash Receipt");


    transaction_type_list.add("RTGS");
    transaction_type_list.add("NEFT");
    transaction_type_list.add("IMPS");


    payment_type.text = "Cheque";
  }

  @override
  Widget build(BuildContext context) {
    amount.text =widget.model!.mileStone!.BasicInstallment.toString();
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
                      new Text("Payment Mode", style: new TextStyle(
                        fontFamily: "medium", fontSize: 16,),),
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


                if(payment_type.text.toString() == "Cheque")cheq(),
                if(payment_type.text.toString() == "Cash Receipt")cash_widget(),
                if(payment_type.text.toString() == "Online Banking Details")online_widget(),

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
                if (payment_type.text.toString() == "Cheque") {
                  if (validate_cheq()) {
                    var request = await generate_checq();
                    submit_request(request);
                  }
                }
                if (payment_type.text.toString() == "Online Banking Details") {
                  if (validate_online()) {
                    var request =await generate_online_request();
                    submit_request(request);
                  }
                }
                if (payment_type.text.toString() == "Cash Receipt") {
                  if (validate_cash()) {
                    var request =await generate_Cash_request();
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
      AppUtils.toAst("Please Enter Cheque Number..!!",context);
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
              new Text("Cheque Number", style: new TextStyle(
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
                          decoration: AppUtils.dec("Cheque Number")
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
            child: Other_Payment_Sheet(
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
    var uri = Uri.parse(API.savePayNowFormData);
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
    print( sharedPreferences.getString("token").toString());
    request.headers.addAll(headers);
    request.fields['id'] = widget.model!.id.toString();
    request.fields['invid'] =  widget.model!.invid.toString();
    request.fields['planid'] = widget.model!.planid.toString();
    request.fields['milid'] =  widget.model!.mileStone!.id.toString();
    request.fields['builderid'] =widget.model!.builderid.toString();
    request.fields['amt'] =widget.model!.mileStone!.BasicInstallment.toString();
    request.fields['sel_pay_by'] = "pay_by_other";
    request.fields['mode_type'] = "cheque";
    request.fields['chq_number'] = cheque_number.text.toString();
    request.fields['chq_issue_date'] = date.text.toString();
    request.fields['chq_bank_name'] = bank_name.text.toString();
    request.fields['chq_ac_number'] = account_number.text.toString();
    request.fields['bank_holder_name'] = account_holder_name.text.toString();
    return request;
  }

     generate_Cash_request() async {
     var uri = Uri.parse(API.savePayNowFormData);
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
    request.fields['id'] = widget.model!.id.toString();
    request.fields['invid'] =  widget.model!.invid.toString();
    request.fields['planid'] = widget.model!.planid.toString();
    request.fields['milid'] =  widget.model!.mileStone!.id.toString();
    request.fields['builderid'] =widget.model!.builderid.toString();
    request.fields['amt'] =widget.model!.mileStone!.BasicInstallment.toString();
    request.fields['sel_pay_by'] = "pay_by_other";
    request.fields['mode_type'] = "cash";
    request.fields['csh_recpt'] = reciept_number.text.toString();
    request.fields['csh_date'] = date.text.toString();
    return request;
  }

  generate_online_request() async {
    var uri = Uri.parse(API.savePayNowFormData);
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

    request.fields['id'] = widget.model!.id.toString();
    request.fields['invid'] =  widget.model!.invid.toString();
    request.fields['planid'] = widget.model!.planid.toString();
    request.fields['milid'] =  widget.model!.mileStone!.id.toString();
    request.fields['builderid'] =widget.model!.builderid.toString();
    request.fields['amt'] =widget.model!.mileStone!.BasicInstallment.toString();
    request.fields['sel_pay_by'] = "pay_by_other";


    request.fields['mode_type'] = "online";
    request.fields['oth_bank_name'] = bank_name.text.toString();
    request.fields['oth_date_pay'] = date.text.toString();
    request.fields['oth_type'] = online_transaction_type.text.toString();
    request.fields['oth_pay_mode'] = "";
    request.fields['oth_ut_num'] = utr_number.text.toString();


    return request;
  }




  submit_request(request) async {


    print(json.encode(request.fields));
    AppUtils().showProgressDialog(context);
    var response = await request.send();
    Navigator.of(context, rootNavigator: true).pop("Discard");
    response.stream.transform(utf8.decoder).listen((value) {
      print(value.toString());

    });
    if (response.statusCode == 200) {
      AppUtils.toAst("Application Request Submit Successfully..!!",context);
      var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Thank_You_Booking()));

    } else {
      AppUtils.toAst("Connection Timeout!",context);
    }
  }


}
