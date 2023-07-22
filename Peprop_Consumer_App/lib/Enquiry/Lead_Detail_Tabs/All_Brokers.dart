import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/All_Brokers_Model.dart';
import 'package:peprop_consumer_app/Models/BrokerPropertiesModel.dart';
import 'package:peprop_consumer_app/Models/loan_model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Global_connection/Global_connection.dart';
import '../../Models/BrokerModelEn.dart';
import '../../Properties/View_Property_Model.dart';
import '../../Search/Search_View_Custom.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/Widget_Detail_Page_Image_Logo.dart';
import '../../widgets/Widget_all_broker.dart';
import 'Lead_Details.dart';


class All_Brokers extends StatefulWidget {
  late BrokerPropertiesModel propertyList;
  All_Brokers(BrokerPropertiesModel propertyList){
    this.propertyList=propertyList;
  }



  @override
  _LoanScreenState createState() => _LoanScreenState();

}

class _LoanScreenState extends State<All_Brokers> {
  bool viewVisible = false;
  bool loading = false;
  List<All_Brokers_Model> brokers = [];
  List<All_Brokers_Model> all_brokers = [];
  final search_controller=TextEditingController();
  View_Property_Model1 ?view_property_model;
  @override
  void initState() {
    get_all_pbrokers();
    create_log();
    super.initState();
  }
  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View All Developer/Broker List", "View All Developer/Broker List");

  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBar(context, 'Loan'),
      body: Stack(
        children: [
          loading == true? Center(child: new CircularProgressIndicator()): all_brokers.length > 0?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

            child: new Container(child: new Column(
              children: [
                Search_View_Custom(search_controller,on_search: (value){
                  onchanged(value.toString());

                }),
                new SizedBox(height: 10,),
                Widget_Detail_Page_Image_Logo1(view_property_model!.FeatureImageUrl.toString(),view_property_model!.Rera.toString(),view_property_model!.gallery_list,view_property_model!.logo.toString(),view_property_model!.invoice_insurance.toString(),view_property_model),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
                    itemCount: brokers.length,
                    itemBuilder: (context, index) {
                        return InkWell(
                        child: Widget_all_broker(brokers[index]),
                        onTap: () {
                          BrokerModelEn mod=new BrokerModelEn();
                          mod.created_by=brokers[index].user_id.toString();
                          mod.createdBy=brokers[index].user_id.toString();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Lead_Details(mod)));

                        },
                      );
                    })
              ],
            ),),
          ) :Center(child: No_Data_Placeholder("Projects Not Found.")),


        ],
      ),
    );
  }

   get_all_pbrokers() async {
    setState(() {
      loading = true;

    });
    final prefs = await SharedPreferences.getInstance();



    Map data = {"property_id": widget.propertyList.iD.toString(),"mobile": prefs.getString("mobile").toString()};
    print(json.encode(data));
    var response=await Global_connection().post_method(data, context, API.getInventoryByUserType);
    print(response.toString());
    if(response!=null&&response.data!=null&&response.statusCode == 200){
      var notify = response.data["data"] as List;
      brokers = notify.map<All_Brokers_Model>((json) => All_Brokers_Model.fromJson(json)).toList();
      all_brokers = notify.map<All_Brokers_Model>((json) => All_Brokers_Model.fromJson(json)).toList();
      if(response.data["property_details"]!=null){
        var builder_details = response.data["property_details"];
        view_property_model = View_Property_Model1.fromJson(builder_details);




      }



    }
    setState(() {
      loading = false;

    });

  }
  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        brokers.clear();
        brokers.addAll(all_brokers);
      });
    }else{
      brokers.clear();
      all_brokers.forEach((element) {
        if(element.full_name!.toString().toLowerCase().contains(value.toString().toLowerCase())){
          brokers.add(element);
        } if(element.mobile!.toString().toLowerCase().contains(value.toString().toLowerCase())){
          brokers.add(element);
        }
      });
      setState(() {

      });
    }
  }


}
