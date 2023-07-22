import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import 'package:geocoding/geocoding.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';

import '../Color/ColorFile.dart';
import '../Models/Apartments_Model.dart';
import '../Properties/Properties_Detail.dart';
import '../widgets/All_Lands_Widget.dart';
import '../widgets/No_Data_Placeholder.dart';
import 'Styles.dart';




class Wish_List extends StatefulWidget {

  String type="";
  Wish_List(String type){
    this.type=type;
  }






  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return build_Widget();
  }
}

class build_Widget extends State<Wish_List>   with SingleTickerProviderStateMixin {
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
  @override
  void initState() {

    get_properties();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:selected_color.withOpacity(.9),
        appBar:AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:selected_color.withOpacity(.9),
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          toolbarHeight: 65,elevation: 0.0,centerTitle: false,backgroundColor:Colors.transparent,
            leading:new InkWell(
            onTap: (){
              Navigator.pop(context);
            },child:Icon(Icons.arrow_back_ios,color: ColorFile.white,)),),
        body: Stack(
                children: [
                 loading==true? Center(child: CircularProgressIndicator(),): loading==false&&Apartments.length>0?property_list():Center(child: No_Data_Placeholder_white("No Project Added in Wishlist"),),

          ],
        ),
        bottomNavigationBar:Apartments.length>0? InkWell(
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

  Widget property_list() {
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          loading == false
              ? Expanded(
              child: NotificationListener<ScrollNotification>(
                child:
                PageView.builder(
                   onPageChanged: (index){
                     setState(() {
                       current_index=index;
                       selected_color=colors[random.nextInt(colors.length-1)];
                     });
                     },
                  scrollDirection: Axis.vertical,
                   itemBuilder: (context, index) {
                     return   InkWell(
                         onTap: (){
                           var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Properties_Detail(Apartments[index].ID,"")));

                         },
                         child:All_Lands_Widget(Apartments[index])

                     );
                   },
                itemCount: Apartments.length, // Can be null
                ),
              ))
              : new Container(
            height: MediaQuery.of(context).size.height - 220,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }


  void get_properties() {
    setState(() {
      loading = true;
      Apartments.clear();
    });
    var map = new Map<String, dynamic>();
    map['type'] =widget.type.toString();

    FormData formData = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.getPropertyforlater,formData, context).then((value) {
      Response response = value;
      if (response != null && response.statusCode == 200) {
        var notify = response.data["list"] as List;
        print("prop list" + response.data.toString());
        Apartments = notify.map<Apartments_Model>((json) => Apartments_Model.fromJson(json)).toList();
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }





}
