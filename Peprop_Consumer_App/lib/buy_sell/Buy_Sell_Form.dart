

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Banners_Model.dart';
import 'package:peprop_consumer_app/Models/Listing_Filter_Model.dart';
import 'package:peprop_consumer_app/Models/Master_Model.dart';
import 'package:peprop_consumer_app/Models/Search_Model.dart';
import 'package:peprop_consumer_app/Models/buy/Property_Kind.dart';
import 'package:peprop_consumer_app/Search/Search_Property_Buy.dart';
import 'package:peprop_consumer_app/Search/Search_Property_Globally.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/buy_sell/Area_Buy_Sell_Filed.dart';
import 'package:peprop_consumer_app/buy_sell/Budget_Field.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/Bhk_Sheet.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/For_Kind_property.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/For_Availability.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/For_Property_Type.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/Funding_Purpose_Sheet.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/Furnishing_Sheet.dart';
import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Filters/Bottom_sheet_For_Area.dart';
import '../Models/City_Model.dart';
import '../Search/Search_City.dart';
import '../Utils/Lg.dart';
import '../widgets/App_Banners.dart';
import '../widgets/Form_Drop_Down.dart';
import '../widgets/Form_Fields.dart';
import '../widgets/Buy_Sale_Header.dart';
import '../widgets/Multiple_Select_Widget.dart';
import 'package:http_parser/http_parser.dart';

class Buy_Sell_Form extends StatefulWidget {
  String lease_type="";
  Home_List_Model? model;
  Buy_Sell_Form(String lease_type, Home_List_Model? model){
    this.lease_type=lease_type;
    this.model=model;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }


}

class BuildState extends State<Buy_Sell_Form>{

  bool loading=false;
  List<Property_Kind>kind_property_list=[];



  List<Property_Kind>type_list=[];


  List<Property_Kind>possession_by=[];


  List<Property_Kind>bhk=[];
  List<Property_Kind>floor_list=[];


  List<PropertyType>all_cat_list=[];
  List<Furnishing_Model>furnishing=[];
  List<Measurement_Unit> area_list=[];

  List<PropertyType> property_type_list = [];
  List<Availability_Model>availability =[];
  List<Master_Model>funding =[];
  List<Master_Model>purpose =[];
  double start=0;
  double end=200000000;
  late RangeValues _currentRangeValues;
  late RangeValues area_range;


  double min_area=0;
  double max_area=5000;
  var  selected_kind_model=null;
  var  selected_possesion=null;



  var  availability_model=null;

  var  furnishing_model=null;

  var  selectedproperty_type=null;
  var  selectedfurnishing=null;
  var  model=null;
  var  funding_model=null;
  var  purpose_model=null;
  var  unit_model=null;
  var  floor_model=null;



  List<Asset> images = <Asset>[];


  final budget =TextEditingController();

  String kind_prop_id="";
  final city=TextEditingController();
  final project_name=TextEditingController();
  final locality=TextEditingController();
  final expected=TextEditingController();



  String property_type_id="1";
  String area_id="2";
  String area_name="Sq.ft.";

  final Area=TextEditingController();
  String city_id="Sq.ft.";
  String selection_type="";



  int type=1;
  bool is_edit_locality=false;
  bool update=false;

  List<Banners_Model>banner_list=[];
  List<String> selected_bhk = [];
  List<String> floor = [];

  @override
  void initState() {
    kind_property_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "Residential"));
    kind_property_list.add(new Property_Kind(proj_tpye_id: "2", proj_type_name: "Commercial"));
    type_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "Buy"));
    type_list.add(new Property_Kind(proj_tpye_id: "2", proj_type_name: "Sell"));
    selection_type=widget.lease_type;

    possession_by.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "3-6 Months"));
    possession_by.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "6-9 Months"));
    possession_by.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "9-12 Months"));
    possession_by.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "1+ Years"));
    possession_by.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "Ready to move"));

    bhk.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "1 BHK"));
    bhk.add(new Property_Kind(proj_tpye_id: "2", proj_type_name: "2 BHK"));
    bhk.add(new Property_Kind(proj_tpye_id: "3", proj_type_name: "3 BHK"));
    bhk.add(new Property_Kind(proj_tpye_id: "4", proj_type_name: "4 BHK"));
    bhk.add(new Property_Kind(proj_tpye_id: "5", proj_type_name: "5 BHK"));
    bhk.add(new Property_Kind(proj_tpye_id: "6", proj_type_name: "6 BHK"));
    bhk.add(new Property_Kind(proj_tpye_id: "7", proj_type_name: "7 BHK"));
    bhk.add(new Property_Kind(proj_tpye_id: "8", proj_type_name: "8 BHK"));
    bhk.add(new Property_Kind(proj_tpye_id: "9", proj_type_name: "9 BHK"));
    bhk.add(new Property_Kind(proj_tpye_id: "10", proj_type_name: "10 BHK"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "0"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "1"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "2"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "3"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "4"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "5"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "6"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "7"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "8"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "9"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "10"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "11"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "12"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "13"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "14"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "15"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "16"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "17"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "18"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "19"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "20"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "21"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "22"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "23"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "24"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "25"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "26"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "27"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "28"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "29"));
    floor_list.add(new Property_Kind(proj_tpye_id: "1", proj_type_name: "30"));






    _currentRangeValues =  RangeValues(0,200000000);
    area_range =  RangeValues(0, 5000);

    super.initState();
    get_masters();
    get_banners();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppUtils.appBar(context, "title"),
        body:   Stack(
          children: [
            loading==true?Center(child: new CircularProgressIndicator(),):Padding(padding: EdgeInsets.all(10),child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(widget.model!=null&&widget.model!.sliders.length>0)App_Banners(widget.model!.sliders,context),
                  if(widget.lease_type=="")
                    new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Buy_Sale_Header("Looking to"),For_Kind_property(type_list,
                        onSelectionChanged: (selectedList) {
                          setState(() {
                            selection_type=selectedList.proj_tpye_id;
                            reset_list();
                          });
                        },
                      ),


                    ],
                  ),
                  if(selection_type!="")
                    new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Buy_Sale_Header("Please Select Property Type"),
                      For_Kind_property(kind_property_list,
                        onSelectionChanged: (selectedList) {
                          setState(() {
                            if(selectedList!=null){
                              selected_kind_model = selectedList;
                              method(selected_kind_model.proj_tpye_id);
                            }
                          });
                        },
                      ),
                    ],
                  ),

                  if(selected_kind_model!=null)new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(selected_kind_model!=null)new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Buy_Sale_Header("Let Us Know More About The Property"),
                          For_Property_Type(
                            property_type_list,
                            selectedproperty_type,
                            onSelectionChanged: (selectedList) {
                              setState(() {
                                if(selectedList!=null){
                                  selectedproperty_type=selectedList;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Buy_Sale_Header("Choose your City"),InkWell(onTap: () async {
                        var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_City()));
                        if (pageResult != null) {
                          setState(() {
                            City_Model model = pageResult;
                            city.text=model.city_name;
                            city_id=model.city_id;
                          });
                        }
                      },child:Container(child: Row(children: [Expanded(child: Container( child: Form_Fields().non_editable_text("Search City.", city,),))]))),


                      if(selected_kind_model!=null&&city.text.toString().length>0) new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Buy_Sale_Header("Select Project"),
                          InkWell(onTap: () async {
                            var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_Property_Buy(city.text.toString(),int.parse(selected_kind_model.proj_tpye_id))));
                            if(pageResult!=null){
                              model=pageResult;
                              setState(() {
                                project_name.text=model.property_name;
                                locality.text=model.location;

                              });

                            }


                          },child:Container(child: Row(children: [Expanded(child: Container( child: Form_Fields().non_editable_text("Project Name", project_name,),))]))),
                        ],
                      ),


                      if(model!=null&&model.id.toString()=="0")new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Buy_Sale_Header("Locality"),
                          Form_Fields().locality("Locality", locality, false),

                        ],
                      ),



                      if(model!=null&&model.id.toString()!="0")new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Buy_Sale_Header("Locality"),
                          Form_Fields().locality("Locality", locality, true),

                        ],
                      ),


                      if(selected_kind_model!=null&&selected_kind_model.proj_tpye_id=="1") new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Buy_Sale_Header("Select Unit Type"),
                          new Container(
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            height: 40,
                            child: new Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection:
                                      Axis.horizontal,
                                      itemCount:bhk.length,
                                      itemBuilder: (BuildContext
                                      context,int index) =>
                                      new GestureDetector(
                                        onTap: () {
                                          if(selection_type!="2"){
                                            setState(() {
                                              bhk[index].is_checked= !bhk[index].is_checked;
                                            });
                                          }
                                          else{
                                            bhk.forEach((element) {
                                              element.is_checked=false;

                                            });
                                            setState(() {
                                              bhk[index].is_checked=!bhk[index].is_checked;

                                            });

                                            // List<Property_Kind> count =(bhk.where((i) => i.is_checked ==true).toList());
                                            // if(count.length==0){
                                            //   setState(() {
                                            //     bhk[index].is_checked=!bhk[index].is_checked;
                                            //   });
                                            // }
                                          }

                                        },
                                        child:Multiple_Select_Widget(bhk[index]),
                                      )),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Buy_Sale_Header("Select Preferred Floors"),
                          new Container(
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            height: 40,
                            child: new Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection:
                                      Axis.horizontal,
                                      itemCount:floor_list.length,
                                      itemBuilder: (BuildContext
                                      context,int index) =>
                                      new GestureDetector(
                                        onTap: () {
                                          if(selection_type!="2"){
                                            setState(() {
                                              floor_list[index].is_checked= !floor_list[index].is_checked;
                                            });
                                          }else{

                                            floor_list.forEach((element) {
                                              element.is_checked=false;

                                            });
                                            setState(() {
                                              floor_list[index].is_checked=!floor_list[index].is_checked;

                                            });

                                          }

                                        },
                                        child:Multiple_Select_Widget_Round(floor_list[index]),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),


                      if(selection_type.toString()=="1")new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Buy_Sale_Header("Possession by"),For_Kind_property(possession_by,
                            onSelectionChanged: (selectedList) {
                              setState(() {
                                if(selectedList!=null){
                                  selected_possesion = selectedList;

                                }
                              });
                            },
                          ),
                        ],
                      ),

                      Buy_Sale_Header("Furnishing Status"),
                      Furnishing_Sheet(
                        furnishing,
                        onSelectionChanged: (selectedList) {
                          setState(() {
                            furnishing_model=selectedList;


                          });
                        },
                      ),


                      if(selection_type!="2")new Container(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Buy_Sale_Header("Funding Source"),
                            Funding_Purpose_Sheet(
                              funding,
                              onSelectionChanged: (selectedList) {
                                setState(() {
                                  funding_model=selectedList;


                                });
                              },
                            ),

                            Buy_Sale_Header("Purpose"),
                            Funding_Purpose_Sheet(
                              purpose,
                              onSelectionChanged: (selectedList) {
                                setState(() {
                                  purpose_model=selectedList;
                                });
                              },
                            ),
                          ],
                        ),
                      ),




                      Budget_Field(selection_type=="1"?"Budget":"Sell Price", budget, 12, false, false,on_changed: (String){
                        setState(() {

                        });

                      },),
                      Area_Buy_Sell_Filed("Area",Area,6,true,false,area_name,on_changed: (){
                        area_picker();

                      },),




                      SizedBox(height: 20,),


                    ],
                  ),

                  if(selection_type=="2")new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        child: new Text("Adding 4 + photos might increase response on your project ad.",style: new TextStyle(fontFamily: "regular",color:ColorFile.hexblack,fontSize: 12),),
                      ),
                      new SizedBox(height: 30,),
                      images.length==0?
                      new InkWell(child: new Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        color: ColorFile.calls,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new Icon(Icons.image),
                            new SizedBox(height: 5,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add,color: ColorFile.app_color),
                                new Text("Add Photos",style: new TextStyle(fontFamily: "medium",fontSize: 13,color: ColorFile.app_color),)

                              ],
                            ),
                            new SizedBox(height: 5,),

                            new Container(
                              child: new Text("Click from camera or browse to upload",style: new TextStyle(fontFamily: "regular",color:ColorFile.hexblack,fontSize: 12),),
                            ),

                          ],
                        ),
                      ),onTap: (){
                        loadAssets();

                      },):new Container(),
                      images.length>0? new Container(
                        child: new Column(
                          children: [
                            new Container(margin: EdgeInsets.only(top: 10,left: 10), height: 150, child:new Row(children: [
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: images.length,
                                    itemBuilder: (BuildContext context, int index) =>
                                    new Container(
                                      decoration: new BoxDecoration(border: new Border.all(width: 1,color: ColorFile.hint_color)),
                                      margin: EdgeInsets.only(left: 5),
                                      child: new Stack(
                                        children: [
                                          new Container(
                                            height: 150,
                                            width: 150,
                                            child: AssetThumb(
                                              asset: images[index],
                                              width: 150,
                                              height: 150,
                                            ),

                                          ),
                                          new GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                images.removeAt(index);
                                              });
                                            },
                                            child: new Container(
                                              height: 17,
                                              width: 17,
                                              decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100), color: ColorFile.red_400),
                                              child: new Icon(
                                                Icons.clear,
                                                color: ColorFile.white,
                                                size: 13,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    )

                                ),
                              )
                            ],),),
                            new InkWell(child: new Container(
                              margin: EdgeInsets.only(top: 10),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add,color: ColorFile.app_color),
                                  new Text("Add More Photos",style: new TextStyle(fontFamily: "medium",fontSize: 13,color: ColorFile.app_color),)

                                ],
                              ),
                            ),onTap: (){
                              loadAssets();
                            },)
                          ],
                        ),
                      ):new Container(),

                    ],
                  ),





                ],
              ),
            ),),
            if(update)Center(child: new CircularProgressIndicator(),)

          ],
        ),



        bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Material(
              color: ColorFile.app_color,
              child: InkWell(
                onTap: () {
                  if(validate()){
                    save();


                  }

                },
                child:  SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text('Submit', style:Styles().styles_bold(15, ColorFile.white)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  void area_picker() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
            child:Bottom_sheet_For_Area(area_list,area_id,onSelectionChanged: (value){
              if(value!=null){
                setState(() {
                  Measurement_Unit model=value;
                  area_name=model.name;
                  area_id=model.id;


                });}
            },),
          );
        });

  }
  get_masters() async {
    setState(() {
      loading = true;
    });
    ServiceConfig().getApiAuth(API.all_master_datas, context).then((value) {
      Response response = value;
      setState(() {
        loading = false;
      });
      if (response != null && response.statusCode == 200) {

        var fa = response.data["list"]["furnishing"] as List;
        furnishing = fa.map<Furnishing_Model>((json) => Furnishing_Model.fromJson(json)).toList();


        var property_type = response.data["list"]["property_type"] as List;
        all_cat_list = property_type.map<PropertyType>((json) => PropertyType.fromJson(json)).toList();

        var avail = response.data["list"]["project_status"] as List;
        availability = avail.map<Availability_Model>((json) => Availability_Model.fromJson(json)).toList();

        var fund = response.data["list"]["funding"] as List;
        funding = fund.map<Master_Model>((json) => Master_Model.fromJson(json)).toList();

        var pur = response.data["list"]["lead_purpose"] as List;
        purpose = pur.map<Master_Model>((json) => Master_Model.fromJson(json)).toList();

        var ar = response.data["list"]["size"] as List;
        area_list = ar.map<Measurement_Unit>((json) => Measurement_Unit.fromJson(json)).toList();


        method("1");

      }
    }).catchError((error, stackTrace) {
      setState(() {
        AppUtils.toAst("Something Went Wrong..",context);
        loading = false;

      });
    });
  }
  get_banners() async {
    setState(() {

    });
    var map = new Map<String, dynamic>();
    map['type'] ="Electric";
    FormData formData = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.getBbpsimageData,formData, context).then((value) {
      Response response = value;
      setState(() {

      });
      if (response != null && response.statusCode == 200) {

        var fa = response.data["data"] as List;
        banner_list = fa.map<Banners_Model>((json) => Banners_Model.fromJson(json)).toList();


      }
    }).catchError((error, stackTrace) {
      setState(() {

      });
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: '#115093',
          actionBarTitle: "PeProp",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      AppUtils.toAst(e.toString(),context);
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());

      images = resultList;
      // _error = error;
    });
  }

  void method(String type) {
    property_type_list.clear();
    property_type_list = (all_cat_list.where((i) => i.property_category_id == type.toString()).toList());
  }

  bool validate() {
    selected_bhk.clear();
    floor.clear();


    if(widget.lease_type==""&&selection_type==""){
      AppUtils.toAst("Please Select looking For?",context);
      return false;
    }
    if(selected_kind_model==null){
      AppUtils.toAst("Please Select Kind of Property.!!",context);
      return false;
    } if(selectedproperty_type==null){
      AppUtils.toAst("Please Select Project Type.!!",context);
      return false;
    }if(city.text.length==0){
      AppUtils.toAst("Please Select City..!!",context);
      return false;
    }
    if(model!=null&&model.id.toString()=="0"){
    if(locality.text.length==0){
    AppUtils.toAst("Please Enter Locality..!!",context);
    return false;
      }}

      if(selected_kind_model!=null&&selected_kind_model.proj_tpye_id.toString()=="1"){
      bhk.forEach((element) {
        if(element.is_checked==true)selected_bhk.add(element.proj_type_name);
      });

      if(selected_bhk.isEmpty){
        AppUtils.toAst("Please Select Unit ",context);
        return false;
      }


    } if(selected_kind_model!=null&&selected_kind_model.proj_tpye_id.toString()=="2"){
      floor_list.forEach((element) {
        if(element.is_checked==true)floor.add(element.proj_type_name);
      });

      if(floor.isEmpty){
        AppUtils.toAst("Please Select Floor ",context);
        return false;
      }


    }




    return true;
  }

  Future<void> save() async {


    setState(() {
      update=true;
    });
    final prefs = await SharedPreferences.getInstance();

    String  mobile = prefs.getString('mobile').toString();
    String  name = prefs.getString('full_name').toString();

    String  email = prefs.getString('email').toString();

    var uri =Uri.parse(API.crm_customer_requirment_insert);
    var request = new http.MultipartRequest("POST", uri);

    if(selection_type=="2"){
      for (Asset image in images) {
        ByteData byteData = await image.getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        String time_stamp=new DateTime.now().millisecondsSinceEpoch.toString();
        var multipartFile = new http.MultipartFile.fromBytes('userfile[]',imageData,filename:time_stamp+".jpg", contentType: MediaType("image", "jpg"));
        request.files.add(multipartFile);

      }
    }
    request.fields['residential'] =selected_kind_model.proj_tpye_id=="1"?"1":"0";
    request.fields['commercial'] =selected_kind_model.proj_tpye_id=="2"?"1":"0";
    request.fields['lease'] =selection_type;
    request.fields['name'] =name;
    request.fields['mobile'] =mobile;

    if(budget.text.length>0){
      request.fields['budget'] =NumberFormat.compactCurrency(locale: 'en_IN',symbol: '₹ ').format(double.parse(budget.text.toString())).toString();
    }
    request.fields['bedroom'] =selected_bhk.join(",");
    request.fields['update_id'] ="0";
    request.fields['prefered_floor'] =floor.join(",");
    request.fields['area'] =Area.text.toString();
    request.fields['city'] = city_id.toString();
    request.fields['location'] = locality.text.toString();
    request.fields['projects'] =project_name.text.toString();
    if(selection_type=="1"){
      request.fields['purpose'] =purpose_model!=null?purpose_model.purpose_id:"";
      request.fields['source'] = funding_model!=null?funding_model.id:"";
      request.fields['possession_by'] =selected_possesion!=null? selected_possesion.proj_type_name:"";
    }


    request.fields['email'] = email;
    request.fields['property_type'] =selectedproperty_type.id;
    request.fields['furnishing'] =furnishing_model!=null? furnishing_model.id:"";
    request.fields['area_type'] = area_id;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {"Accept": "application/json", "Authorization": sharedPreferences.getString("token").toString()}; // ignore this headers if there is no authentication

    request.headers.addAll(headers);
    var response = await request.send();
    setState(() {
      update = false;
    });

    response.stream.transform(utf8.decoder).listen((value) {
      print(uri.toString()+" post requirements response"+value.toString());

    });
    if (response.statusCode == 200) {
      AppUtils.toAst("Listing Created Successfully!",context);

      Navigator.pop(context);

    } else {
      AppUtils().show_error(context,"Connection Timeout!");
    }





}

  void reset_list() {
    bhk.forEach((element) {
      element.is_checked=false;
    });
    floor_list.forEach((element) {
      element.is_checked=false;
    });


  }

}