import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Color/ColorFile.dart';
import '../Utils/FireBase_Logs.dart';

class Banking_Profile extends StatefulWidget {
  String acc_no="";
  Banking_Profile(String acc_no){
    this.acc_no=acc_no;
  }



  @override
  _MyAccountProfileState createState() => _MyAccountProfileState();
}

class _MyAccountProfileState extends State<Banking_Profile> {
  String _name = "";
  String _ifscCode = "";
  String _accountNumber = "";
  String _currency = "";
  String _amount = "";
  String mobile = "";
  bool _isLoading = true;

  @override
  void initState() {
    _getAccountDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: false,
      right: true,
      bottom: true,
      child: Scaffold(
        appBar:AppUtils.appBar(context, ""),
        body: new Stack(
          children: [
            (_isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0,top: 15.0),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorFile.addBeneficiryColorDark,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new SizedBox(width: 10,),
                                Image.asset(
                                  "assets/account.png",
                                  height: 50,
                                  width: 50,
                                ),
                                new SizedBox(width: 10,),
                                Text(
                                  'My Account & Profile',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ColorFile.white,
                                      fontFamily: 'semi'),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 35),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                 Text('Account Name:-',
                                      style: TextStyle(
                                      fontSize: 14,color: Colors.black,  fontFamily: 'bold',
                                    ),),
                                  Expanded(
                                    child: Text(
                                      '$_name',
                                      overflow: TextOverflow.clip,
                                      maxLines: 13,
                                      style: TextStyle(
                                          fontFamily: 'semi',
                                          fontSize: 13,
                                          color: ColorFile.black),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text('Mobile:-',
                                    style: TextStyle(
                                      fontSize: 14,color: Colors.black,  fontFamily: 'bold',
                                    ),),
                                  Expanded(
                                    child: Text(
                                      '$mobile',
                                      overflow: TextOverflow.clip,
                                      maxLines: 13,
                                      style: TextStyle(
                                          fontFamily: 'semi',
                                          fontSize: 13,
                                          color: ColorFile.black),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text('Available Balance :- ',style: TextStyle(
                                    fontSize: 14,color: Colors.black,  fontFamily: 'bold',
                                  ),),
                                  Text(
                                    '₹$_amount',
                                    style: TextStyle(
                                        fontFamily: 'semi',
                                        fontSize: 15,
                                        fontStyle: FontStyle.normal,
                                        color: ColorFile.black),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text('Account Number :- ',style: TextStyle(
                                    fontSize: 14,color: Colors.black,  fontFamily: 'bold',
                                  ),),
                                  Text(
                                    '$_accountNumber',
                                    style: TextStyle(
                                        fontFamily: 'semi',
                                        fontSize: 13,
                                        color: ColorFile.black),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text('IFSC Code :- ',style: TextStyle(
                                    fontSize: 14,color: Colors.black,  fontFamily: 'bold',
                                  ),),
                                  Text(
                                    '$_ifscCode',
                                    style: TextStyle(
                                        fontFamily: 'semi',
                                        fontSize: 13,
                                        color: ColorFile.black),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  _getAccountDetails(BuildContext context) async {
    await FireBase_Logs().log_screen_view("Banking Profile", "Banking Profile");

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['mobile'] = sharedPreferences.getString("mobile").toString();
    map['acc_no'] = widget.acc_no;

    FormData formData = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.checkAccountBalance,formData, context).then((value) {
      Response response = value;
      print('resoponse  message $response');
      if (response != null && response.statusCode == 200) {
        bool status = response.data["success"] as bool;
        if (status) {
          setState(() {

            _name = response.data["data"]["name"].toString();
            _ifscCode = response.data["data"]["ifsc"].toString();
            _accountNumber = response.data["data"]["account_no"].toString();
            _amount = response.data["data"]["balance"].toString();
             mobile= response.data["data"]["mobile"].toString();
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((error, stackTrace) async {
      AppUtils.toAst("Something Went Wrong..!!",context);
      setState(() {
        _isLoading=false;
      });

    });
  }

}