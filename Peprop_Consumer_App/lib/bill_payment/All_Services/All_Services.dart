

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../../Custom_Navigator.dart';
import '../../Utils/FireBase_Logs.dart';


class All_Services extends StatefulWidget{
  String city="";
  int index=0;
  int subindex=0;
  List<Home_Model>home_list=[];
  late BuildContext context;
  All_Services(String city, int index, int subindex, List<Home_Model> home_list, BuildContext context){
    this.index=index;
    this.subindex=subindex;
    this.home_list=home_list;
    this.context=context;

  }






  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}class Build_state extends State<All_Services>{
  bool loading=false;
  List<Home_List_Model>all_list=[];
  List<Home_List_Model>filter_list=[];

  final search_contoller=TextEditingController();

  @override
  void initState() {
    super.initState();
    all_list.addAll(widget.home_list[widget.index].list);
    filter_list.addAll(widget.home_list[widget.index].list);
    method();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppUtils.appBar(context, ""),
      backgroundColor: Colors.white,
      body:new Stack(
        children: [
        NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
                return <Widget>[
                  header(),
                  search_bar()
                ];
              },
              body:GridView.builder(
                itemCount:filter_list.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10, right: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (cx, ind) {
                  return new InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child:Card(
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(filter_list[ind].bg_icon.toString()),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: new BorderRadius.circular(
                              10),


                        ),
                        child: new Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [
                            Expanded(child: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center,
                                children: [
                                  new Container(
                                    child:  Image.network(
                                      filter_list[ind].icon.toString(),
                                      height: 35,
                                      width: 35,
                                    ),
                                  )
                                ],
                              ),
                            )),
                            new SizedBox(height: 5,),
                            new Container(
                              child:
                              new Text(filter_list[ind].alt.toString(),
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    fontSize: 10),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,),

                            ),
                            new SizedBox(height: 5,),

                          ],
                        ),

                      ),
                    ),onTap: (){
                    Custom_Navigator(widget.city,widget.index,ind,widget.home_list,context).navigator();


                  },);
                },
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio:widget.home_list[widget.index].type.toLowerCase()=="section"? 1.2:2.5),
              ))

        ],
      )
    );
  }


  SliverAppBar header() {
    return
      SliverAppBar(
          backgroundColor: Colors.white,
          pinned: false,
          centerTitle: true,

          title:new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           
              Text("Search "+widget.home_list[widget.index].title,style: Styles().styles_bold(20, ColorFile.black),),
              new SizedBox(width: 60,),
            ],
          )
      );
  }
  SliverAppBar search_bar() {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 100,
      elevation: 0,
      backgroundColor: ColorFile.white,
      leadingWidth: 0,
      leading: new Container(),
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 55,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(1.1, 1.1),
                blurRadius: 5.0),
          ],
        ),
        child: CupertinoTextField(
          controller: search_contoller,
          onChanged: (value){
            onchanged(value.toString());
          },
          keyboardType: TextInputType.text,
          placeholder: 'Search',
          style: new TextStyle(fontSize: 16,color: ColorFile.black),
          placeholderStyle: TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 12.0,
            fontFamily: 'regular',
          ),
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0,0.0),
            child: Icon(
              Icons.search,
              size: 18,
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        filter_list.clear();
        filter_list.addAll(all_list);
      });
    }else{
        filter_list.clear();
        all_list.forEach((element) {
        if(element.alt.toString().toLowerCase().contains(value.toString().toLowerCase())){
          filter_list.add(element);
        }
      });
      setState(() {

      });
    }
  }

  Future<void> method() async {
    await FireBase_Logs().log_screen_view("View All Menu", "View All Menu");

  }
  }



