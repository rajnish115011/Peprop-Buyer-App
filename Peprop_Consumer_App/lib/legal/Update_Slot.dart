



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/My_Legal_Enquiry_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/legal/Campain.dart';
import 'package:peprop_consumer_app/widgets/Generate_Grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Models/Slots.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../widgets/Bottom_Button.dart';
import '../widgets/Generate_Hash_Map.dart';
import '../widgets/No_Data_Placeholder.dart';
import '../wish_list/Heading_Bold.dart';
import '../wish_list/Styles.dart';

class Update_Slot extends StatefulWidget{
  late My_Legal_Enquiry_Model model;
  Update_Slot(My_Legal_Enquiry_Model model){
    this.model=model;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Update_Slot>{
  int selected_index=-1;
  late PageController _pageController;
  bool loading=false;
  List<Slots>Slots_list=[];
  int main_index=0;
  bool update=false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    get_slots();



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
                          selected_index=-1;
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
      bottomNavigationBar: Bottom_Button("Update Slot",onclick: (int){
        update_slots_value();

      },),


    );
  }

  Future<void> get_slots() async {
    setState(() {
      loading = true;
    });
    Response response=await ServiceConfig().getApiAuth(API.slot_list, context);
    if(response.data!=null&&response.statusCode==200){
      var notify = response.data["list"] as List;
      Slots_list = notify.map<Slots>((json) => Slots.fromJson(json)).toList();

      setvalue();
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

  void setvalue() {
    print(widget.model.date.toString());
    for(int i=0;i<Slots_list.length;i++){
      if(Slots_list[i].date==widget.model.date.toString()){
        _pageController = PageController(initialPage: i);
        main_index=i;
        for(int j=0;j<Slots_list[i].list.length;j++){
          if(Slots_list[i].list[j].toString()==widget.model.slot.toString()){
            selected_index=j;
          }

        }

      }
    }
    setState(() {

    });


  }

   update_slots_value() async {
    setState(() {
      update = true;
    });
     var map = Map<String, dynamic>();
     map['id'] =widget.model.id.toString();
     map['date'] =Slots_list[main_index].date.toString();
     map['slot'] =Slots_list[main_index].list[selected_index].toString();


     print(map);



     FormData formData = FormData.fromMap(map);


    setState(() {
      update = true;
    });
    Response response=await ServiceConfig().postApiBodyAuthJson(API.booking_slot_update,formData, context);
       if(response.data!=null&&response.statusCode==200){
         var data=await All_Bottom_Sheets().Success_dialog("Your slot updated successfully..!!", context);
         if(data!=null&&data==true){
           Navigator.pop(context,"response");
         }



    }

    setState(() {
      update=false;
    });
    // print(map);
    //
    //   try{
    //     Response response=await ServiceConfig().postApiBodyAuthJson(API.booking_slot_update,formData, context);
    //   }catch(e){
    //     AppUtils.toAst(e.toString());
    //   }
    //    if(response.data!=null&&response.statusCode==200){
    //   AppUtils.toAst("Update Successfully..!!");
    //   Navigator.pop(context,"response");
    //
    // }

    setState(() {
      update=false;
    });
  }

}