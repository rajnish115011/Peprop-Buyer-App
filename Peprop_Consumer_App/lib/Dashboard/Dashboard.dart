import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/dom.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peprop_consumer_app/Dashboard/Dash_board_menu_widget.dart';
import 'package:peprop_consumer_app/Dashboard/Scan_Qrcode.dart';
import 'package:peprop_consumer_app/Models/Apartments_Model.dart';
import 'package:peprop_consumer_app/Models/BlogModel/BlogModel.dart';
import 'package:peprop_consumer_app/Models/Most_Cities_Model.dart';
import 'package:peprop_consumer_app/Thanks/Reload.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/Download_File.dart';
import 'package:peprop_consumer_app/Utils/FireBase_Logs.dart';
import 'package:peprop_consumer_app/Utils/Home_Page_Model.dart';
import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';
import 'package:peprop_consumer_app/widgets/Check_Play_Store.dart';
import 'package:peprop_consumer_app/widgets/Dashboard_App_Bar.dart';
import 'package:peprop_consumer_app/wish_list/Shimmers_Effect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import '../API/API.dart';
import '../Global_connection/Global_connection.dart';
import '../Models/City_Model.dart';
import '../Search/Search_Active_City.dart';
import '../notification/Notification_List.dart';
import 'home_page_components/Blogs.dart';
import 'home_page_components/Drawer_File.dart';



class Dashboard extends StatefulWidget {
  @override
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}

class _DesignCourseHomeScreenState extends State<Dashboard>  with SingleTickerProviderStateMixin{
  String city="Choose City";
  String notificationNewCount="";
  List<BlogModel> _blogModel = [];
  List<AuthorModel> _getAuthor = [];
  List<BImageModel> _getBImage = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Apartments_Model> _propertiesList = [];
  List<Most_Cities_Model> most_cities = [];
  int current=0;
  List<Apartments_Model> buy_now_list = [];
  bool loading =true;
  String token="";
  List<Home_Model>home_list=[];
  List<Event_Model>event=[];



  var response;
  int selected_banner=0;
  int selected_event=0;
  AppUpdateInfo?_updateInfo;


  @override
  void initState() {
    super.initState();
    set_city();
    set_data();
    getblog();


  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:(){SystemChannels.platform.invokeMethod('SystemNavigator.pop');return Future.value(true);},
        child:Scaffold(
          key: _scaffoldKey,
          drawer: Drawer_File(token),
          backgroundColor: Colors.white,
          appBar:Dashboard_App_Bar(city,token,notificationNewCount,scan:() async {
            var res=await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scan_Qrcode()));
          },
             onSelectionChanged:(){
            _scaffoldKey.currentState!.openDrawer();
          },choose_city: () async {
            select_city();
          },
             notification_click: () async {
             var res=await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notification_List()));
             final SharedPreferences prefNew =await SharedPreferences.getInstance();
             setState(() {
               notificationNewCount=prefNew.getString("unread").toString();
             });


            },

          ),
          body:RefreshIndicator(
              onRefresh: dashboard_api,child:Stack(
            children: [
              loading==true?Shimmers_Effect():response==null?  Reload(on_click: (){
                dashboard_api();
              },): Column(
                children: <Widget>[
                  Expanded(child: ListView.builder(
                      shrinkWrap: true,
                      physics:AlwaysScrollableScrollPhysics(),
                      itemCount: home_list.length,
                      itemBuilder: (context, index) {
                        return new Dash_board_menu_widget(home_list[index],current,buy_now_list,_propertiesList,most_cities,index,city,home_list,selected_banner,event,selected_event, update_state: (int ) {
                          setState(() {
                            current=int;
                          });
                        },choose_city: (){
                          select_city();
                        },change_banner: (int){
                          setState(() {
                            selected_banner=int;
                          });

                        },change_event: (int){
                          setState(() {
                            selected_event=int;
                          });

                        },);
                      })),
                  // if(_blogModel.length>0) Blogs(_blogModel,_getAuthor,_getBImage),

                ],
              ),


            ],
          )),


        ));
  }









  Future<void>   dashboard_api() async{


    setState(() {
      loading=true;
    });
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
    String city=prefNew.getString("city").toString().replaceAll("null", "Choose City");
    String city_id=prefNew.getString("city_id").toString().replaceAll("null", "");
    var map = new Map<String, dynamic>();
    map['limit'] = 10;
    map['start'] =0;
    map['city'] =city;
    if(city_id!=""){
      map['city_id'] =city_id;
      Check_Play_Store().getStoreVersion("com.dasv.peprop_consumer_app","com.dasv.pepropconsumer.pepropConsumerApp",context);
    }
    if(prefNew.getString("user_id").toString()!="null"){
      map['user_id'] =prefNew.getString("user_id").toString();
      print(prefNew.getString("user_id").toString());
    }
    print(json.encode(map));
    FormData formData = new FormData.fromMap(map);
    var response=await Global_connection().post_method(formData, context, API.getDashboard);


    if(response!=null&&response.data!=null&&response.statusCode==200){
      Map map=response.data;
      String encodedMap = json.encode(map);
      prefNew.setString("response",encodedMap);
      set_data();

    }else{
      setState(() {
        loading=false;
      });
    }



  }


  Future<void> getblog() async{
    var response=await Global_connection().post_method(new Map(),context, API.getBlog);
    if(response!=null&&response.data!=null&&response.statusCode==200){
      if(response.data["blog"]!=null){
        var data = response.data["blog"] as List;
        _blogModel = data.map<BlogModel>((json) => BlogModel.fromJson(json)).toList();

      }

      if(response.data["blogmedia"]!=null){
        var data1 = response.data["blogmedia"] as List;
        _getBImage = data1.map<BImageModel>((json) => BImageModel.fromJson(json)).toList();

      }
      if(response.data["bloguser"]!=null){
        var data2 = response.data["bloguser"] as List;
        _getAuthor = data2.map<AuthorModel>((json) => AuthorModel.fromJson(json)).toList();

      }

    }
    setState(() {
      loading=false;
    });


  }


  Future<void> select_city() async {
    var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_Active_City()));
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
    if (pageResult != null) {
      City_Model model = pageResult;
      city=model.city_name;
      prefNew.setString('city', model.city_name);
      prefNew.setString('city_id', model.city_id);
      city=prefNew.getString("city").toString();
      dashboard_api();


    }
  }

  Future<void> set_data() async {




    await FireBase_Logs().log_screen_view("dashboard","Home Page");
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    token=sharedPreferences.getString("token").toString();
     city=sharedPreferences.getString("city").toString().replaceAll("null", "Choose City");

    var respons=sharedPreferences.getString("response");
    print(response);
    if(respons!=null){
      response=json.decode(respons);
      sets(response);
    }else{
      dashboard_api();
    }

  }
    sets(Map map) async {
    Home_Page_Model constant_model=await AppUtils().sets(map);
    home_list=constant_model.home_list;
    event=constant_model.ev;


    buy_now_list=constant_model.buy_now_list;

    _propertiesList= constant_model.propertiesList;
    most_cities= constant_model.most_cities;
    notificationNewCount=constant_model.notificationNewCount;

    setState(() {
      loading=false;
    });
  }

  Future<void> set_city() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    token=sharedPreferences.getString("token").toString();
    city=sharedPreferences.getString("city").toString().replaceAll("null", "Choose City");
    if(city=="Choose City"){
      select_city();
    }else{


    }



  }



}






