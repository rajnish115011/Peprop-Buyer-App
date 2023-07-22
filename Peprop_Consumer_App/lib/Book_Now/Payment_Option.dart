


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Banking_OTP/Book_Now_OTP.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Book_Now_Model.dart';
import 'package:peprop_consumer_app/Book_Now/Form_Property_Model.dart';

import 'package:peprop_consumer_app/Book_Now/Other_Payment_Sheet.dart';
import 'package:peprop_consumer_app/Book_Now/Property_Image_Widget.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Customer_Detail_Model.dart';
import 'package:peprop_consumer_app/Models/Wallet_option_Model.dart';
import 'package:peprop_consumer_app/Terms_and_Conditions/Payment_Refund.dart';
import 'package:peprop_consumer_app/Terms_and_Conditions/Payment_tnc.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Global_connection/Global_connection.dart';
import '../Kyc/Banking_Steps.dart';
import '../Models/Tower_Model.dart';
import '../Payment_Gateway/Payment_Gateway.dart';
import '../Properties/Extra_json.dart';
import '../Thanks/Thank_You_Booking.dart';
import '../Utils/FireBase_Logs.dart';
import '../wish_list/Styles.dart';
import 'Book_now_Other/Other_Payment_Form_For_Book_Now.dart';

class Payment_Option extends StatefulWidget{
  int index=0;
  Book_Now_Model? book_now_model;
  Payment_Option(Book_Now_Model book_now_model){
    this.book_now_model=book_now_model;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }



}
class Build_State extends State<Payment_Option>{
  List<Wallet_option_Model>options=[];
  List<String>other_list=[];

  bool loading=false;
  
  int selected=0;
  final other_type=TextEditingController();
  bool is_checked=false;
  bool peprop_terms=false;


  List<String> selected_invetory = [];
  bool update=false;
  String disclaimer1="";
  String disclaimer2="";


  @override
  void initState()   {
    super.initState();
    options.add(new Wallet_option_Model("Pay by Credit/Debit Card/UPI",""));
    if(widget.book_now_model!.form_property_model!.view_property_model!.payment_option_mode.length>0){
      options.add(new Wallet_option_Model("Other",""));
    }

    create_log();

    get_desc();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Payment"),
      body: new Stack(
        children: [
         if(update==true)Center(child: new CircularProgressIndicator(),)

         else
         new SingleChildScrollView(
            child: new Column(
              children: [
                Property_Image_Widget(widget.book_now_model!.form_property_model!.image,widget.book_now_model!.form_property_model!.rera,widget.book_now_model!.form_property_model!.logo),
                if(widget.book_now_model!.form_property_model!.view_property_model!.booking_partner_name!="")new Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new SizedBox(height: 10,),
                      new Container(alignment: Alignment.centerLeft,child: new Text(widget.book_now_model!.form_property_model!.property_title,style: new TextStyle(fontSize: 16,fontFamily: "bold",color: ColorFile.black)),),
                      new SizedBox(height: 5,),
                      new Container(alignment: Alignment.centerLeft,child: new Text(widget.book_now_model!.form_property_model!.addess,style: new TextStyle(fontSize: 13,fontFamily: "medium",color: ColorFile.black)),),
                      new SizedBox(height: 20,),
                    ],
                  ),
                ),

                new Container(
                  margin: const EdgeInsets.all(10),
                  child:new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        padding: const EdgeInsets.all(10),
                        decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.bgs),
                        child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new SizedBox(height: 30,),
                          new Container(child:new Text("Disclaimer",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),),
                          new SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              disclaimer1.toString(),style: new TextStyle(color: ColorFile.black,fontSize: 13,fontFamily: "regular"),

                            ),
                          ),
                        ],
                      ),),





                    ],
                  ),


                ),
                Padding(padding: EdgeInsets.all(10),child:  new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(


                      child:new Row(children: [
                      Expanded(child: new Container(child:new Text("Booking Partner Details",style: new TextStyle(fontFamily: "bold",color: ColorFile.black,fontSize: 18),textAlign: TextAlign.start,),)),


                    ],) ,),
                    new Container(
                        decoration: new BoxDecoration(border: new Border.all(color: ColorFile.black,width: 1)),
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        child:new Column(
                          children: [



                            new Container(child:     new Row(children: [
                              new Container(child:new Text("Company Name : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                              Expanded(child: new Container(child:new Text(widget.book_now_model!.form_property_model!.view_property_model!.comp_name.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                            ],) ,),
                            new SizedBox(height: 5,),
                            new Container(child:     new Row(children: [

                              new Container(child:new Text("Name : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                              Expanded(child: new Container(child:new Text(widget.book_now_model!.form_property_model!.view_property_model!.booking_partner_name.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                            ],) ,),
                            new SizedBox(height: 5,),

                            new Container(child:     new Row(children: [

                              new Container(child:new Text("Mobile : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                              Expanded(child: new Container(child:new Text("+91"+widget.book_now_model!.form_property_model!.view_property_model!.booking_partner_mobile.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                            ],) ,),

                            new SizedBox(height: 5,),

                            new Container(child:     new Row(children: [

                              new Container(child:new Text("Email : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                              Expanded(child: new Container(child:new Text(widget.book_now_model!.form_property_model!.view_property_model!.booking_partner_email.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                            ],) ,),
                            new SizedBox(height: 5,),

                            new Container(child:     new Row(children: [
                              new Container(child:new Text("RERA : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                              Expanded(child: new Container(child:new Text(widget.book_now_model!.form_property_model!.view_property_model!.booking_partner_rera.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                            ],) ,),




                          ],
                        )




                    ),


                  ],
                ),),
                new Container(
                  margin: const EdgeInsets.all(10),
                  child:new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        padding: const EdgeInsets.all(10),
                        decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.bgs),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new SizedBox(height: 30,),
                            new Container(child:new Text("Disclaimer",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),),
                            new SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ReadMoreText(
                                disclaimer2.toString(),
                                trimLines: 2,
                                style: new TextStyle(color: ColorFile.black,fontSize: 13,fontFamily: "regular"),
                                colorClickableText: ColorFile.app_color,
                                trimMode: TrimMode.Line,
                                moreStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                                lessStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                                trimCollapsedText: '...Read More',
                                trimExpandedText: '..show less',
                              ),
                            ),
                          ],
                        ),),





                    ],
                  ),


                ),
                Card(
                  margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          new SizedBox(height: 10,),
                          new Container(child:new Row(
                          children: [
                            Expanded(child: new Container(child:new Text("Platform Subscription Charges:",style: new TextStyle(fontFamily: "bold",fontSize: 12,color: ColorFile.selectd_color),),)),
                            Expanded(child: new Container(
                              child:new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      new Container(child:new Text("₹"+widget.book_now_model!.booking_amount,style: new TextStyle(fontFamily: "bold",fontSize: 16,color: ColorFile.selectd_color))),
                                    ],
                                  ),
                                  InkWell(child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      new Container(child:new Text(widget.book_now_model!.form_property_model!.view_property_model!.refundable.toString()=="1"?"(Refundable)":"(Non-Refundable)",style: new TextStyle(fontFamily: "medium",fontSize: 14,color: ColorFile.yellowdark))),
                                    ],
                                  ),onTap: (){
                                    if(widget.book_now_model!.form_property_model!.view_property_model!.refundable.toString()=="1"){
                                      policy(context,Styles.stripHtmlIfNeeded(widget.book_now_model!.form_property_model!.view_property_model!.Ref_term_condn.toString()) );

                                    }

                                  },)

                                ],
                              )

                            ))


                          ],
                        )


                        ),


                        new SizedBox(height: 10,),

                      ],),

                  ),
                ),






                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return new InkWell(child:
                    Container(
                          height: 60,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(5),
                              border: new Border.all(width: 1,color:selected==index?ColorFile.yellowdark: ColorFile.lightgray),
                              color: ColorFile.white
                          ),


                          alignment: Alignment.center,
                          child:new Row(
                            children: [
                              selected!=index?Icon(Icons.radio_button_off):Icon(Icons.radio_button_checked,color: ColorFile.yellowdark,),
                              new SizedBox(width: 10,),
                              Expanded(child: new Container(child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Container(child: new Text(options[index].title,style: new TextStyle(fontFamily: "medium",fontSize: 12),),),
                                ],
                              ),)),

                            ],
                          )
                      ),onTap: (){
                        setState(() {
                          selected=index;
                        });
                      },);
                  },
                ),
                if(widget.book_now_model!.form_property_model!.view_property_model!.refundable.toString()=="1")
                  new Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      child:  new Row(
                    children: [

                      new SizedBox(width: 10,),
                      new InkWell(child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          is_checked==true?Icon(Icons.check_box,color: ColorFile.app_color,):Icon(Icons.check_box_outline_blank),
                          new SizedBox(width: 10,),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Container(child:new Text("(Refundable / Valid for: "+widget.book_now_model!.form_property_model!.view_property_model!.refundable_duration.toString()+" days * )",style: new TextStyle(fontFamily: "regular",fontSize: 10,color: ColorFile.selectd_color),)),
                              new Container(child:new Text("I accept the refund policy",style: new TextStyle(fontFamily: "medium",fontSize: 12,color: ColorFile.app_color,decoration: TextDecoration.underline),))

                            ],
                          )
                        ],
                      ),onTap: () async {
                        var nav=await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Payment_Refund(is_checked,Styles.stripHtmlIfNeeded(widget.book_now_model!.form_property_model!.view_property_model!.Ref_term_condn.toString()) )));


                        if(nav!=null){
                          setState(() {
                            is_checked=nav;
                          });


                        }




                      },)
                    ],
                  )),





                  new Container(child:  new Row(
                  children: [

                    new SizedBox(width: 10,),
                    new InkWell(child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        peprop_terms==true?Icon(Icons.check_box,color: ColorFile.app_color,):Icon(Icons.check_box_outline_blank),
                        new SizedBox(width: 10,),
                        new Container(child:new Text("I accept Terms & Conditions of Peprop.Money",style: new TextStyle(fontFamily: "medium",fontSize: 12,color: ColorFile.app_color,decoration: TextDecoration.underline),))

                      ],
                    ),onTap: () async {
                     var nav=await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Payment_tnc(peprop_terms)));


                     if(nav!=null){
                       setState(() {
                         peprop_terms=nav;
                       });


                     }




                    },)
                  ],
                ))


              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: new Container(
         padding: EdgeInsets.all(10),
         color: ColorFile.white,
         height: 100,
          child: new Row(
          children: [
            Expanded(child: new Container(child:new Text("₹ "+widget.book_now_model!.booking_amount,style: new TextStyle(fontFamily: "bold",fontSize: 18,color: ColorFile.selectd_color),),)),
            InkWell(onTap: () async {
              if(validate()){
                if(selected==0){
                  online_payment();
                  }else{
                  var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Other_Payment_Form_For_Book_Now(widget.book_now_model)));



                  }



              }







            },child: new Container(alignment: Alignment.center,height: 45,padding: EdgeInsets.only(left: 15,right: 15),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.yellowdark),child: new Text("Continue",style: new TextStyle(fontFamily: "medium",color: ColorFile.black,fontSize: 15),),),)


          ],
        ),
      ),
    );
  }

  void method_show() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Other_Payment_Sheet(
              other_list,
              other_type.text.toString(),
              onSelectionChanged: (value) {
                if (value != null) {
                  setState(() {
                    other_type.text = other_list[value].toString();
                   
                  });
                }
              },
            ),
          );
        });
  }

  //
  online_payment() async {
    AppUtils().showProgressDialog(context);
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
    String order_id="ORD-"+prefNew.getString("user_id").toString()+"-"+new DateTime.now().millisecondsSinceEpoch.toString();
    var map = new Map<String, dynamic>();
    map['order_id'] =order_id;
    map['order_amount'] =widget.book_now_model!.booking_amount.toString();
    FormData formData = new FormData.fromMap(map);
    print(json.encode(map));
    var response=await Global_connection().post_method(formData, context, API.createToken);
    print(response.toString());
    Navigator.of(context, rootNavigator: true).pop("Discard");
    if(response!=null&&response.data!=null&& response.statusCode == 200){
      String token=response.data["cftoken"];
      String stage=response.data["stage"];
      String your_app_id=response.data["your_app_id"];
      do_payment(token,stage,your_app_id,order_id);
    }



  }

  Future<void> do_payment(String token, String stage1, String your_app_id, String order_id) async {
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
    String stage = stage1;
    String orderId = order_id;
    String orderAmount =widget.book_now_model!.booking_amount.toString();
    String customerName =  widget.book_now_model!.customer_detail_model!.full_name.toString();
    String orderNote = "Notes";
    String orderCurrency = "INR";
    String appId = your_app_id.toString();
    String customerPhone = prefNew.getString("mobile").toString();
    String customerEmail = prefNew.getString("email").toString();
    String notifyUrl = "https://app.peprop.money/apis/cashfree/index";
    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData":token,
      "notifyUrl": notifyUrl,
      "color1":"#2148C0",
      "color2": "#ffffff",
    };
    print(json.encode(inputParams));
    CashfreePGSDK.doPayment(inputParams).then((value) {
      print("success_respo"+value.toString());
      String txStatus=value!["txStatus"];
      if(txStatus=="SUCCESS"){
        String referenceId=value["referenceId"];
         save_history(orderId);

      }else{
        AppUtils.toAst("Payment Declined..!!",context);
      }
    }).catchError((onError){
      AppUtils.toAst("Payment Declined..!!",context);

    });
  }


  policy(BuildContext context, String message) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'Policy',
              style: new TextStyle(fontFamily: "medium", fontSize: 15),
            ),
            content: Text(
              message.toString(),
              style: new TextStyle(fontFamily: "regular", fontSize: 12,),
              textAlign: TextAlign.justify,
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop("Discard");

                },
                child:new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text('Close',style: new TextStyle(fontFamily: "medium", fontSize: 25),
                    ),
                  ],
                ),

                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  bool validate() {
    if(widget.book_now_model!.form_property_model!.view_property_model!.refundable.toString()=="1"){
      if(is_checked==false){
        AppUtils.toAst("Please View & Accept the Refund Policy.",context);
        return false;
      } if(peprop_terms==false){
        AppUtils.toAst("Please Accept Terms & Conditions.",context);
        return false;
      }

    }

    return true;
  }

  Future<void> save_history(String referenceId) async {
    AppUtils().showProgressDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var map = new Map<String, dynamic>();
    map['full_name'] = widget.book_now_model!.customer_detail_model!.full_name.toString();
    map['father_name'] = widget.book_now_model!.customer_detail_model!.father_name.toString();
    map['gender'] = widget.book_now_model!.customer_detail_model!.gender_name.toString() == "Male" ? "M" : "F";
    map['address'] = widget.book_now_model!.customer_detail_model!.address.toString();
    map['d_o_b'] = widget.book_now_model!.customer_detail_model!.dob.toString();
    map['city'] = widget.book_now_model!.customer_detail_model!.city_id.toString();
    map['state'] = widget.book_now_model!.customer_detail_model!.state_id.toString();
    map['pancard_details'] = widget.book_now_model!.customer_detail_model!.pan.toString();
    map['bank_loan_required'] = widget.book_now_model!.customer_detail_model!.funding_id.toString();
    map['aadharcard_details'] = widget.book_now_model!.customer_detail_model!.aadhar.toString();
    map['co_applicant_details'] = widget.book_now_model!.customer_detail_model!.co_name.toString();
    map['trans_id'] = referenceId;
    map['amount'] =widget.book_now_model!.booking_amount.toString();
    map['mobile'] = sharedPreferences.getString("mobile").toString();
    map['user_id'] = sharedPreferences.getString("user_id").toString();
    if (widget.book_now_model!.form_property_model!.booking_option.toString() =="1") {
      map['b_user_id'] =widget.book_now_model!.form_property_model!.BuilderId;
      map['prop_id'] =widget.book_now_model!.form_property_model!.property_id;
      map['invid'] = selected_invetory.join(",");
      map['planid'] =widget.book_now_model!.online_model!.plan_id.toString();
      map['milid'] ="0";
      map['form_type'] = "online";
      List<Map>list=[];



      widget.book_now_model!.online_model!.unit_no_list.forEach((element) {
        if(element.is_checked){
          element.extra_charges_details.forEach((element2) {
            list.add( new Extra_json(element2.amenity_id.toString(), element2.edit_qty.toString()).TojsonData());


          });
        }

      });



      map['extra_charges'] =  json.encode(list);
    } else {
      map['form_type'] = "offline";
    }
    print(json.encode(map));

    FormData formData = new FormData.fromMap(map);
    print(API.walletTransaction);
    Response response = await ServiceConfig().postApiBodyAuthJson(API.walletTransaction1, formData, context);

    Navigator.of(context, rootNavigator: true).pop("Discard");
    if (response.data != null && response.statusCode == 200) {
      var response = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Thank_You_Booking()));
    }
  }

  Future<void> create_log() async {
    selected_invetory = [];
    List<Book_Now_all_Tower_Model>unit_no_list=[];
    widget.book_now_model!.online_model!.unit_no_list.forEach((element) {
      if(element.is_checked){
        unit_no_list.add(element);
        selected_invetory.add(element.unit_id);

      }

    });

    var amt=double.parse(widget.book_now_model!.form_property_model!.booking_max_amount)*unit_no_list.length;
    widget.book_now_model!.booking_amount=amt.toString();
    await FireBase_Logs().log_screen_view("Booking Payment Options", "Booking Payment Options");

  }

  Future<void> get_desc() async {
    setState(() {
      update=true;
    });
    Response response=await ServiceConfig().postApiBodyAuthJson(API.tnc, new Map(), context);

    if(response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      disclaimer1=response.data["data"]["disclaimer1"].toString();
      disclaimer2=response.data["data"]["disclaimer2"].toString();
    }

    setState(() {
      update=false;
    });


  }



}