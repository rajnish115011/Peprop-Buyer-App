import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Blog_Tab_Model.dart';
import 'package:peprop_consumer_app/Models/buy/Property_Kind.dart';
import 'package:peprop_consumer_app/legal/Book_Slots.dart';
import 'package:peprop_consumer_app/widgets/Boottom_Button.dart';
import 'package:peprop_consumer_app/widgets/Bottom_Button.dart';
import 'package:peprop_consumer_app/widgets/Generate_Grid.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Models/BlogModel/BlogModel.dart';
import '../Search/Search_Legal_Property.dart';
import '../Utils/AppUtils.dart';
import '../Utils/ServiceConfig.dart';
import 'package:collection/collection.dart';

import '../buy_sell/sheets/For_Kind_property.dart';
import '../widgets/Buy_Sale_Header.dart';
import '../widgets/Dynamic_legal.dart';
import '../widgets/Form_Drop_Down.dart';
import '../widgets/Form_Fields.dart';

class Legals extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }

}
class BuildState extends State<Legals>{
  bool loading=false;
  List<Legal_model>blog_list=[];
  Legal_model?model;
  final full_name=TextEditingController();
  final property_name=TextEditingController();


List<Property_Kind>type_list=[];

 var  selected_type=null;
  var  selected_reason=null;

  @override
  void initState() {
    super.initState();
    get_categeory();
    type_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "Buy"));
    type_list.add(new Property_Kind(proj_tpye_id: "2", proj_type_name: "Sell"));
    type_list.add(new Property_Kind(proj_tpye_id: "3", proj_type_name: "Rent"));
    type_list.add(new Property_Kind(proj_tpye_id: "4", proj_type_name: "Other"));

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

                new Container(child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Buy_Sale_Header("Advice For?"),For_Kind_property(type_list,
                      onSelectionChanged: (selectedList) {
                        setState(() {
                          selected_type=selectedList;
                        });
                      },
                    ),


                  ],
                ),margin: EdgeInsets.only(left: 10,right: 10),),
                Form_Fields().fileds("Full Name", full_name, 50, false, false),
                Form_Drop_Down("Project", property_name, 100, false, true, on_slected: () async {
                  var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_Legal_Property()));
                  if(pageResult!=null){
                    property_name.text=pageResult.toString();
                  }

                },),

                new Container(child:new Column(
                  children: [
                    Buy_Sale_Header("Select issue you want to get legal advice on?"),
                    Legal_chips(blog_list,
                      onSelectionChanged: (selectedList) {
                        setState(() {
                          selected_reason=selectedList;

                        });
                      },
                    )
                  ],
                ),margin: EdgeInsets.only(left: 10,right: 10),),



              ],
            )),
        ],
      ),
      bottomNavigationBar: Bottom_Button("Next",onclick: (value) async {
        if(validate()){
          var move=await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Book_Slots(selected_type.proj_tpye_id,full_name.text.toString(),property_name.text.toString(),selected_reason.id)));
          if(move!=null){
            Navigator.pop(context);
          }

        }


      },),
    );
  }
  Future<void> get_categeory() async {
    SharedPreferences sp=await SharedPreferences.getInstance();
    full_name.text=sp.getString("full_name").toString();
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

  bool validate() {
    if(selected_type==null){
      AppUtils.toAst("Please Select Advice For..!!",context);
      return false;
    }   if(full_name.text.length==0){
      AppUtils.toAst("Please Enter Full Name..!!",context);
      return false;
    }   if(selected_reason==null){
      AppUtils.toAst("Please select topic for advice..!!",context);
      return false;
    }

    return true;
  }
}
