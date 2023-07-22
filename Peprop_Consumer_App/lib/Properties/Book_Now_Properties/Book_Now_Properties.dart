import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Filters/All_Projects_Filter.dart';
import '../../Models/Apartments_Model.dart';
import '../../Models/Listing_Filter_Model.dart';
import '../../Utils/AppUtils.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/All_Lands_Widget.dart';
import '../../widgets/Grid_With_Color.dart';
import '../../widgets/No_Data_Placeholder.dart';
import '../../widgets/Properties_Bottom_Button.dart';
import '../../widgets/Properties_With_Color.dart';
import '../../widgets/Property_List_APP_Bar.dart';
import '../../wish_list/Styles.dart';
import '../Properties_Detail.dart';



class Book_Now_Properties extends StatefulWidget {

 late Listing_Filter_Model model;
 Book_Now_Properties(Listing_Filter_Model model){
    this.model=model;
  }




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return build_Widget();
  }
}

class build_Widget extends State<Book_Now_Properties>   with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Apartments_Model> Apartments = [];
  bool loading = false;
  bool is_enabled = true;
  String selected_index = "";
  bool first = true;
  bool isScroll = false;
  String city_name = "";


  List<String>idlist=[];
  Random random = new Random();
  List<Color> colors = [Colors.blue, Colors.amber, Colors.pink,Colors.red, Colors.green, Colors.cyan,Colors.purple,Colors.teal];


  Color selected_color=Colors.blue;

  String city="";
  bool synch  =false;
  int current_index=0;

  String kyc_status="";
  bool list=true;
  String user_id="";

  @override
  void initState() {
    loading = true;
    get_properties();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:list==true?selected_color.withOpacity(.9):ColorFile.white,
        appBar:Property_List_APP_Bar(true,selected_color,widget.model.filter_type.toString(),widget.model.filter_apply,list,widget.model,
          onSelectionChanged: () async {var get_res=await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>All_Projects_Filter(widget.model)));if(get_res!=null){
            setState(() {
              widget.model=get_res;
              synch=false;
              loading=true;
              Apartments.clear();
              get_properties();
            });

          }},
          grid_or_list: (bool){
            setState(() {
              list=bool;
            });

          },
        ),

        body: Stack(
              children: [
                loading==true?Center(child: new CircularProgressIndicator(),):loading==false&&Apartments.length==0?Center(child:No_Data_Placeholder_white("Sorry! We couldn’t find any Project matching to your search criteria."),):Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    Expanded(child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {if (!isScroll && scrollInfo.metrics.pixels ==scrollInfo.metrics.maxScrollExtent &&Apartments.length >= 10) {
                        isScroll = true;
                        get_properties();
                      }return true;
                      },
                      child:list==true?
                      Properties_With_Color(Apartments,on_changed: (int){
                        setState(() {
                          current_index=int;
                          selected_color=colors[random.nextInt(colors.length-1) ];

                        });

                      }):Grid_With_Color(Apartments,null,user_id),


                    ))
                  ],
                ),
              if(synch==true)Center(child: CircularProgressIndicator(),)
          ],
        ),
        bottomNavigationBar:Apartments.length>0&&list==true?

        Properties_Bottom_Button(Apartments,current_index,selected_color,user_id):new Container(height: 0,)




    );


  }



  Future<void> get_properties() async {

    await  FireBase_Logs().log_screen_view("Search Book Now Projects", "Search Book Now Projects");

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    user_id= sharedPreferences.getString("user_id").toString();

     kyc_status=sharedPreferences.getString("kyc_status").toString();
    setState(() {
    });
    var map = new Map<String, dynamic>();
    map['prop_type'] =widget.model.filter_type.toString();
    map['limit'] = 10;
    map['start'] = Apartments.length;
    map['city'] = widget.model.city.toString().trim();
    map['order_by'] =widget.model.order_by.toString();
    map['user_id'] = sharedPreferences.getString("user_id").toString();
    if(widget.model.filter_apply==true){
      List<String> selected_prjects = [];
      widget.model.project_status.forEach((element) {
        if(element.checked==true)selected_prjects.add(element.id);
      });
      List<String> selected_furniture = [];
      widget.model.furnishing.forEach((element) {
        if(element.checked==true)selected_furniture.add(element.id);
      });
      List<String> selected_property = [];
      List<String> selected_bhk = [];

      if(widget.model.filter_type==1){
        widget.model.res.forEach((element) {
          if(element.checked==true)selected_property.add(element.id);
        });
        widget.model.room_list.forEach((element) {
          if(element.checked==true)selected_bhk.add(element.unit_type);
        });


      }else{
        widget.model.com.forEach((element) {
          if(element.checked==true)selected_property.add(element.id);
        });
      }

      if(widget.model.filter_apply==true){
        map['min_am'] = widget.model.min_budget.toStringAsFixed(2);
        map['max_am'] = widget.model.max_buget.toStringAsFixed(2);
        map['min_area'] = widget.model.min_area.toStringAsFixed(0);
        map['max_area'] = widget.model.max_area.toStringAsFixed(0);
        map['area_id'] = widget.model.area_id;
        if(selected_prjects.length>0){
          map['proj_status'] =selected_prjects.join(",");
        }

        if(selected_furniture.length>0){
          map['furnishing_status'] =selected_furniture.join(",");
        }

        if(selected_property.length>0){
          map['property_type'] =selected_property.join(",");
        }
        if(!widget.model.prop_name.toString().isEmpty){
          map['proj_name'] =widget.model.prop_name;
        }


        if(selected_bhk.length>0){
          map['unit_type'] =selected_bhk.join(",");
        }

      }



    }


    print("post data"+json.encode(map));
    FormData formData = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.getBookPropertyListbytype, formData, context).then((value) {
      Response response = value;
      if (response != null && response.statusCode == 200) {
        var notify = response.data["list"] as List;
        print("prop list" + response.data.toString());
        Apartments.addAll(notify.map<Apartments_Model>((json) => Apartments_Model.fromJson(json)).toList());
        setState(() {
          loading = false;
          isScroll=false;
        });
      } else {
        setState(() {
          loading = false;
          isScroll=false;

        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        AppUtils.toAst("Something Went Wrong..",context);
        loading = false;
        isScroll=false;
      });
    });
  }







}
