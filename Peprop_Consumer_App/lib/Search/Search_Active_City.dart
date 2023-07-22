import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';

import '../Color/ColorFile.dart';
import '../Models/City_Model.dart';
import '../widgets/AppBar_leading.dart';

class Search_Active_City extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_Widget();
  }
}

class Build_Widget extends State {
  List<City_Model> list = [];
  List<City_Model> all_list = [];


  final search=TextEditingController();
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
   get_properties(search.text.toString());
  }
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        top:false,
        child: Scaffold(
          key: _scaffoldKey,
      backgroundColor: ColorFile.white,
      appBar: new AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:ColorFile.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        leading: new Container(),
        backgroundColor: ColorFile.white,
        toolbarHeight: 160,
        flexibleSpace: new Container(
          child: new Column(
            children: [
              new SizedBox(height: 40,),
              AppBar_leading(_scaffoldKey),
              new Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(30)),
                    color: ColorFile.light_background),
                height: 45,
                child: new Row(
                  children: [
                    new SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/search.png",
                      height: 25,
                      width: 25,
                    ),
                    new SizedBox(
                      width: 10,
                    ),
                    new Expanded(
                        child: new Container(
                      alignment: Alignment.centerLeft,
                      child: widget_("Search City...", search),
                    )),
                    loading == true
                        ? new Container(
                            margin: EdgeInsets.only(right: 15),
                            width: 20,
                            height: 20,
                            child: new Container(
                              child: new CircularProgressIndicator(),
                            ),
                          )
                        : new Container()
                  ],
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: new SingleChildScrollView(
        physics: ScrollPhysics(),
        child: new Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext con, int index) {
                return InkWell(child: new Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/loc.png",
                          color: ColorFile.hint_color,
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                            child: new Container(
                              alignment: Alignment.centerLeft,
                              child: new GestureDetector(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    new Text(
                                      list[index].city_name.toString(),
                                      style: new TextStyle(
                                          fontSize: 15, fontFamily: "regular"),
                                    ),

                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),onTap: (){
                  Navigator.pop(context, list[index]);
                },);
              },
              itemCount: list.length,
            ),
          ],
        ),
      ),
    ));
  }

  Widget widget_(String hint, TextEditingController controller) {
    return Container(
      child: TextField(
        controller: controller,
        enabled: true,
        maxLength: 200,
        textCapitalization: TextCapitalization.words,
        onChanged: (value) {
          onchanged(value.toString());
        },
        style:
            TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          hintStyle:
              TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }


  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        list.clear();
        list.addAll(all_list);
      });
    }else{
      list.clear();
      all_list.forEach((element) {
        if(element.city_name.toString().toLowerCase().contains(value.toString().toLowerCase())){
          list.add(element);
        }
      });
      setState(() {
      });
    }
  }

  get_properties(String value) {

    var map = new Map<String, dynamic>();
    map['city_name'] = value;
    FormData formData = new FormData.fromMap(map);
    print(map.toString());
    setState(() {
      loading = true;
      list.clear();
    });
    ServiceConfig()
        .postApiBodyAuthJson(API.city_property, formData, context)
        .then((value) {
      Response response = value;
      if (response != null && response.statusCode == 200) {
        print("city list api response: " + response.data.toString());
        var notify = response.data["list"] as List;
        list = notify.map<City_Model>((json) => City_Model.fromJson(json)).toList();
        all_list = notify.map<City_Model>((json) => City_Model.fromJson(json)).toList();
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        AppUtils.toAst("Something Went Wrong..",context);

        loading = false;

      });
    }).catchError((error, stackTrace) {
      loading = false;
    });
  }
}