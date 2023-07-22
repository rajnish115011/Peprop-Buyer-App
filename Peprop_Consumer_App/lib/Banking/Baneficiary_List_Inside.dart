

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/BeneficiriesModel.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Color/ColorFile.dart';
import '../Utils/AppUtils.dart';
import '../Utils/FireBase_Logs.dart';
import 'Add_Baneficiary.dart';
import 'Fund_Transfer/Fund_Transfer.dart';

class Baneficiary_List_Inside extends StatefulWidget{

  String acc_no="";
  String accountName="";
  bool is_transfer=false;


  Baneficiary_List_Inside(String acc_no, String accountName, bool is_transfer){
    this.acc_no=acc_no;
    this.accountName=accountName;
    this.is_transfer=is_transfer;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Baneficiary_List_Inside>{

  bool _isLoading=false;
  DateTime start_date=DateTime.now();
  DateTime end_date=DateTime.now();
  List<BeneficiriesModel>beneficiary_list=[];

  @override
  void initState() {

    _getAccountDetails(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: [
        _isLoading==true?Center(child: new CircularProgressIndicator(),):new SingleChildScrollView(
          child:new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics:NeverScrollableScrollPhysics(),
                  itemCount: beneficiary_list.length,
                  itemBuilder: (context, index) {
                    return new InkWell(child: _beneficiariesListWidget(beneficiary_list[index]),onTap: () async {
                      if(widget.is_transfer==true){
                        var response=await Navigator.of(context).push(MaterialPageRoute( builder: (context) => Fund_Transfer(widget.acc_no,widget.accountName,beneficiary_list[index])));
                        if(response!=null){
                          Navigator.pop(context,"response");
                        }
                      }



                    },);




                  }),
              if(beneficiary_list.length==0)Center(child: No_Data_Placeholder_add("No Beneficiary Account Added..!!","Add Beneficiary",add: () async {
                var move=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add_Baneficiary(widget.acc_no)));
                _getAccountDetails(context);

              },),)



            ],
          ),

        ),
      ],
    );
  }
  _getAccountDetails(BuildContext context) async {
    await FireBase_Logs().log_screen_view("Add Banefeciary Inside", "Add Banefeciary Inside");

    beneficiary_list.clear();
    setState(() {
      _isLoading=true;
    });
    var map = new Map<String, dynamic>();
    map['acc_no'] = widget.acc_no;
    FormData formData = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.listBenifecery,formData, context).then((value) {
      Response response = value;
      print('resoponse  message $response');
      setState(() {
        _isLoading=false;
      });
      if (response != null && response.statusCode == 200) {
        print(response.data.toString());
        var notify = response.data["data"] as List;
        beneficiary_list = notify.map<BeneficiriesModel>((json) => BeneficiriesModel.fromJson(json)).toList();
         beneficiary_list = (beneficiary_list.where((i) => i.b_user_id != "outside".toString()).toList());


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

  Widget _beneficiariesListWidget(BeneficiriesModel beneficiryList) {
    return Padding(
      padding:

      const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
      child: Container(

        height: 75,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
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
                      beneficiryList.b_name.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontFamily: 'semi',
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${beneficiryList.b_bank_name}'.toUpperCase(),
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      beneficiryList.b_account_no.toString(),
                      style: const TextStyle(fontSize: 11, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

}