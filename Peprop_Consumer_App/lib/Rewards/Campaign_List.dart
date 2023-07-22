import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Rewards/ReferAndEarn.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Cost_Sheet/model/Builder_Detail_Model.dart';
import '../Global_connection/Global_connection.dart';
import '../Models/Campaign_Model.dart';
import 'Points_Views.dart';

class Campaign_List extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State{
  List<Campaign_Model>list=[];
  String wallet_balance="";
  wallet_data? wallet_data_model;
  @override
  void initState() {
    super.initState();
    get_campaign();

  }

  bool loading=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new

    Scaffold(
      appBar: AppUtils.appBarcolor(context, "", ColorFile.dark_blue),
      body:

      Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)
          else new Column(
            children: [
              Points_Views(wallet_data_model),
              Expanded(child:

              ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(child:
                    new Container(
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10)),
                      margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                      height: 150,
                      child:ClipRRect(borderRadius:new BorderRadius.circular(10) ,child:  CachedNetworkImage(imageUrl:list[index].banner.toString(),fit: BoxFit.fill,),),

                    ),onTap: () async {
                     var nav=await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ReferAndEarn(list[index])));
                     get_campaign();

                    },);
                  }))


            ],
          )
        ],
      ),
    );
  }

  get_campaign() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['user_id'] =sharedPreferences.getString("user_id").toString();
    print(map.toString());
    FormData formData = new FormData.fromMap(map);
    setState(() {
      loading=true;
    });
    var response=await Global_connection().post_method(formData,context, API.offerTypesChildren);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      var builder_details = response.data["wallet_data"];
      wallet_data_model = wallet_data.fromJson(builder_details);
      var notify = response.data["data"] as List;
      list = notify.map<Campaign_Model>((json) => Campaign_Model.fromJson(json)).toList();
    }
    setState(() {
      loading=false;
    });


  }

}