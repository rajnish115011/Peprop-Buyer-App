import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Blog_Tab_Model.dart';
import 'package:peprop_consumer_app/widgets/Generate_Grid.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';

import '../API/API.dart';
import '../Models/BlogModel/BlogModel.dart';
import '../Utils/AppUtils.dart';
import '../Utils/FireBase_Logs.dart';
import '../Utils/ServiceConfig.dart';
import 'package:collection/collection.dart';

import 'my_webview.dart';

class Blags_Tab extends StatefulWidget {
  List<AuthorModel> getAuthor=[];
  List<BImageModel> getBImage=[];
  Blags_Tab(List<AuthorModel> getAuthor, List<BImageModel> getBImage){
    this.getAuthor=getAuthor;
    this.getBImage=getBImage;

  }


  @override
  _BlogClassState createState() => _BlogClassState();
}

class _BlogClassState extends State<Blags_Tab> {

  bool loading=false;

  List<Blog_Tab_Model>blog_list=[];

  @override
  void initState() {
    super.initState();
    get_categeory();

  }

  @override
  Widget build(BuildContext context) {

    if(loading)return Scaffold(body: Stack(
      children: [
        Center(child: new CircularProgressIndicator(),)
      ],
    ),);
    else if(blog_list.length==0)return Scaffold(body: Stack(
    children: [
      Center(child: No_Data_Placeholder("No More Blogs Available"),)
    ],
    ),);else
    return Stack(
      children: [
        if(loading)Center(child: new CircularProgressIndicator(),)else if(blog_list.length==0)Center(child: No_Data_Placeholder("No More Blogs Available"),)else DefaultTabController(
          length: blog_list.length,
          initialIndex: 0,
          child: Scaffold(
              appBar: AppUtils.appBar(context, ""),
              body: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      child:  TabBar(
                          isScrollable: true,
                        indicator: BoxDecoration(
                            color:ColorFile.yellowdark,
                            borderRadius:  BorderRadius.circular(25.0)
                        ) ,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        labelStyle: new TextStyle(fontSize: 12,fontFamily: "regular"),
                        tabs:Generate_Grid().generate_tabs(blog_list)
                      ),
                    ),
                    Expanded(
                        child:
                        TabBarView(
                          children: Generate_Grid().generate_tabs_View(blog_list,widget.getAuthor,widget.getBImage)
                        )
                    )
                  ],
                ),
              )
          ),
        ),

      ],
    );
  }

  Future<void> get_categeory() async {

    await FireBase_Logs().log_screen_view("View Blogs", "View Blogs");

    setState(() {
      loading = true;
    });
    ServiceConfig().getApiAuth(API.blogCategory, context).then((value) {
      Response response = value;

      print('response broker/RM List$response');
      if (response != null && response.statusCode == 200) {
        var notify = response.data as List;
        blog_list = notify.map<Blog_Tab_Model>((json) => Blog_Tab_Model.fromJson(json)).toList();
        setState(() {
          loading=false;
        });
      }
    });
  }

}
