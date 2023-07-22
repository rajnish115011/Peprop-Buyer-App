import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Site_Visit/Widget_Site_Visit.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Requirements/Requirements_Descriptions.dart';
import '../../Site_Visit/My_Site_Visit_Model.dart';
import '../../Site_Visit/Reschedule_Site_Visit.dart';
import '../../Utils/AppUtils.dart';
import '../../Utils/ServiceConfig.dart';


class Site_Visit_Tab extends StatefulWidget {
  BrokerModelEn? brokerModelList;
  Site_Visit_Tab(BrokerModelEn? brokerModelList){
    this.brokerModelList=brokerModelList;
  }



  @override
  _MySiteVIsitsState createState() => _MySiteVIsitsState();
}

class _MySiteVIsitsState extends State<Site_Visit_Tab> {

  late String _mobile;
  bool _loading = true;
  List<My_Site_Visit_Model> _sitevisitModel = [];
  bool update = false;
  String user_id="";
  @override
  void initState() {
    super.initState();
    _getSiteVisits();
  }

  _getSiteVisits() async {
    final prefs = await SharedPreferences.getInstance();
     user_id = prefs.getString('user_id')!;
    setState(() {
      _mobile = prefs.getString('mobile')!;

    });
    var _map = <String, String>{};
    _map['mobile'] = _mobile;
    _map['user_id'] = user_id;
    _map['broker_id'] = widget.brokerModelList!.created_by.toString();
    print(json.encode(_map));
    FormData customerData = FormData.fromMap(_map);
    ServiceConfig().postApiBodyAuthJson(API.getCustomerRMSiteVisitDetail, customerData, context).then((value) async {
      Response response = value;
      print('response message Sitevisits$response');
      if (response != null && response.statusCode == 200) {
        bool status = response.data["status"];
        if (status) {
          var data = response.data["data"] as List;
          if (data.isEmpty) {
            setState(() {
              _loading = false;
            });
          } else {
            var data = response.data["data"] as List;
            _sitevisitModel = data.map<My_Site_Visit_Model>((json) => My_Site_Visit_Model.fromJson(json)).toList();
            setState(() {
              _loading = false;
            });
          }
        } else {
          setState(() {
            _loading = false;
          });
        }
      } else {
      }
      setState(() {
        _loading = false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        (_loading==true)?Center(
          child: AppUtils.progressBar(_loading),
        ): (_sitevisitModel.isEmpty)?
        No_Data_Placeholder('No Site Visit Found'):ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _sitevisitModel.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Widget_Site_Visit(_sitevisitModel[index],"",user_id,accept: (){
              acceptRejectSitevisits("1",index);


            },reject: (){
              acceptRejectSitevisits("2",index);

            },reschedule: () async {
              var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Reschedule_Site_Visit(_sitevisitModel[index],null,)));
              if(response!=null)
              {
                _getSiteVisits();

              }
            },);
          },
        ),
        if(update)Center(child: new CircularProgressIndicator(),)

      ],
    );

  }
  acceptRejectSitevisits(String status, int index) async {
    setState(() {
      update=true;
    });
    var _map = <String, String>{};
    _map['task_id'] = _sitevisitModel[index].taskId.toString();
    _map['status'] = status;


    try{
      Response response =await ServiceConfig().postApiBodyAuthJson(API.customersitevisitAcceptReject, _map, context);
      if (response != null && response.statusCode == 200) {
        _sitevisitModel[index].cus_status=status.toString();
      }

    }catch(e){
      print(e.toString());

    }
    setState(() {
      update=false;
    });



  }
}
