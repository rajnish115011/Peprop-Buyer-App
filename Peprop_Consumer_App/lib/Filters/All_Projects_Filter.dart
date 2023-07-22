
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:peprop_consumer_app/Local_database/Rec_city.dart';
import 'package:peprop_consumer_app/Models/Listing_Filter_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/Form_Fields.dart';

import '../Color/ColorFile.dart';
import '../Local_database/DatabaseService.dart';
import '../Models/City_Model.dart';
import '../Models/Search_Model.dart';
import '../Search/Search_Active_City.dart';
import '../Search/Search_City.dart';
import '../Search/Search_Property_Globally.dart';
import 'Bottom_sheet_For_Area.dart';


class All_Projects_Filter extends StatefulWidget{
  late Listing_Filter_Model model;

  All_Projects_Filter(Listing_Filter_Model model){
    this.model=model;

  }
  @override
  State<StatefulWidget> createState() {
    return Build();
  }

}
class Build extends State<All_Projects_Filter>{
  int type=1;
  double start=0;
  double end=0;
  late RangeValues _currentRangeValues;

  double areastart=0;
  double areaend=0;
  late RangeValues area_range;

  final city=TextEditingController();
  final project_name=TextEditingController();

  double values=0.0;
  @override
  void initState() {
    super.initState();
    city.text=widget.model.city;
    project_name.text=widget.model.prop_name;
    _currentRangeValues =  RangeValues(widget.model.min_budget, widget.model.max_buget);
    start=widget.model.min_budget;
    end =widget.model.max_buget;
    area_range =  RangeValues(widget.model.min_area, widget.model.max_area);

  }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Scaffold(
        backgroundColor: ColorFile.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:ColorFile.white,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          toolbarHeight: 65,
          elevation: 0.0,
          centerTitle: false,
          backgroundColor: ColorFile.white,
          leading:
          new InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: new Row(
              children: [
                new SizedBox(width: 20,),
                Icon(Icons.close,color: ColorFile.black,),

              ],
            ),
          ),
          title:new Text("Back",style: new TextStyle(fontSize:17,fontFamily: "bold",color: ColorFile.black),),
          actions: [
            if(widget.model.filter_apply==true) new InkWell(
              onTap: (){
                clear_all_filter();

              },
              child:    new Container(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    new SizedBox(width: 20,),
                    new Container(child: new Text("Clear All",style: new TextStyle(fontSize: 14,color: ColorFile.app_color,fontFamily: "medium"),),),
                    new SizedBox(width: 20,),

                  ],
                ),
              ),
            )

          ],



        ),
        body: new SingleChildScrollView(
            child:Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: new Column(
                children: [
                  new Container(
                    height: 40,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: InkWell(
                          onTap: (){
                            setState(() {
                              widget.model.filter_type=1;
                            });
                          },
                          child: new Container(
                          decoration: new BoxDecoration(border: Border(bottom: BorderSide(color: widget.model.filter_type==1?ColorFile.app_color:ColorFile.white,width: 1))),
                          alignment: Alignment.center,
                          child:new Text("Residential",style: new TextStyle(fontSize: 14,fontFamily: "medium"),),
                        ),)),
                        new SizedBox(width: 10,),
                        Expanded(child: InkWell(
                          onTap: (){
                            setState(() {
                              widget.model.filter_type=2;
                            });
                          },
                          child: new Container(
                            decoration: new BoxDecoration(border: Border(bottom: BorderSide(color: widget.model.filter_type==2?ColorFile.app_color:ColorFile.white,width: 1))),
                            alignment: Alignment.center,
                            child:new Text("Commercial",style: new TextStyle(fontSize: 14,fontFamily: "medium"),),
                          ),)),

                      ],
                    ),
                  ),

                  //budget//
                  Devider_size(20),
                  InkWell(onTap: () async {

                    var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_Active_City()));
                    if (pageResult != null) {
                      setState(() {
                        City_Model model = pageResult;
                        city.text=model.city_name;

                      });
                    }
                  },child:Container(child: Row(children: [Expanded(child: Container( child: Form_Fields().non_editable_text("Search City.", city,),))]))),

                  Devider_size(20),

                  InkWell(onTap: () async {
                    var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_Property_Globally(city.text.toString(),widget.model.filter_type)));
                    if(pageResult!=null){
                      Search_Model model=pageResult;
                      setState(() {
                        project_name.text=model.property_name;
                      });

                    }


                  },child:Container(child: Row(children: [Expanded(child: Container( child: Form_Fields().non_editable_text("Project Name", project_name,),))]))),


                  if(project_name.text.length==0)new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Devider_size(20),
                      new Container(
                          child:new Row(
                            children: [
                              Expanded(child: new Container(
                                child:new Text("Budget",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                              )),


                            ],
                          )
                      ),
                      Devider_size(20),
                      new Container(
                          child:new Row(
                            children: [
                              Expanded(child:new Container(
                                alignment: Alignment.centerLeft,
                                child:new Text(NumberFormat.compactCurrency(locale: 'en_IN',symbol: '₹ ').format(start).toString(),style: new TextStyle(fontFamily: "regular",color:ColorFile.black,fontSize: 18),),
                              )),
                              new Container(
                                child:new Text("to",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                              ),
                              Expanded(child:new Container(
                                alignment: Alignment.center,
                                child:new Text(NumberFormat.compactCurrency(locale: 'en_IN',symbol: '₹ ').format(end).toString(),style: new TextStyle(fontFamily: "regular",color:ColorFile.black,fontSize: 18),),
                              )),
                            ],
                          )
                      ),
                      RangeSlider(
                        values:_currentRangeValues,
                        min: 0,
                        max:  200000000,
                        divisions: 75000000,
                        onChanged: (RangeValues values) {
                          setState(() {
                            widget.model.max_buget=values.end;
                            widget.model.min_budget=values.start;
                            start=values.start;
                            end=values.end;
                            _currentRangeValues = values;
                          });
                        },


                      ),
                      Devider_size(20),


                      if(widget.model.filter_type==1)new Column(
                        children: [
                          new Container(child:new Row(children: [Expanded(child: new Container(child:new Text("No. of Bedrooms",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),)),],)),
                          new Container(margin: EdgeInsets.only(top: 20), height: 40, child:new Row(children: [
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.model.room_list.length,
                                  itemBuilder: (BuildContext context, int index) =>
                                  new Container(
                                    child: new InkWell(
                                      onTap: (){
                                        setState(() {
                                          widget.model.room_list[index].checked=!widget.model.room_list[index].checked;
                                        });
                                      },
                                      child: new Column(
                                        children: [
                                          if(widget.model.room_list[index].checked==true)new Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.only(left: 15,right: 15),
                                            height: 35,
                                            decoration: new BoxDecoration(
                                                borderRadius: new BorderRadius.circular(30),
                                                color: ColorFile.hex_cyan,
                                                border: new Border.all(color: ColorFile.blue,width: 1)
                                            ),
                                            child: new Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                new Icon(Icons.check,color: ColorFile.app_color,size: 20,),
                                                new SizedBox(width: 5,),
                                                new Text(widget.model.room_list[index].unit_type+" BHK",style: new TextStyle(fontFamily: "medium",fontSize: 14),),
                                              ],
                                            ),
                                          ),
                                          if(widget.model.room_list[index].checked==false)new Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.only(left: 15,right: 15),
                                            height: 35,
                                            decoration: new BoxDecoration(
                                                borderRadius: new BorderRadius.circular(30),
                                                color: ColorFile.white,
                                                border: new Border.all(color: ColorFile.lightgray,width: 1)
                                            ),
                                            child: new Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                new Icon(Icons.add,color: ColorFile.hint_color,size: 20,),
                                                new SizedBox(width: 5,),
                                                new Text(widget.model.room_list[index].unit_type+" BHK",style: new TextStyle(fontFamily: "medium",fontSize: 14,color: ColorFile.hint_color),),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                            )
                          ],),),
                        ],
                      ),
                      new Container(margin: EdgeInsets.only(bottom: 10,top: 20),child:new Row(children: [Expanded(child: new Container(child:new Text("Type Of property",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),)),])),
                      if(widget.model.filter_type==1)Container(

                        alignment: Alignment.centerLeft,
                        child: Wrap(children: List.generate(widget.model.res.length,(i) {
                          return new GestureDetector(
                              onTap: (){
                                setState(() {
                                  widget.model.res[i].checked=!widget.model.res[i].checked;
                                });
                              },
                              child:new Container(
                                height: 40,
                                margin: EdgeInsets.only(right: 15,top: 10),
                                decoration: new BoxDecoration(borderRadius:new BorderRadius.circular(30),border: new Border.all(width: 1,color: ColorFile.drawer),color:widget.model.res[i].checked==true?ColorFile.drawer:ColorFile.white),
                                child: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,
                                  children: [
                                    Container(padding:EdgeInsets.only(left: 15,right: 15),
                                      child: new Text(widget.model.res[i].PropertType,textAlign:TextAlign.center,style: new TextStyle(fontFamily:"regular",fontSize:13,color:widget.model.res[i].checked==true? ColorFile.white:ColorFile.black)),
                                    )
                                  ],
                                ),
                              ));

                        },
                        ),
                        ),
                      ),
                      if(widget.model.filter_type==2)Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(children: List.generate(widget.model.com.length,(i) {
                          return new GestureDetector(
                              onTap: (){
                                setState(() {
                                  widget.model.com[i].checked=!widget.model.com[i].checked;
                                });
                              },
                              child:new Container(
                                height: 40,
                                margin: EdgeInsets.only(right: 15,top: 10),
                                decoration: new BoxDecoration(borderRadius:new BorderRadius.circular(30),border: new Border.all(width: 1,color: ColorFile.drawer),color:widget.model.com[i].checked==true?ColorFile.drawer:ColorFile.white),
                                child: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,
                                  children: [
                                    Container(padding:EdgeInsets.only(left: 15,right: 15),
                                      child: new Text(widget.model.com[i].PropertType,textAlign:TextAlign.center,style: new TextStyle(fontFamily:"regular",fontSize:13,color:widget.model.com[i].checked==true? ColorFile.white:ColorFile.black)),
                                    )
                                  ],
                                ),
                              ));

                        },
                        ),
                        ),
                      ),
                      new Container(margin: EdgeInsets.only(bottom: 10,top: 30),child:new Row(children: [Expanded(child: new Container(child:new Text("Furnishing Status",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),)),])),

                      Container(

                        alignment: Alignment.centerLeft,
                        child: Wrap(children: List.generate(widget.model.furnishing.length,(i) {
                          return new GestureDetector(
                              onTap: (){
                                setState(() {
                                  widget.model.furnishing[i].checked=!widget.model.furnishing[i].checked;
                                });
                              },
                              child:new Container(
                                height: 40,
                                margin: EdgeInsets.only(right: 15,top: 10),
                                decoration: new BoxDecoration(borderRadius:new BorderRadius.circular(30),border: new Border.all(width: 1,color: ColorFile.drawer),color:widget.model.furnishing[i].checked==true?ColorFile.drawer:ColorFile.white),
                                child: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,
                                  children: [
                                    Container(padding:EdgeInsets.only(left: 15,right: 15),
                                      child: new Text(widget.model.furnishing[i].furnishing_name,textAlign:TextAlign.center,style: new TextStyle(fontFamily:"regular",fontSize:13,color:widget.model.furnishing[i].checked==true? ColorFile.white:ColorFile.black)),
                                    )
                                  ],
                                ),
                              ));

                        },
                        ),
                        ),
                      ),

                      new Container(margin: EdgeInsets.only(bottom: 10,top: 30),child:new Row(children: [Expanded(child: new Container(child:new Text("Project Status",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),)),])),

                      Container(

                        alignment: Alignment.centerLeft,
                        child: Wrap(children: List.generate(widget.model.project_status.length,(i) {
                          return new GestureDetector(
                              onTap: (){
                                setState(() {
                                  widget.model.project_status[i].checked=!widget.model.project_status[i].checked;
                                });
                              },
                              child:new Container(
                                height: 40,
                                margin: EdgeInsets.only(right: 15,top: 10),
                                decoration: new BoxDecoration(borderRadius:new BorderRadius.circular(30),border: new Border.all(width: 1,color: ColorFile.drawer),color:widget.model.project_status[i].checked==true?ColorFile.drawer:ColorFile.white),
                                child: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,
                                  children: [
                                    Container(padding:EdgeInsets.only(left: 15,right: 15),
                                      child: new Text(widget.model.project_status[i].name,textAlign:TextAlign.center,style: new TextStyle(fontFamily:"regular",fontSize:13,color:widget.model.project_status[i].checked==true? ColorFile.white:ColorFile.black)),
                                    )
                                  ],
                                ),
                              ));

                        },
                        ),
                        ),
                      ),



                      new SizedBox(height: 30,),
                      new Container(
                          child:new Row(
                            children: [
                              Expanded(child:new Container(
                                child:new Text("Area",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                              )),

                              InkWell(
                                onTap: (){
                                  area_picker();
                                },
                                child: new Row(
                                  children: [
                                    new Container(
                                      child:new Text(widget.model.area_name,style: new TextStyle(fontFamily: "medium",color:ColorFile.hint_color,fontSize: 16),),
                                    ),new SizedBox(width: 10,),
                                    Icon(Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),)



                            ],
                          )
                      ),
                      new SizedBox(height: 30,),
                      new Container(
                          child:new Row(
                            children: [
                              Expanded(child:new Container(
                                alignment: Alignment.centerLeft,
                                child:new Text(widget.model.min_area.toString()+" "+widget.model.area_name,style: new TextStyle(fontFamily: "regular",color:ColorFile.black,fontSize: 16),),
                              )),
                              new Container(
                                child:new Text("to",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 16),),
                              ),
                              Expanded(child:new Container(
                                alignment: Alignment.center,
                                child:new Text(widget.model.max_area.toString()+" "+widget.model.area_name,style: new TextStyle(fontFamily: "regular",color:ColorFile.black,fontSize: 16),),
                              )),
                            ],
                          )
                      ),
                      RangeSlider(
                        values:area_range,
                        min: 0,
                        max: 5000,
                        divisions: 10,
                        onChanged: (RangeValues values) {
                          setState(() {
                            widget.model.max_area=values.end;
                            widget.model.min_area=values.start;
                            area_range = values;
                          });
                        },


                      ),
                      new SizedBox(height: 30,),
                    ],
                  )

                ],
              ),
            )

        ),
      ),
      bottomNavigationBar:
      new InkWell(
        onTap: () async {
          widget.model.filter_apply=true;
          widget.model.city=city.text.toString();
          widget.model.prop_name=project_name.text.toString();
          Navigator.pop(context,widget.model);
          add_in_recent_city();


        },
        child: new Container(
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(5),
              color: ColorFile.app_color,
            ),
            margin: EdgeInsets.only(left: 20,right: 20),
            height: 50,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Text("Apply",style: new TextStyle(fontFamily: "medium",color: ColorFile.white,fontSize: 17),),
              ],
            )

        ),
      ),
    );
  }
  void area_picker() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
            child:Bottom_sheet_For_Area(widget.model.measurement,widget.model.area_id,onSelectionChanged: (value){
              if(value!=null){
                setState(() {
                  Measurement_Unit model=value;
                  widget.model.area_id=model.id;
                  widget.model.area_name=model.name;
                });}
            },),
          );
        });

  }

  void clear_all_filter() {

    widget.model.min_budget=0;
    widget.model.max_buget=200000000;
    widget.model.min_area=0;
    widget.model. max_area=5000;

    widget.model.filter_apply=false;
    widget.model.room_list.forEach((element) {
      element.checked=false;
    });
    widget.model.room_list.forEach((element) {
      element.checked=false;
    });
    widget.model.res.forEach((element) {
      element.checked=false;
    });  widget.model.com.forEach((element) {
      element.checked=false;
    });
    widget.model.posted_by.forEach((element) {
      element.checked=false;
    });widget.model.furnishing.forEach((element) {
      element.checked=false;
    });widget.model.project_status.forEach((element) {
      element.checked=false;
    });
    widget.model.area_id="2";
    widget.model.filter_apply=false;
    widget.model.area_name="Sq.ft.";
    widget.model.prop_name="";
    Navigator.pop(context,widget.model);
  }
  Future<void> add_in_recent_city() async {
    var _map = new Map<String, String>();
    _map['city_name'] = city.text.toString();
     await DatabaseService().insert_city(new Rec_city(city_name: city.text.toString()));




  }

}