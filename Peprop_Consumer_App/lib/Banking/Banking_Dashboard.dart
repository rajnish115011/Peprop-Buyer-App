import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Banking/Account_Statement.dart';
import 'package:peprop_consumer_app/Banking/Add_Baneficiary.dart';
import 'package:peprop_consumer_app/Banking/Baneficiary_Tab.dart';
import 'package:peprop_consumer_app/Banking/Banking_Profile.dart';
import 'package:peprop_consumer_app/Banking/Mini_Statement.dart';
import 'package:peprop_consumer_app/Banking_OTP/Block_Account_OTP.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Dashboard_grid_model.dart';
import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';
import 'package:peprop_consumer_app/loan/Apply_Loan.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../Utils/AppUtils.dart';
import '../Utils/FireBase_Logs.dart';
import '../Utils/ServiceConfig.dart';
import '../bill_payment/Operator_List/Operator_List.dart';
import '../widgets/App_Banners.dart';
import 'Baneficiary_List.dart';


class Banking_Dashboard extends StatefulWidget {
  Home_List_Model? list;
  Home_Model? home_model;
  Banking_Dashboard(Home_List_Model? list, Home_Model? home_model){
    this.list=list;
    this.home_model=home_model;
  }

  @override
  State<StatefulWidget> createState() {
    return BuildWidget();
  }
}

class BuildWidget extends State <Banking_Dashboard>{
  double top_banner_space = 4;

  List<Dashboard_grid_model> menu_list = [];
  String _userId = "0";
  String _mobile = "0";
  String _accNo = "Rahul";
  bool _createAccount = false;
  String _accNumber = '';
  String _balance = '';
  String _accountName = '';
  String ifsc = '';

 bool is_balance_view=false;

  List<Dashboard_grid_model> quick_Access = [];


  @override
  void initState() {
    print("sliders"+widget.list!.sliders.length.toString());
    super.initState();
    _checkRegisteredUser();

    quick_Access.add(new Dashboard_grid_model("My Account & Profile",'assets/banking_icons/Profile_250.png',""));
    quick_Access.add(new Dashboard_grid_model("Loan Offer", 'assets/banking_icons/send money_250.png',""));
    quick_Access.add(new Dashboard_grid_model("Transfer Money", 'assets/banking_icons/Add Benificiary_250.png',""));

    menu_list.add(new Dashboard_grid_model("My Account & Profile",'assets/banking_icons/Profile_250.png',""));
    menu_list.add(new Dashboard_grid_model("Fund \nTransfer", 'assets/banking_icons/send money_250.png',""));
    menu_list.add(new Dashboard_grid_model("Add \nBeneficiary", 'assets/banking_icons/Add Benificiary_250.png',""));
    menu_list.add(new Dashboard_grid_model("Beneficiary \n List", 'assets/banking_icons/Benificiary List_250.png',""));
    menu_list.add(new Dashboard_grid_model("Account \nStatement", 'assets/banking_icons/Bank Statement_250.png',""));
    menu_list.add(new Dashboard_grid_model("Mini \nStatement", 'assets/banking_icons/Transcation_250.png',""));
    menu_list.add(new Dashboard_grid_model("Block \nAccount", 'assets/banking_icons/Transcation_250.png',""));

    _getAccountDetails();
  }

  Map<String, double> dataMap = {
    "Income": 0,
    "Expenses": 0,
  };

  final colorList = <Color>[
    Colors.green,
    Colors.red,
  ];

  _checkRegisteredUser() async {

    await  FireBase_Logs().log_screen_view("Banking Dashboard", "Banking Dashboard");

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('user_id')!;
      _mobile = prefs.getString('mobile')!;
      _accNo = prefs.getString('acc_no')!;
    });
  }

  _getAccountDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _mobile = prefs.getString('mobile')!;
      _accNo = prefs.getString('acc_no')!;
    });

    setState(() {
      _createAccount = true;
    });
    var _map = <String, String>{};
    _map['mobile'] = _mobile;
    _map['acc_no'] = _accNo;

    FormData customerData = FormData.fromMap(_map);
    print(_map);
    ServiceConfig().postApiBodyAuthJson(API.checkAccountBalance, customerData, context).then((value) async {
      Response response = value;
      print(response);
      if (response != null && response.statusCode == 200) {
        var status = response.data['success'] as bool;
        if (status) {
          setState(() {
            _createAccount = false;
          });
          _accNumber = response.data["data"]['account_no'];
          _balance = response.data["data"]['balance'];
          _accountName = response.data["data"]['name'];
           ifsc = response.data["data"]['ifsc'];


        } else {
          AppUtils.toAst("Account Not exist",context);

          setState(() {
            _createAccount = false;
          });
        }
      } else {
        setState(() {
          _createAccount = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppUtils.appBar(context, ""),
        body:
        new SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: new Column(
          children: [
            ///---------------------------OPTIONS-------------------------------------------->
            Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10)
              ),
              color: ColorFile.red_900,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),

                  ),


                ),
                child:
                Column(
                  children: [

                    new Container(
                      child: new Row(
                        children: [
                          Expanded(child: new Container(child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new SizedBox(height: 20,),
                              new Container(child: new Text("Virtual Account",style: Styles().styles_medium(14, ColorFile.white),),),
                              new SizedBox(height: 20,),
                              new Container(child: new Text(_accNo.toString(),style: Styles().styles_medium(14, ColorFile.white),),),
                              new SizedBox(height: 20,),

                            ],
                          ),)),
                         if(is_balance_view==false)InkWell(child: Card(
                            color: ColorFile.yellowdark,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20)),

                            child:
                            new Container(

                              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5)

                              ,child: new Text("View Balance",style: Styles().styles_regular(12, ColorFile.black),),),),onTap: (){
                           setState(() {
                             is_balance_view=true;
                           });
                         },),
                         if(is_balance_view==true)new Container(padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                         child:new Column(
                           children: [
                             new Text("Balance",style: Styles().styles_medium(14, ColorFile.white),),
                             new SizedBox(height: 5,),
                             new Text("₹"+_balance.toString(),style: Styles().styles_bold(16, ColorFile.white),),
                           ],
                         ))

                        ],
                      ),
                    ),

                    new Container(
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: new Container(child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              new Container(child: new Text("IFSC Code : "+ifsc.toString(),style: Styles().styles_medium(14, ColorFile.white),),),


                            ],
                          ),)),
                          InkWell(child: new Container(child: new Column(
                            children: [

                              new Text("View Details",style: Styles().styles_regular(13, ColorFile.white),),




                            ],
                          ),),onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Banking_Profile(_accNo)));

                          },)
                        ],
                      ),
                    )

                  ],
                ),
              ),),

            SizedBox(
              height: 10,
            ),

            Card(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),elevation: 1,margin: EdgeInsets.all(10),
                child:new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12, right: 8, left: 12, bottom: 12),
                      child: Text(
                        'Quick Access',
                        style: TextStyle(
                          fontFamily: 'bold',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    GridView.builder(
                      itemCount: quick_Access.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(5),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  quick_Access[index].path,
                                  scale: 8,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  quick_Access[index].name,
                                  style: TextStyle(fontFamily: 'regular', color: ColorFile.status_requested,fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            if(index==0){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Banking_Profile(_accNo)));

                            } if(index==1){
                              var response =await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Apply_Loan(null)));

                            }
                            if(index==2){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Baneficiary_Tab(_accNo,_accountName,true)));

                            }


                          },
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                      ),
                    ),

                  ],
                )



            ),

            SizedBox(
              height: 10,
            ),
            if(widget.list!=null&&widget.list!.sliders.length>0)App_Banners(widget.list!.sliders,context),
            SizedBox(
              height: 10,
            ),
            Card(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),elevation: 1,margin: EdgeInsets.all(10),
                child:new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12, right: 8, left: 12, bottom: 12),
                      child: Text(
                        'Banking',
                        style: TextStyle(
                          fontFamily: 'bold',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    GridView.builder(
                      itemCount: menu_list.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(5),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  menu_list[index].path,
                                  scale: 8,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  menu_list[index].name,
                                  style: TextStyle(fontFamily: 'regular', color: ColorFile.status_requested,fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            if(index==0){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Banking_Profile(_accNo)));
                            } if(index==1){
                              var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Baneficiary_Tab(_accNo,_accountName,true)));
                              if(response!=null){
                                _getAccountDetails();
                              }

                            }
                            if(index==2){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add_Baneficiary(_accNo)));
                            }
                            if(index==3){
                              var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Baneficiary_Tab(_accNo,_accountName,false)));

                            }
                            if(index==4){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Account_Statement(_accNo)));
                            }
                            if(index==5){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mini_Statement(_accNo)));
                            }if(index==6){
                              var data=await All_Bottom_Sheets().Confirmation_dialog("Block Account", "Are you sure, you want to block your Banking Account?", context);
                              if(data!=null&&data==true){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Block_Account_OTP(_accNo)));
                              }



                            }

                          },
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                      ),
                    ),

                  ],
                )



            ),

            SizedBox(
              height: 10,
            ),
            if(widget.home_model!=null&&widget.home_model!.list.length>0)Card(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),elevation: 1,margin: EdgeInsets.all(10),
                child:new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12, right: 8, left: 12, bottom: 12),
                      child: Text(
                        'Pay Bill',
                        style: TextStyle(
                          fontFamily: 'bold',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    GridView.builder(
                      itemCount: widget.home_model!.list.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(5),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Center(
                            child: Column(
                              children: [
                                Image.network(
                                  widget.home_model!.list[index].icon.toString(),
                                  height: 30,
                                  width: 30,

                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  widget.home_model!.list[index].alt.toString(),
                                  style: TextStyle(fontFamily: 'regular', color: ColorFile.status_requested,fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Operator_List( widget.home_model!.list[index])));

                          },
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                      ),
                    ),

                  ],
                )



            )

          ],
        ),));
  }
}
