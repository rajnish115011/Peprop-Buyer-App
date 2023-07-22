

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Enquiry/Broker_Properties_List.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Search/Search_View_Custom.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/My_Enquiry_BokerRM.dart';
import '../Lead_Detail_Tabs/Lead_Details.dart';


class Broker_RM_Tab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}

class Build_state extends State{
  bool loading=false;
  List<BrokerModelEn> brokerModelList = [];
  List<BrokerModelEn> all_list = [];



  String _mobileNumber="";

  final search_controller=TextEditingController();

  @override
  void initState() {

     _getCustomerEnquiryBrokerList();
     create_log();

    super.initState();
  }
  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View My Developer/Broker List", "View My Developer/Broker List");

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
             loading == true? Center(child: new CircularProgressIndicator()):
             all_list.length > 0?
               new Container(child: new Column(
                 children: [
                   Search_View_Custom(search_controller,on_search: (value){
                     onchanged(value.toString());

                   }),
                       Expanded(child:ListView.builder(
                       shrinkWrap: true,
                       physics: AlwaysScrollableScrollPhysics(),
                       itemCount: brokerModelList.length,
                       itemBuilder: (context, index) {
                         return InkWell(
                           child: My_Enquiry_BokerRM(brokerModelList[index]),
                           onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => Lead_Details(brokerModelList[index])));


                             // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Broker_Properties_Listes_List(brokerModelList[index])));
                           },
                         );
                       }),)
                 ],
               ),)


                :Center(
                 child: No_Data_Placeholder("Broker/Developer Not Found.")),

      ],
    );
  }

  Future<void> _getCustomerEnquiryBrokerList() async {


    final SharedPreferences prefNew = await SharedPreferences.getInstance();
    _mobileNumber = prefNew.getString('mobile')!;
    print(prefNew.getString('user_id')!);
    setState(() {
      loading = true;
    });
    var _map = <String, String>{};
    _map['mobile'] = _mobileNumber;

    FormData mobile = new FormData.fromMap(_map);
    print('mobile 6564$_mobileNumber');
    ServiceConfig().postApiBodyAuthJson(API.getCustomerEnqueriesBroker, mobile, context).then((value) {
      Response response = value;
      print('response broker/RM List$response');
      if (response != null && response.statusCode == 200) {
        var status = response.data["status"] as bool;
        if (status) {
          var notify = response.data["data"] as List;
          brokerModelList = notify.map<BrokerModelEn>((json) => BrokerModelEn.fromJson(json)).toList();
          all_list = notify.map<BrokerModelEn>((json) => BrokerModelEn.fromJson(json)).toList();

          setState(() {
            loading = false;
          });
        } else {

          setState(() {
            loading = false;
          });
        }
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }
  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        brokerModelList.clear();
        brokerModelList.addAll(all_list);
      });
    }else{
      brokerModelList.clear();
      all_list.forEach((element) {
        print(element.mobile.toString());
        if(element.name.toString().toLowerCase().contains(value.toString().toLowerCase())){
          brokerModelList.add(element);
        }else  if(element.broker_Profile_model!.mobile.toString().toLowerCase().contains(value.toString().toLowerCase())){
          print("flaf");
          brokerModelList.add(element);
        }
      });
      setState(() {

      });
    }
  }

}