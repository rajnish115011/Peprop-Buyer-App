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
import '../widgets/Properties_With_Color.dart';
import '../widgets/Property_List_APP_Bar.dart';
import '../wish_list/Styles.dart';
import 'Properties_Detail.dart';


class Pre_Leased extends StatefulWidget {

 late Listing_Filter_Model model;
 String menu_id="";
 Pre_Leased(Listing_Filter_Model model, String menu_id){
    this.model=model;
    this.menu_id=menu_id;


  }




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return build_Widget();
  }
}

class build_Widget extends State<Pre_Leased>   with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Apartments_Model> Apartments = [];
  bool loading = false;
  bool is_enabled = true;
  String selected_index = "";
  bool first = true;
  bool isScroll = false;
  String city_name = "";
  String user_id="";


  List<String>idlist=[];
  Random random = new Random();
  List<Color> colors = [Colors.blue, Colors.amber, Colors.pink,Colors.red, Colors.green, Colors.cyan,Colors.purple,Colors.teal];


  Color selected_color=Colors.blue;

  String city="";
  bool synch  =false;
  int current_index=0;

  String kyc_status="";
  bool list=false;
   bool is_found=true;
   String? message;

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
        appBar:Property_List_APP_Bar(false,selected_color,widget.model.filter_type.toString(),widget.model.filter_apply,list,widget.model,
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

                      }):Grid_With_Color(Apartments,message,user_id),


                    ))
                  ],
                ),
              if(synch==true)Center(child: CircularProgressIndicator(),)
          ],
        ),
        bottomNavigationBar:Apartments.length>0&&list==true? InkWell(
          onTap: (){
            var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Properties_Detail(Apartments[current_index].ID,"")));

          },
          child: new Container(
              color:selected_color.withOpacity(.9),
              height: 60,child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text("View Details",style: Styles().styles_medium(18, ColorFile.white),)

            ],
          )),
        ):new Container(height: 0,)

    );



  }



  Future<void> get_properties() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    user_id= sharedPreferences.getString("user_id").toString();
    setState(() {
    });
    FormData formData=await Generate_Hash_Map().get_properties(widget.model,Apartments.length,widget.menu_id);
    ServiceConfig().postApiBodyAuthJson(API.gePropertyListbySpace, formData, context).then((value) {
      Response response = value;

      if (response != null && response.statusCode == 200) {

        if(response.data["data_found"]==false){

           is_found=response.data["data_found"];

           message=response.data["message"].toString();

        }
        var notify = response.data["list"] as List;
        print("prop list" + response.data["message"].toString());
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
