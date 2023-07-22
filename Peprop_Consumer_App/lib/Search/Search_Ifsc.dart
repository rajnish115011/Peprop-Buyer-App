import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/Bank_List_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';

import '../Color/ColorFile.dart';
import '../Models/City_Model.dart';
import '../widgets/AppBar_leading.dart';

class Search_Ifsc extends StatefulWidget {
  String bank_name="";
  Search_Ifsc(String bank_name){
    this.bank_name=bank_name;

  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_Widget();
  }
}

class Build_Widget extends State<Search_Ifsc> {
  List<IFSC_Model> list = [];
  final search=TextEditingController();
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

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
                      child: widget_("Search IFSC...", search),
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
                return new InkWell(
                  onTap: () {
                    Navigator.pop(context, list[index]);
                  },
                  child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: new Container(
                    child: new Row(
                      children: [
                        SizedBox(width: 15),
                        Expanded(
                            child: new Container(
                              alignment: Alignment.centerLeft,
                              child: new GestureDetector(

                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text(
                                      list[index].ifsc.toString(),
                                      style: new TextStyle(
                                          fontSize: 15, fontFamily: "regular"),
                                    ),
                                    new SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),);
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
          if(value.toString().length>1){
            get_properties(value);
          }
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

  get_properties(String value) {

    var map = new Map<String, dynamic>();
    map['name'] = widget.bank_name.toString();
    map['ifsc'] = value.toString();

    FormData formData = new FormData.fromMap(map);
    print(map.toString());
    setState(() {
      loading = true;
      list.clear();
    });
    ServiceConfig()
        .postApiBodyAuthJson(API.ifscCodeByBankName, formData, context)
        .then((value) {
      Response response = value;
      if (response != null && response.statusCode == 200) {
        print("ifsc list api response: " + response.data.toString());
        var notify = response.data["data"] as List;
        list = notify.map<IFSC_Model>((json) => IFSC_Model.fromJson(json)).toList();
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