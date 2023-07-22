import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/Generate_Hash_Map.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Filters/All_Projects_Filter.dart';
import '../Models/Apartments_Model.dart';
import '../Models/Listing_Filter_Model.dart';
import '../Utils/AppUtils.dart';
import '../widgets/All_Lands_Widget.dart';
import '../widgets/Grid_With_Color.dart';
import '../widgets/No_Data_Placeholder.dart';
import '../widgets/Properties_Bottom_Button.dart';
import '../widgets/Properties_With_Color.dart';
import '../widgets/Property_List_APP_Bar.dart';
import '../wish_list/Styles.dart';
import 'Properties_Detail.dart';


class All_Apartments extends StatefulWidget {

 late Listing_Filter_Model model;
  All_Apartments(Listing_Filter_Model model){
    this.model=model;
  }




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return build_Widget();
  }
}

class build_Widget extends State<All_Apartments>   with SingleTickerProviderStateMixin {
  List<Apartments_Model> Apartments = [];
  bool loading = false;
  bool is_enabled = true;
  String selected_index = "";
  bool first = true;
  bool isScroll = false;
  Random random = new Random();
  List<Color> colors = [Colors.blue, Colors.amber, Colors.pink,Colors.red, Colors.green, Colors.cyan,Colors.purple,Colors.teal];
  Color selected_color=Colors.blue;
  String user_id="";
  String city="";
  bool synch  =false;
  int current_index=0;
  bool list=true;

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
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    user_id= sharedPreferences.getString("user_id").toString();
    setState(() {
    });
    FormData formData=await Generate_Hash_Map().get_properties(widget.model,Apartments.length,"");
    ServiceConfig().postApiBodyAuthJson(API.gePropertyListbytype, formData, context).then((value) {
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
