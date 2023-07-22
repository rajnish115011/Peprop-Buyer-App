


import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Enquiry/Lead_Detail_Tabs/All_Brokers.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';

import 'package:peprop_consumer_app/Models/BrokerPropertiesModel.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Properties/Properties_Detail.dart';
import '../../Search/Search_View_Custom.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/My_Enquiry_Projects.dart';

class My_Projects_Tab extends StatefulWidget{
  BrokerModelEn? brokerModelList;
  My_Projects_Tab(BrokerModelEn? brokerModelList){
    this.brokerModelList=brokerModelList;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_state();
  }

}
class Build_state extends State<My_Projects_Tab>{
  bool loading =false;
  List<BrokerPropertiesModel> propertyList = [];
  List<BrokerPropertiesModel> all_list = [];

  final search_controller=TextEditingController();

  @override
  void initState() {
    _getSuggestedProperties();
    create_log();
    super.initState();
  }
  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View My Project List", "View My Project List");

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [

        loading == true? Center(child: new CircularProgressIndicator()): all_list.length > 0?
        new Container(child: new Column(
          children: [
            Search_View_Project(search_controller,on_search: (value){
              onchanged(value.toString());

            }),
            Expanded(child:ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: propertyList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: My_Enquiry_Projects(propertyList[index],true,widget.brokerModelList),
                    onTap: () {
                      if(widget.brokerModelList==null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => All_Brokers(propertyList[index])));

                      }else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Properties_Detail(propertyList[index].iD.toString(),"false")));

                      }


                    },
                  );
                }),)
          ],
        ),)

        :Center(
            child: No_Data_Placeholder("Projects Not Found.")),



      ],
    ) ;
  }
  _getSuggestedProperties() async {
    SharedPreferences prefNew = await SharedPreferences.getInstance();
    String mobile = prefNew.getString('mobile')!;
    String userId = prefNew.getString('user_id')!;

    setState(() {
      loading = true;
    });
    var _map = new Map<String, String>();
    _map['mobile'] = mobile;
    _map['user_id'] = userId;
    _map['created_by'] = userId.toString();
    if(widget.brokerModelList!=null){
      _map['broker_id'] = widget.brokerModelList!.createdBy.toString();

    }
    FormData data = new FormData.fromMap(_map);
    print(_map.toString());
    ServiceConfig().postApiBodyAuthJson(API.getCustomerEnquiryCPbrokerProperty, data, context).then((value) {
      Response response = value;
      print('response properties$response');
      if (response != null && response.statusCode == 200) {
        var status = response.data["status"] as bool;

        if (status) {
          var notify = response.data["data"] as List;
          print('properties$notify');
          propertyList = notify.map<BrokerPropertiesModel>((json) => BrokerPropertiesModel.fromJson(json)).toList();
          all_list = notify.map<BrokerPropertiesModel>((json) => BrokerPropertiesModel.fromJson(json)).toList();

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
        propertyList.clear();
        propertyList.addAll(all_list);
      });
    }else{
      propertyList.clear();
      all_list.forEach((element) {
        if(element.propertyname!.toString().toLowerCase().contains(value.toString().toLowerCase())){
          propertyList.add(element);
        }
      });
      setState(() {

      });
    }
  }

}