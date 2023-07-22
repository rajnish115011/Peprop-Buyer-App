import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/BankListModel.dart';
import 'package:peprop_consumer_app/Properties/View_Property_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/loan/Create_dynamic_widget_Campaign.dart';
import 'package:peprop_consumer_app/widgets/Generate_Grid.dart';
import 'package:peprop_consumer_app/widgets/numberToWords.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Global_connection/Global_connection.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../Utils/FireBase_Logs.dart';
import '../legal/Campain.dart';
import 'Bank_Offers_Loan.dart';
import 'Capaign_Model.dart';
import 'Loan_Model.dart';
import 'Loan_Sheet.dart';
import 'Tenure_Sheets.dart';

class Apply_Loan extends StatefulWidget {
  View_Property_Model? view_property_model;
  Apply_Loan(View_Property_Model? view_property_model){
    this.view_property_model=view_property_model;
  }

  @override
  State<Apply_Loan> createState() => _LoansMainState();
}

class _LoansMainState extends State<Apply_Loan> {

  bool loading=false;
  List<Capaign_Model>fields_List=[];
  List<BankListModel>bank_offers=[];


  List<Loan_Model>loan_type_list=[];
  bool update=false;

  String name="";
  String mobile="";
  String email="";




  @override
  void initState() {
    super.initState();
    get_campaign();
    get_bank_offers();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFile.status_requested,
      appBar: AppUtils.appBar(context, ''),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            if(loading)Center(child: new CircularProgressIndicator(),)else SingleChildScrollView(
              child: new Column(
                children: [
                  new SizedBox(height: 20,),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Let's find you \n",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'semi',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'the best loan',
                            style: TextStyle(color: Colors.orange)),
                        TextSpan(
                            text: ' deal!',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
                    itemCount: fields_List.length,
                    itemBuilder: (context, i) {
                      var controller=TextEditingController();


                      return Create_dynamic_widget_Campaign(fields_List[i],i,controller,
                          on_edit: (){
                        setState(() {

                        });
                      },loan_type: (index){
                            get_loan_type(index);

                        },loan_tenure: (index){
                            show_loan_tenure(index);

                          });
                    },
                  ),
                  InkWell(child:new Container(margin: EdgeInsets.only(left: 20,right: 20,top: 40),height: 60,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.yellowdark),child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Text("SUBMIT")
                    ],),),onTap: (){
                    if(validate()==true){
                      create_json_for_campaign();




                    }

                  },),
                  if(bank_offers.length>0)Bank_Offers_Loan(bank_offers),




                ],
              ),
            ),
            if(update)Center(child: new CircularProgressIndicator(),)




          ],
        )

      ),
    );

  }

  Future<void> get_campaign() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    name=sharedPreferences.getString("full_name").toString();
    mobile=sharedPreferences.getString("mobile").toString();
    email=sharedPreferences.getString("email").toString();
    await  FireBase_Logs().log_screen_view("Apply Loan Form", "Apply Loan Form");
    setState(() {
      loading = true;
    });
    var response=await Global_connection().get_method(context, API.campaignList+"6");
    print(response.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200){
      var notify = response.data["data"]["fields"] as List;
      fields_List = notify.map<Capaign_Model>((json) => Capaign_Model.fromJson(json)).toList();

      fields_List.forEach((element) {
        if(element.field_name=="Name"){
          element.enter_value=name.toString();
        } if(element.field_name=="Mobile"){
          element.enter_value=""+mobile.toString();
        } if(element.field_name=="Email"){
          element.enter_value=email.toString();
        }
      });


    }



    setState(() {
      loading = false;

    });
  }

  Future<void> get_bank_offers() async {
    var response=await Global_connection().post_method(new Map(),context, API.loanMapping);
    print(response.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200){
      var data = response.data['data'];
      bank_offers = data.map<BankListModel>((json) => BankListModel.fromJson(json)).toList();

    }
    setState(() {


    });

  }

  Future<void> get_loan_type(int index) async {
    setState(() {
      update=true;
    });

    var response=await Global_connection().get_method(context, API.getLoanTypeMaster);
    print(response.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200){
      var notify = response.data["data"] as List;
      loan_type_list = notify.map<Loan_Model>((json) => Loan_Model.fromJson(json)).toList();
      method_show(loan_type_list,index);
    }
    setState(() {
      update=false;


    });

  }


  void show_loan_tenure(int index) {

    showModalBottomSheet(
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
            Tenure_Sheets(Generate_Grid().generate_loan(), fields_List[index].enter_value.toString(),onSelectionChanged: (value){
              setState(() {
                fields_List[index].enter_value=value.toString();
              });


            },),
          );
        });

  }

  void method_show(List<Loan_Model> loan_type_list, int index) {
    showModalBottomSheet(
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
            Loan_Sheet(loan_type_list, fields_List[index].enter_value.toString(),onSelectionChanged: (value){
              setState(() {
                fields_List[index].enter_value=value.toString();
              });


            },),
          );
        });

  }

  bool validate() {
    for(int i=0;i<fields_List.length;i++){
      if(fields_List[i].enter_value.length==0){
        AppUtils.toAst("Please Select/Enter "+fields_List[i].field_name.toString(), context);
        return false;
        break;
      }else  if(fields_List[i].field_type.toString()=="mobile"&&fields_List[i].enter_value.length<10){
        AppUtils.toAst("Please Select/Enter Valid 10 digit Mobile Number", context);
        return false;
        break;
      }else  if(fields_List[i].field_type.toString().toLowerCase()=="email"&&AppUtils.isEmail(fields_List[i].enter_value.toString())==false){
        AppUtils.toAst("Please Select/Enter Valid Email Address", context);
        return false;
        break;
      }
    }




    return true;
  }

  Future<void> create_json_for_campaign() async {

    List<Map>list=[];
    fields_List.forEach((element) {
      list.add( new CarJson(element.campaign_label_id, element.enter_value).TojsonData());

    });

    Campain campain=new Campain("6", list);
    Map map=campain.TojsonData();
    print(json.encode(map));
    setState(() {
      update=true;
    });
    var response=await Global_connection().post_method(json.encode(map),context, API.campaignRegister);
    print(response.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200){
      var data=await All_Bottom_Sheets().Success_dialog("We have received your loan request. Our loan team will contact you shortly.", context);
      if(data!=null&&data==true){
        Navigator.pop(context);
      }
    }
    setState(() {
      update=false;
    });
  }

}