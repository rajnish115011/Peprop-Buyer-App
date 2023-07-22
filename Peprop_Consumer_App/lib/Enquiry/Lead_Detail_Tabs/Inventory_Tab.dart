import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Site_Visit/Widget_Site_Visit.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:peprop_consumer_app/widgets/Widget_inventory.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/Broker_profile_Model.dart';
import '../../Models/RM_Inventory_Model.dart';
import '../../Requirements/Requirements_Descriptions.dart';
import '../../Site_Visit/My_Site_Visit_Model.dart';
import '../../Utils/AppUtils.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../Utils/ServiceConfig.dart';
import 'Inv_Cost_Model.dart';


class Inventory_Tab extends StatefulWidget {
  BrokerModelEn? brokerModelList;
  Inventory_Tab(BrokerModelEn? brokerModelList){
    this.brokerModelList=brokerModelList;
  }



  @override
  _MySiteVIsitsState createState() => _MySiteVIsitsState();
}

class _MySiteVIsitsState extends State<Inventory_Tab> {

  late String _mobile;
  bool _loading = true;
  List<RM_Inventory_Model> list = [];

  Broker_Profile_Model?broker_Profile_model;

  @override
  void initState() {
    super.initState();
    _getSiteVisits();
    create_log();
  }
  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View Shared Inventory List", "View Shared Inventory List");

  }

  _getSiteVisits() async {
    final prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString('user_id')!;
    setState(() {
      _mobile = prefs.getString('mobile')!;
    });
    var _map = <String, String>{};
    _map['mobile'] = _mobile;
    _map['user_id'] = user_id;
    _map['broker_id'] = widget.brokerModelList!.created_by.toString();
    print(json.encode(_map));
    FormData customerData = FormData.fromMap(_map);
    ServiceConfig().postApiBodyAuthJson(API.getCustomerRMrequirementData, customerData, context).then((value) async {
      Response response = value;
      setState(() {
        _loading=false;
      });
      if (response != null && response.statusCode == 200) {
        if(response.data["data"]!=null){
           var mapValue =response.data["data"] as List;
           list = mapValue.map<RM_Inventory_Model>((json) => RM_Inventory_Model.fromJson(json)).toList();


          // mapValue.forEach((key, value) {
          //   Inv_Cost_Model model=new Inv_Cost_Model();
          //   model.prop_id=key.toString();
          //   print(value.toString());
          //    var data = value as List;
          //    List<RM_Inventory_Model>l = data.map<RM_Inventory_Model>((json) => RM_Inventory_Model.fromJson(json)).toList();
          //
          //
          //    model.list=l;
          //    list.add(model);
          //
          // });


        }

        if(response.data["broker_details"]!=null){
          var PropertyLocation = response.data["broker_details"];
          broker_Profile_model = Broker_Profile_Model.fromJson(PropertyLocation);

        }


      }
    }).catchError((onError){
      AppUtils.toAst(onError.toString(),context);
      setState(() {
        _loading=false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        (_loading==true)?Center(
          child: AppUtils.progressBar(_loading),
        ): (list.isEmpty)?
        No_Data_Placeholder('No Inventory Shared..!!'):ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Widget_inventory(list[index],broker_Profile_model);
          },
        ),

      ],
    );

  }
}
