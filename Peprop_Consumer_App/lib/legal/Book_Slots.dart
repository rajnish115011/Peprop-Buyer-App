



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/legal/Campain.dart';
import 'package:peprop_consumer_app/widgets/Generate_Grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Models/Slots.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../Utils/FireBase_Logs.dart';
import '../widgets/Bottom_Button.dart';
import '../widgets/Generate_Hash_Map.dart';
import '../widgets/No_Data_Placeholder.dart';
import '../wish_list/Heading_Bold.dart';
import '../wish_list/Styles.dart';

class Book_Slots extends StatefulWidget{
  String type="";
  String full_name="";
  String project_name="";
  String topic_id="";

  Book_Slots(String type, String full_name,String project_name, String topic_id){
    this.type=type;
    this.full_name=full_name;
    this.project_name=project_name;
    this.topic_id=topic_id;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Book_Slots>{
  int selected_index=-1;
  late PageController _pageController;
  bool loading=false;
  List<Slots>Slots_list=[];
  int main_index=0;
  bool update=false;
  @override
  void initState() {
    super.initState();
    get_slots();
    _pageController = PageController(initialPage: 0);


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBar(context, ""),
      body: new Stack(
      children: [
        if(loading==true)Center(child: new CircularProgressIndicator(),)else if(Slots_list.isEmpty)Center(child: new No_Data_Placeholder("No Slots Available..!!"),)else
          SingleChildScrollView(child:Padding(child: new Column(
            children: [
              new SizedBox(height: 20,),
              Heading_Bold("Select time slot for Legal Advice"),
              Card(elevation:1,child: new Column(
                children: [
                  new Container(child: new Row(
                    children: [
                      new SizedBox(width: 10,),
                      InkWell(child:new Container(height: 30,width: 30,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),border: new Border.all(width: 1,color: ColorFile.bgs)),child: new Icon(Icons.arrow_back_ios,color: ColorFile.hint_color,size: 15,),),onTap: (){
                        _pageController.previousPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeIn
                        );
                      },),


                      Expanded(child:  new Container(child: PageView.builder(onPageChanged: (index){setState(() {
                        setState(() {
                          main_index=index;
                        });

                      });},
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          return new
                          Container(child: new Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width-20,
                                padding: EdgeInsets.all(10),
                                height: 70,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(child: new Container(child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        new Text(AppUtils.slot_time(Slots_list[index].date.toString()),style: Styles().styles_bold(16, Colors.black),),
                                        new SizedBox(height: 10,),
                                        new Text(AppUtils.slot_date(Slots_list[index].date.toString()),style: Styles().styles_bold(16, Colors.black),)

                                      ],
                                    ),)),

                                  ],
                                ),),

                            ],
                          ),);

                        },
                        itemCount:Slots_list.length, // Can be null
                      ),height: 100,),),

                      InkWell(child:new Container(height: 30,width: 30,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),border: new Border.all(width: 1,color: ColorFile.bgs)),child: new Icon(Icons.arrow_forward_ios,color: ColorFile.hint_color,size: 15,),),onTap: (){
                        setState(() {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeIn
                          );
                        });
                      },),
                      new SizedBox(width: 10,),
                    ],
                  ),),

                  new Container(child: new Row(),height: 1,color: ColorFile.bgs,),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Slots_list[main_index].list.length,
                      itemBuilder: (context, ind) {
                        return
                          InkWell(child: new Container(
                            color: selected_index==ind?ColorFile.calls:ColorFile.white,
                            padding: EdgeInsets.all(10),
                            height: 60,
                            child: new Row(
                              children: [
                                new Text(Slots_list[main_index].list[ind].toString(),style: Styles().styles_medium(14, Colors.black),)
                              ],
                            ),),onTap: (){
                            setState(() {
                              selected_index=ind;
                            });
                          },);



                      }),
                ],
              ),)


            ],
          ),padding: EdgeInsets.all(10),)),
        if(update)Center(child: new CircularProgressIndicator(),)




      ],
    ),
      bottomNavigationBar: Bottom_Button("Book Slot",onclick: (int){
        if(validate()){
          book_slot();


        }



      },),


    );
  }

  Future<void> get_slots() async {
    await  FireBase_Logs().log_screen_view("Book Slots Form", "Book Slots Form");

    setState(() {
      loading = true;
    });
    Response response=await ServiceConfig().getApiAuth(API.slot_list, context);
    if(response.data!=null&&response.statusCode==200){
      var notify = response.data["list"] as List;
      Slots_list = notify.map<Slots>((json) => Slots.fromJson(json)).toList();
    }

    setState(() {
      loading=false;
    });

  }

  bool validate() {
    if(selected_index==-1){
      AppUtils.toAst("Please select slot..!!",context);
      return false;
    }

    return true;
  }

  Future<void> book_slot() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    List<Map>list=[];
    list.add( new CarJson("83", widget.full_name.toString()).TojsonData());
    list.add( new CarJson("84", sharedPreferences.getString("mobile").toString()).TojsonData());
    list.add( new CarJson("85", sharedPreferences.getString("email").toString()).TojsonData());
    list.add( new CarJson("86", widget.project_name).TojsonData());
    list.add( new CarJson("87", Slots_list[main_index].date+" "+Slots_list[main_index].list[selected_index].toString()).TojsonData());
    Campain campain=new Campain("7", list);
    Map map=campain.TojsonData();
    print(map.toString());
    Legal_Request loan_request=new Legal_Request(widget.topic_id,widget.full_name,widget.project_name,widget.type,Slots_list[main_index].date,sharedPreferences.getString("mobile").toString(),Slots_list[main_index].list[selected_index],map);
    Map map1=loan_request.TojsonData();
    print(map1);
    setState(() {
      update = true;
    });
    Response response=await ServiceConfig().postApiBodyAuthJson(API.booking_slot_insert,json.encode(map1), context);
    if(response.data!=null&&response.statusCode==200){
      var data=await All_Bottom_Sheets().Success_dialog("We have received your request. Our legal team will contact you shortly.", context);
      if(data!=null&&data==true){
        Navigator.pop(context,"response");
      }


    }

    setState(() {
      update=false;
    });
  }

}