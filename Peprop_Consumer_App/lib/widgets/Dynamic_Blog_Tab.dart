
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Blog_Tab_Model.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';

import '../API/API.dart';
import '../Blog_View/my_webview.dart';
import '../Models/BlogModel/BlogModel.dart';
import '../Utils/AppUtils.dart';
import '../Utils/ServiceConfig.dart';
import 'Blog_Widgets.dart';

class Dynamic_Blog_Tab extends StatefulWidget{
  late Blog_Tab_Model element;
  List<AuthorModel> getAuthor=[];
  List<BImageModel> getBImage=[];

  Dynamic_Blog_Tab(Blog_Tab_Model element, List<AuthorModel> getAuthor, List<BImageModel> getBImage){
    this.element=element;
    this.getAuthor=getAuthor;
    this.getBImage=getBImage;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }
  
}
class BuildState extends State<Dynamic_Blog_Tab>{
  bool loading=false;
  List<BlogModel>bloglist=[];
  @override
  void initState() {
    super.initState();
    get_categeory();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: [
        if(loading==true)Center(child: new CircularProgressIndicator(),)else if(bloglist.isEmpty)
          Center(child: new No_Data_Placeholder("No Blogs Available"),)else ListView.builder(
          itemCount: bloglist.length,
          itemBuilder: (context, index) {
            final authorDet = widget.getAuthor.firstWhereOrNull((element) => element.id == bloglist[index].authorID);
            final bimageDet = widget.getBImage.firstWhereOrNull((element) => element.id == bloglist[index].id);
            print(bimageDet.toString());
            String dateTime = bloglist[index].date.toString();
            String newDateTime = dateTime.split("T0").first;
            String dataNew = AppUtils().convert_date3(newDateTime);
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyWebView(
                        selectedUrl:
                        bloglist[index].link!.toString(),
                      )));

                  // launch(_blogModel[index].link!.toString());
                },
                child:Blog_Widgets(bimageDet,dataNew,authorDet,bloglist[index],"full")



            );
          },
        ),
      ],
    );
  }
  Future<void> get_categeory() async {
    setState(() {
      loading = true;
    });
    print(widget.element.id.toString());
    ServiceConfig().getApiAuth(API.blogAPI+"?categories="+widget.element.id.toString(), context).then((value) {
      Response response = value;
      print('response broker/RM List$response');
      setState(() {
        loading=false;
      });
      if (response != null && response.statusCode == 200) {
        var data = response.data as List;
        bloglist = data.map<BlogModel>((json) => BlogModel.fromJson(json)).toList();

      }
    });
  }
}