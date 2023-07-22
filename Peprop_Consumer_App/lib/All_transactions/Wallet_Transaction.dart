

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


class Wallet_Transaction extends StatefulWidget{
  bool is_window=false;
  Wallet_Transaction(bool is_window){
    this.is_window=is_window;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}

class Build_state extends State<Wallet_Transaction>{
  bool loading=false;
  List<Wallet_Model> list = [];
  String walletBalance="";
  @override
  void initState() {

    get_data();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.is_window)return new Scaffold(
      appBar: AppUtils.appBar_points(context, "",walletBalance),body:
    Stack(
      children: [
        body(),

      ],
    ),);
    else return Stack(
      children: [
        body(),

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
    print(user_id);
    FormData mobile = new FormData.fromMap(_map);
    Response response=await ServiceConfig().postApiBodyAuthJson(API.walletBalance, mobile, context);
    if(response.data!=null&&response.statusCode==200&&response.data!=null){
      walletBalance=response.data["walletBalance"].toString();
      var book_now = response.data["walletTransactions"] as List;
      list.addAll(book_now.map<Wallet_Model>((json) =>Wallet_Model.fromJson(json)).toList());

    }

    setState(() {
      loading = false;
    });
  }

 Widget body() {



    if(loading)return Center(child: Shimmers_Effect(),);
    else if(loading==false &&list.length==0)return Center(child: No_Data_Placeholder("You have not done any transactions"),);
    else  return CustomScrollView(slivers: [
      SliverPadding(
        padding: EdgeInsets.all(10),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return new All_transaction_Widget_Wallet(list[index]);


            },
            childCount: list.length,
          ),
        ),
      ),
    ]);





 }


}