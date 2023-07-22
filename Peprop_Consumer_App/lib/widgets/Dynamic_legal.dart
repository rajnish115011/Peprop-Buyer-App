
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Blog_Tab_Model.dart';
import 'package:peprop_consumer_app/Search/Search_Legal_Property.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';

import '../API/API.dart';
import '../Blog_View/my_webview.dart';
import '../Models/BlogModel/BlogModel.dart';
import '../Utils/AppUtils.dart';
import '../Utils/ServiceConfig.dart';
import '../buy_sell/sheets/For_Kind_property.dart';
import 'Blog_Widgets.dart';
import 'Buy_Sale_Header.dart';
import 'Form_Drop_Down.dart';
import 'Form_Fields.dart';

class Dynamic_legal extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }
  
}
class BuildState extends State<Dynamic_legal>{
  bool loading=false;
  List<Legal_model>blog_list=[];
  Legal_model?model;
  final full_name=TextEditingController();
  final property_name=TextEditingController();




  @override
  void initState() {
    super.initState();
    get_categeory();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Scaffold(
      appBar: AppUtils.appBar(context, ""),
      body: Stack(
      children: [
        if(loading==true)Center(child: new CircularProgressIndicator(),)else if(blog_list.isEmpty)Center(child: new No_Data_Placeholder("No Content Available"),)else
          SingleChildScrollView(child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new SizedBox(height: 10,),
              Form_Fields().fileds("Full Name", full_name, 50, false, false),
              Form_Drop_Down("Project", property_name, 100, false, true, on_slected: () async {
                var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_Legal_Property()));
                if(pageResult!=null){
                  property_name.text=pageResult.toString();
                }

              },),
              Buy_Sale_Header("Select issue you want to get legal advice on?"),
              Legal_chips(blog_list,
                onSelectionChanged: (selectedList) {
                  setState(() {


                  });
                },
              ),


            ],
          )),
      ],
    ),);
  }
  Future<void> get_categeory() async {
    setState(() {
      loading = true;
    });
    ServiceConfig().getApiAuth(API.crm_legal_list, context).then((value) {
      Response response = value;

      if (response != null && response.statusCode == 200) {
        var notify = response.data["list"] as List;
        blog_list = notify.map<Legal_model>((json) => Legal_model.fromJson(json)).toList();
        setState(() {
          loading=false;
        });
      }
    });
  }
}