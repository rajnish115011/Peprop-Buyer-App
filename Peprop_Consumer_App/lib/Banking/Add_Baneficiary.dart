

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/Banking_OTP/Add_Beneficiary_inside_OTP.dart';
import 'package:peprop_consumer_app/Banking_OTP/Bank_List_Sheet.dart';
import 'package:peprop_consumer_app/Models/Account_Statement_Medels.dart';
import 'package:peprop_consumer_app/Models/Add_Baneficiary_Model.dart';
import 'package:peprop_consumer_app/Models/Bank_List_Model.dart';
import 'package:peprop_consumer_app/Search/Search_Ifsc.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Banking_OTP/Add_Beneficiary_Outside_OTP.dart';
import '../Color/ColorFile.dart';
import '../Global_connection/Global_connection.dart';
import '../Models/Inside_Model.dart';
import '../Utils/FireBase_Logs.dart';
import '../Utils/ServiceConfig.dart';
import '../wish_list/Styles.dart';

class Add_Baneficiary extends StatefulWidget{

  String acc_no="";
  Add_Baneficiary(String acc_no){
    this.acc_no=acc_no;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Add_Baneficiary>{

  bool _isLoading=false;
  DateTime start_date=DateTime.now();
  DateTime end_date=DateTime.now();
  List<Account_Statement_Medels>statement_list=[];
  bool inside=true;

  final accountname=TextEditingController();
  final _accountNumber=TextEditingController();
  final caccountNumber=TextEditingController();


  final bank_name=TextEditingController();
  final ifsc_code=TextEditingController();
  final branch=TextEditingController();
  final mobile_number=TextEditingController();
  final email=TextEditingController();
  String user_id="";
  String mobile="";
  String accNo="";
  bool loading=false;
  Inside_Model? inside_model;

  List<Bank_List_Model>bank_list=[];



  @override
  void initState() {

    checkRegisteredUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Scaffold(
      appBar: AppUtils.appBarTitle(context,"Add Beneficiary Account"),
      backgroundColor: ColorFile.white,
      body: Stack(
       children: [
         SingleChildScrollView(
           child: new Column(
             children: [
                Padding(
                 padding:
                 const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                 child: Container(
                   height: 75,
                   width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     boxShadow: const [
                       BoxShadow(
                         color: ColorFile.lightgray,
                         offset: Offset(0.0, 0.0),
                         blurRadius: 0.0,
                         spreadRadius: 0.0,
                       ),
                     ],
                   ), //BoxDecoration
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(
                             left: 15, right: 10, top: 15, bottom: 15.0),
                         child: SizedBox(
                           height: 50,
                           width: 50,
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(20.0),
                             child: Image.asset('assets/account.png'),
                           ),
                         ),
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Row(
                             children: [
                               Text(
                                 "Add Beneficiary Account",
                                 overflow: TextOverflow.ellipsis,
                                 maxLines: 1,
                                 style: const TextStyle(
                                     fontFamily: 'semi',
                                     fontSize: 15,
                                     color: Colors.black),
                               ),
                             ],
                           ),

                         ],
                       ),

                     ],
                   ),
                 ),

               ),
                _chooseBeneficiaryTypeWidget(),
                outside_widget()


             ],
           ),
         ),
         if(loading)Center(child: new CircularProgressIndicator(),)

       ],
     ),
      bottomNavigationBar:
      new InkWell(
        onTap: ()  async {
          if(inside==false){
            if(validate()){
              Add_Baneficiary_Model model=Add_Baneficiary_Model();
              model.account_name=accountname.text.toString();
              model.account_number=_accountNumber.text.toString();
              model.bank_name=bank_name.text.toString();
              model.ifsc_code=ifsc_code.text.toString();
              model.bank_name=bank_name.text.toString();
              model.mobile=mobile_number.text.toString();
              model.email=email.text.toString();
              model.branch=branch.text.toString();
              model.current_account_number=widget.acc_no.toString();
              model.user_mobile=mobile;
              model.user_account=accNo.toString();
              FocusScope.of(context).requestFocus(new FocusNode());
              var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add_Beneficiary_Outside_OTP(model)));
              if(response!=null){
                Navigator.pop(context);
              }




            }
          }

          else{
            if(validate1()){
              validate_account_number();




            }
          }


          },
        child: new Container(
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(5),
              color: ColorFile.app_color,
            ),
            margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
            height: 50,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Text("Add Beneficiary Account",style: new TextStyle(fontFamily: "medium",color: ColorFile.white,fontSize: 17),),
              ],
            )

        ),
      ),



    );
  }

  Widget outside_widget() {
    return
    new Container(
      padding: EdgeInsets.only(left: 10,right: 10,top: 20),
      child: Column(
        children: [


          new Container(
              child:new Row(
                children: [
                  Expanded(child: new Container(
                    child:new Text("Account Number",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                  )),


                ],
              )
          ),
          new SizedBox(height: 5,),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  style: const TextStyle(
                    letterSpacing: 2,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Account Number',
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                    contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                  keyboardType: TextInputType.text,
                  controller: _accountNumber,
                ),
              ),

            ],
          ),
          new SizedBox(height: 10,),



          new Container(
              child:new Row(
                children: [
                  Expanded(child: new Container(
                    child:new Text("Confirm Account Number",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                  )),


                ],
              )
          ),
          new SizedBox(height: 5,),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  style: const TextStyle(
                    letterSpacing: 2,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Confirm Account Number',
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                    contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                  keyboardType: TextInputType.text,
                  controller: caccountNumber,
                ),
              ),

            ],
          ),
          new SizedBox(height: 10,),



          if(inside==false) new Column(
            children: [
              new Container(
                  child:new Row(
                    children: [
                      Expanded(child: new Container(
                        child:new Text("Account Holder's Name",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                      )),


                    ],
                  )
              ),
              new SizedBox(height: 5,),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      style: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter Account Holder's Name",
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                        contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      keyboardType: TextInputType.text,
                      controller: accountname,
                    ),
                  ),

                ],
              ),
              new SizedBox(height: 10,),






              new Container(
                  child:new Row(
                    children: [
                      Expanded(child: new Container(
                        child:new Text("Bank Name",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                      )),


                    ],
                  )
              ),
              new SizedBox(height: 5,),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      onTap: (){
                        get_banks();
                      },
                      style: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Align(widthFactor: 1.0, heightFactor: 1.0, child:Image.asset("assets/dropdown.png",height: 15,)),

                        hintText: 'Select Bank Name',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                        contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      keyboardType: TextInputType.text,
                      controller: bank_name,
                    ),
                  ),

                ],
              ),
              new SizedBox(height: 10,),


              new Container(
                  child:new Row(
                    children: [
                      Expanded(child: new Container(
                        child:new Text("IFSC Code",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                      )),


                    ],
                  )
              ),
              new SizedBox(height: 5,),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        if(bank_name.text.length>0){
                          var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_Ifsc(bank_name.text.toString())));

                          if (pageResult != null) {
                            setState(() {
                              IFSC_Model model = pageResult;
                              ifsc_code.text=model.ifsc.toString();

                            });
                          }
                        }else{
                          AppUtils.toAst("Please Select Bank First..!!", context);
                        }

                      },
                      style: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Align(widthFactor: 1.0, heightFactor: 1.0, child:Image.asset("assets/dropdown.png",height: 15,)),

                        hintText: 'Select IFSC Code',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                        contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      keyboardType: TextInputType.text,
                      controller: ifsc_code,
                    ),
                  ),

                ],
              ),
              new SizedBox(height: 10,),





              new Container(
                  child:new Row(
                    children: [
                      Expanded(child: new Container(
                        child:new Text("Mobile Number",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                      )),


                    ],
                  )
              ),
              new SizedBox(height: 5,),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      style: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Mobile Number',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                        contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.number,
                      controller: mobile_number,
                    ),
                  ),

                ],
              ),
              new SizedBox(height: 10,),




              new Container(
                  child:new Row(
                    children: [
                      Expanded(child: new Container(
                        child:new Text("Email ID",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                      )),


                    ],
                  )
              ),
              new SizedBox(height: 5,),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      style: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                          hintText: 'Enter Email ID',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                          contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      keyboardType: TextInputType.text,
                      controller: email,
                    ),
                  ),

                ],
              ),
              new SizedBox(height: 10,),
            ],
          )


        ],
      ),
    );

  }

  void get_details() {



  }

  bool validate() {
    if(accountname.text.length==0){
      AppUtils.toAst("Pleas Enter Account Holder Name.!!",context);
      return false;
    }
    if(_accountNumber.text.length==0){
      AppUtils.toAst("Pleas Enter Account Number.!!",context);
      return false;
    }
    if(caccountNumber.text.length==0){
      AppUtils.toAst("Pleas Confirm Account Number.!!",context);
      return false;
    }if(caccountNumber.text.toString()!=_accountNumber.text.toString()){
      AppUtils.toAst("Confirm Account Number does't Matched.!!",context);
      return false;
    }

    if(bank_name.text.length==0){
      AppUtils.toAst("Pleas Enter Bank Name.!!",context);
      return false;
    }if(ifsc_code.text.length==0){
      AppUtils.toAst("Pleas Enter IFSC Code.!!",context);
      return false;
    }if(mobile_number.text.length<10){
      AppUtils.toAst("Pleas Enter Valid 10 Digit Mobile Number.!!",context);
      return false;
    }

    return true;
  }

  bool validate1() {

    if(_accountNumber.text.length==0){
      AppUtils.toAst("Pleas Enter Account Number.!!",context);
      return false;
    }
    if(caccountNumber.text.length==0){
      AppUtils.toAst("Pleas Confirm Account Number.!!",context);
      return false;
    }if(caccountNumber.text.toString()!=_accountNumber.text.toString()){
      AppUtils.toAst("Confirm Account Number does't Matched.!!",context);
      return false;
    }


    return true;
  }
  Widget _chooseBeneficiaryTypeWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 1.0, right: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child:InkWell(child:
            Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: ColorFile.status_requested,
                ),
                child:   new Row(
                  children: [
                    new SizedBox(width: 10,),
                    inside==true?Icon(Icons.check_box,color: ColorFile.white,):Icon(Icons.check_box_outline_blank,color: ColorFile.white,),
                    new SizedBox(width: 10,),
                    new Text("Inside\nPeProp.Money",style: Styles().styles_regular(10, ColorFile.white),)
                  ],
                )


            ),onTap: (){
              setState(() {
                inside=true;
              });
            },)

          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child:InkWell(child:
              Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: ColorFile.status_requested,
                  ),
                  child:   new Row(
                    children: [
                      new SizedBox(width: 10,),
                      inside==false?Icon(Icons.check_box,color: ColorFile.white,):Icon(Icons.check_box_outline_blank,color: ColorFile.white,),
                      new SizedBox(width: 10,),
                      new Text("Outside\nPeProp.Money",style: Styles().styles_regular(10, ColorFile.white),)
                    ],
                  )


              ),onTap: (){
                setState(() {
                  inside=false;
                });
              },)

          ),
        ],
      ),
    );
  }

  void validate_account_number() {
    setState(() {
      loading=true;
    });
    var map = <String, String>{};
    map['mobile'] = mobile;
    map['acc_no'] = accNo;
    map['b_acc_no'] = _accountNumber.text.toString();
    map['type'] = "1";
    FormData _accountNo = FormData.fromMap(map);
    print(map);
    ServiceConfig().postApiBodyAuthJson(API.benificeryAccountAdded, _accountNo, context).then((value) async {
      Response response = value;
      print(response);
      setState(() {
        loading=false;
      });
      if (response.statusCode == 200) {
        if(response.data["data"].toString()=="null"){
          AppUtils.toAst(response.data["message"].toString(),context);
        }else{
          var builder_details = response.data["data"];
          inside_model = Inside_Model.fromJson(builder_details);
          inside_model!.user_mobile=mobile;
          inside_model!.user_account=accNo;
          var res=await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add_Beneficiary_inside_OTP(inside_model)));
          if(res!=null){
          Navigator.pop(context);
          }
        }

      }
    }).catchError((onError){
      AppUtils.toAst(onError.toString(),context);
      setState(() {
        loading=false;
      });
    });


  }
  checkRegisteredUser() async {
    await FireBase_Logs().log_screen_view("Add Banefeciary", "Add Banefeciary");

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString('user_id')!;
      mobile = prefs.getString('mobile')!;
      accNo = prefs.getString('acc_no')!;
    });
  }

  Future<void> get_banks() async {
    setState(() {
      loading = true;

    });
    var response=await Global_connection().post_method(Map() ,context , API.bankList);
    print(response.toString());
    if(response!=null&&response.data!=null){
      var notify = response.data["data"] as List;
      bank_list =notify.map<Bank_List_Model>((json) => Bank_List_Model.fromJson(json)).toList();
      show_sheet();
    }



    setState(() {
      loading = false;

    });

  }

  void show_sheet() {
    showModalBottomSheet(
        constraints: BoxConstraints(
          maxHeight:MediaQuery.of(context).size.height-200, // here increase or decrease in width
        ),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        context: context,
        builder: (context) {
          return new Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
            ),
            child:
            Bank_List_Sheet(bank_list, bank_name.text.toString(),onSelectionChanged: (value){
              setState(() {
                bank_name.text=value.toString();
                ifsc_code.text="";
              });


            },),
          );
        });
  }
}