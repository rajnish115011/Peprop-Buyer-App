

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Enquiry/Broker_Properties_List.dart';
import 'package:peprop_consumer_app/Models/All_transactions_Model.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/My_Enquiry_BokerRM.dart';
import '../widgets/All_transaction_Widget.dart';
import '../wish_list/Shimmers_Effect.dart';


class BBps_Transaction_Tab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}

class Build_state extends State{
  bool loading=false;
  List<All_transactions_Model> list = [];
  @override
  void initState() {

    get_data();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
          if(loading)Center(child: Shimmers_Effect(),)else if(list.length==0)Center(child: No_Data_Placeholder("You have not done any transactions"),)else CustomScrollView(slivers: [
            SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return new All_transaction_Widget(list[index]);


                },
                childCount: list.length,
              ),
            ),
          ),
        ])

      ],
    );
  }

  Future<void> get_data() async {
    final SharedPreferences prefNew = await SharedPreferences.getInstance();
    String user_id = prefNew.getString('user_id')!;
    var _map = <String, String>{};
    _map['user_id'] = user_id;
    setState(() {
      loading = true;
    });
    FormData mobile = new FormData.fromMap(_map);
    Response response=await ServiceConfig().postApiBodyAuthJson(API.allTransaction, mobile, context);
    if(response.data!=null&&response.statusCode==200){

      var book_now = response.data["data"]["BBPS"] as List;
      list.addAll(book_now.map<All_transactions_Model>((json) =>All_transactions_Model.fromJson(json)).toList());


      list.sort((a,b) {
        return b.created_at.compareTo(a.created_at);
      });


    }

    setState(() {
      loading = false;
    });
  }


}