


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Apartments_Model.dart';
import 'package:peprop_consumer_app/Models/Most_Cities_Model.dart';
import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';
import 'package:peprop_consumer_app/Location/Location_Picker_Sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../All_transactions/Wallet_Transaction.dart';
import '../Color/ColorFile.dart';
import '../Custom_Navigator.dart';
import '../Login/Login.dart';
import '../bill_payment/All_Services/All_Services.dart';
import '../widgets/Banner.dart';
import '../widgets/DashBoard_List_Widget.dart';
import '../widgets/Generate_slider.dart';
import '../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import 'home_page_components/Home_Page_Banner.dart';
import 'home_page_components/Hot_Projects.dart';
import 'home_page_components/Top_Citeis.dart';

class Dash_board_menu_widget extends StatelessWidget{
  Home_Model? home_list;
  int current=0;
  List<Apartments_Model> buy_now_list=[];
  List<Apartments_Model> _propertiesList=[];
  List<Most_Cities_Model> most_cities=[];
  int index=0;
  String city="";
  List<Home_Model> home_lists=[];

  Function(int)update_state;
  Function()choose_city;
  Function(int)change_banner;
  Function(int)change_event;
  int selected_banner=0;

  List<Event_Model> event=[];
  int selected_event=0;
  Dash_board_menu_widget(Home_Model home_list, int current, List<Apartments_Model> buy_now_list, List<Apartments_Model> _propertiesList, List<Most_Cities_Model> most_cities, int index, String city, List<Home_Model> home_lists, int selected_banner, List<Event_Model> event, int selected_event,{required this.update_state,required this.choose_city,required this.change_banner,
  required this.change_event}){
    this.home_list=home_list;
    this.current=current;
    this.buy_now_list=buy_now_list;
    this._propertiesList=_propertiesList;
    this.most_cities=most_cities;
    this.index=index;
    this.city=city;
    this.home_lists=home_lists;
    this.selected_banner=selected_banner;
    this.event=event;
    this.selected_event=selected_event;



  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(home_list!.type.toLowerCase()=="section"&&home_list!.section_id.toLowerCase()!="24"||home_list!.type.toLowerCase()=="section_slider"&&home_list!.section_id.toLowerCase()!="24")Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 20),
          child: new Text(
            home_list!.title.toString(),
            style: new TextStyle(
                fontSize: 16,
                color: ColorFile.black,
                fontFamily: "bold"),
          ),
        )
        else new SizedBox(height: 10,),
        if(buy_now_list.length>0&&home_list!.type.toLowerCase()!="section"&&home_list!.section_id.toLowerCase()=="1")
        Home_Page_Banner(buy_now_list,context,selected_banner,onchanged: (index){
        change_banner(index);

        },)





        else if(home_list!.type.toLowerCase()!="section"&&home_list!.section_id.toLowerCase()=="7")Hot_Projects(_propertiesList)

          else if(home_list!.type.toLowerCase()=="section"&&home_list!.section_id.toLowerCase()=="24")generate_wallet(index,context,home_lists)

          else if(event.length>0&&home_list!.type.toLowerCase()=="section"&&home_list!.section_id.toLowerCase()=="27")
              Event_Banner(event,context,selected_event,onchanged: (index){

                change_event(index);

              },)


            else if(home_list!.type.toLowerCase()!="section"&&home_list!.section_id.toLowerCase()=="8")Top_Citeis(most_cities)
            else if(home_list!.list.length>0&&home_list!.type.toLowerCase()=="section_slider")generate_list(index,context)
            else if(home_list!.list.length>1&&home_list!.type.toLowerCase()!="section")
              InkWell(child: Banners(home_list!.list,current,context,on_changed: (value){
                update_state(value);
              },),onTap: () async {
                SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                if(sharedPreferences.getString("token").toString()=="null"){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

                }else
                Custom_Navigator(city,index,0,home_lists,context).navigator();

              },)
              else generate_grid(index,context),
      ],
    );
  }
  Widget generate_grid(int index, BuildContext context) {
    print("index"+index.toString());

    return
      GridView.builder(
        itemCount:home_lists[index].list.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 10, right: 10),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (cx, ind) {
          return new InkWell(
            borderRadius: BorderRadius.circular(10),
            child: DashBoard_List_Widget_dynamic(home_lists[index].list[ind],ind,viewall: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => All_Services(city,index,ind,home_lists,context)));
            },),onTap: () async {
            SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
            if(sharedPreferences.getString("token").toString()=="null"){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

            }else if(city!="Choose City"){
              Custom_Navigator(city,index,ind,home_lists,context).navigator();

            }else{
              method_choose_location(context);
            }
            // navigator(index,ind);
          },);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
          crossAxisCount: home_lists[index].num_of_column,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          height: 100.0,),



      );
  }

  Widget generate_wallet(int index, BuildContext context, List<Home_Model> home_lists) {

    return new Container(margin: EdgeInsets.only(left: 10,right: 10),
        child: GridView.builder(
        itemCount:home_lists[index].list.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 10, right: 10),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (cx, ind) {
          return new InkWell(
            borderRadius: BorderRadius.circular(10),
            child: wallet_dynamic(home_lists[index].list[ind],home_lists[index],ind),
            onTap: () async {
              SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
              if(sharedPreferences.getString("token").toString()=="null"){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));
              }else if(city!="Choose City"){
                var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wallet_Transaction(true)));

              }else{
                method_choose_location(context);
              }
            },);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
          crossAxisCount: home_lists[index].num_of_column,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          height: 70.0)
      ),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: .5,color: ColorFile.lightgray)),);



  }



  Widget generate_list(int index, BuildContext context) {

    return
      new Container(child: ListView.builder(
        itemCount:home_lists[index].list.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 10, right: 10),
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (cx, ind) {
          return new InkWell(
            borderRadius: BorderRadius.circular(10),
            child: Generate_slider(home_lists[index].list[ind],ind,viewall: () async {
              SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
              if(sharedPreferences.getString("token").toString()=="null"){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

              }else
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => All_Services(city,index,ind,home_lists,context)));

            },),onTap: () async {
            SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
            if(sharedPreferences.getString("token").toString()=="null"){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

            }else
            Custom_Navigator(city,index,ind,home_lists,context).navigator();


            // navigator(index,ind);
          },);
        },

      ),height: 100,);



  }

  method_choose_location(BuildContext context){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
            child:Location_Picker_Sheet("Please Choose Location First..!!",onSelectionChanged: (){
            },choose_location: (){
              choose_city();
            },),
          );
        });


  }
}