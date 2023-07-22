import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Cost_Sheet/Cost_Sheet_Details.dart';
import 'package:peprop_consumer_app/Models/RM_Inventory_Model.dart';
import 'package:peprop_consumer_app/Requirements/Requirement_Booking.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/Form_Title.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Book_Now/Booking/Book_Now_Model.dart';
import '../Book_Now/Form_Property_Model.dart';
import '../Global_connection/Global_connection.dart';
import '../Properties/View_Property_Model.dart';
import '../Utils/FireBase_Logs.dart';
import '../widgets/Bottom_Button.dart';
import '../widgets/Form_Fields.dart';
import '../wish_list/Styles.dart';

class Requirements_Descriptions extends StatefulWidget {

  String property_preference_id = "";
  String lead_id = "";

  Requirements_Descriptions(String propertyPreferenceId, String lead_id) {
    this.property_preference_id = propertyPreferenceId;
    this.lead_id = lead_id;


  }

  @override
  State<StatefulWidget> createState() {
    return Build_Statess();
  }
}

class Build_Statess extends State<Requirements_Descriptions> {


  bool get_data = false;

  List<RM_Inventory_Model> rm_list = [];

  bool is_cost_visible=false;
  bool update=false;
  View_Property_Model? view_property_model;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppUtils.appBar(context, "My Leads"),
      body: (rm_list.length > 0)
          ? Stack(
              children: [
                get_data == true
                    ? Center(child: new CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: new Column(
                          children: [
                            new Container(
                              child: new Column(
                                children: [
                                   if(rm_list.length>0)new Container(
                                    margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: new Column(
                                      children: [
                                        new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                                          children: [
                                            new Container(
                                              height: 50,
                                              decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.light_blue),
                                              child:
                                              new Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  new Text("Project Details",style: Styles().styles_bold(16, ColorFile.white),)
                                                ],),),
                                            new Container(
                                              padding: EdgeInsets.all(10),
                                              child: new Column(
                                                children: [
                                                  Form_Title("Project Name","Builder Name"),
                                                  new SizedBox(height: 5,),
                                                  Form_Title_content(rm_list[0].PropertyTitle.toString(),rm_list[0].fullname.toString()),
                                                  new SizedBox(height: 10,),

                                                  Form_Title2("Address",),
                                                  new SizedBox(height: 5,),
                                                  Form_Title2_content(rm_list[0].Address),
                                                  new SizedBox(height: 10,),




                                                ],
                                              ),),



                                          ],
                                        ),),
                                     
                                      ],
                                    )



                                  ),
                                   if(rm_list.length>0)new Container(
                                          margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                                          width: MediaQuery.of(context).size.width,
                                          child: new Column(
                                            children: [
                                              new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                                                children: [
                                                  new Container(height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.light_blue),child:new Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        new Text("RM/Channel Partner Details",style: Styles().styles_bold(16, ColorFile.white),)
                                                      ],),),
                                                  new Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: new Column(
                                                      children: [
                                                        Form_Title("Name","Mobile"),
                                                        new SizedBox(height: 5,),
                                                        Form_Title_content(rm_list[0].rm_name.toString(),"+91- "+rm_list[0].rm_mobile.toString()),
                                                        new SizedBox(height: 10,),

                                                        Form_Title2("Email",),
                                                        new SizedBox(height: 5,),
                                                        Form_Title2_content(rm_list[0].rm_email),
                                                        new SizedBox(height: 10,),




                                                      ],
                                                    ),),
                                                  new InkWell(child: new Container(height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.yellowdark),child:new Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      new Icon(Icons.call,color: ColorFile.white,),
                                                      new SizedBox(width: 10,),
                                                      new Text("Call",style: Styles().styles_bold(16, ColorFile.white),)
                                                    ],),),onTap: (){AppUtils().open_dialer("+91-"+rm_list[0].rm_mobile.toString());},)




                                                ],
                                              ),),

                                            ],
                                          )



                                      ),
                                   new Padding(padding: EdgeInsets.only(bottom: 20),child: ListView.builder(
                                       itemCount: rm_list.length,
                                       shrinkWrap: true,
                                       physics: NeverScrollableScrollPhysics(),
                                       itemBuilder: (context, index) {
                                         return _inventoryDetails(index);
                                       },
                                     ),),



                                  
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                if(update==true)Center(child: new CircularProgressIndicator(),),
              ],
            )
          : (get_data)
              ? Center(child: CircularProgressIndicator())
              : No_Data_Placeholder("No inventory Available..!!"),




    );
  }

  Widget _inventoryDetails(int index) {
    if(rm_list[index].is_approved.toString()=="1"){
      is_cost_visible=true;
      // setState(() {
      //
      // });
    }


    return

      Card(
      margin: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
      child: Container(

        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: new Column(children: [
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                children: [
                  new Container(
                    height: 50,
                    decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.app_color),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text("Unit Details",style: Styles().styles_bold(16, ColorFile.white),)
                      ],),),


                  new Container(
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      children: [
                        Form_Title("Unit Type","Unit Area"),
                        new SizedBox(height: 5,),
                        Form_Title_content(rm_list[index].unit_type.toString()==""?"N/A":rm_list[index].unit_type.toString(),rm_list[index].unit_area.toString()==""?"N/A":rm_list[index].unit_area.toString()+"Sq.ft."),
                        new SizedBox(height: 10,),

                        Form_Title("Tower","Floor"),
                        new SizedBox(height: 5,),
                        Form_Title_content(rm_list[index].tower_name.toString()==""?"N/A":rm_list[index].tower_name.toString(),rm_list[index].floor_no.toString()==""?"N/A":rm_list[index].floor_no.toString()),
                        new SizedBox(height: 10,),

                        Form_Title("Unit No.","Approximate Price"),
                        new SizedBox(height: 5,),
                        Form_Title_content(rm_list[index].unit_no.toString(),"₹ "+AppUtils().price(rm_list[index].total_unit_price.toString())),
                        new SizedBox(height: 10,),



                      ],
                    ),),



                ],
              ),),
              new SizedBox(height: 20,),



              new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                children: [
                  new Container(height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.app_color), child:new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [new Text("Location & Preference",style: Styles().styles_bold(16, ColorFile.white),)],),),
                  new Container(
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      children: [
                        Form_Title("View","Facing"),
                        new SizedBox(height: 5,),
                        Form_Title_content(rm_list[index].view.toString()==""?"N/A":rm_list[index].view.toString(),rm_list[index].facing.toString()==""?"N/A":rm_list[index].facing.toString()),
                        new SizedBox(height: 10,),



                        // Form_Title2("Furnishing Status"),
                        // new SizedBox(height: 5,),
                        // Form_Title2_content(rm_list[index].furnishing_type.toString()==""?"N/A":rm_list[index].furnishing_type.toString()),
                        // new SizedBox(height: 10,),



                      ],
                    ),),



                ],
              ),),
              new SizedBox(height: 20,),

              new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                children: [
                  new Container(height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.app_color), child:new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [new Text("Payment",style: Styles().styles_bold(16, ColorFile.white),)],),),
                  new Container(
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      children: [
                        Form_Title("Payment Plan","Payment Type"),
                        new SizedBox(height: 5,),
                        Form_Title_content(rm_list[index].plan_name.toString()==""?"N/A":rm_list[index].plan_name.toString(),rm_list[index].payment_type.toString()==""?"N/A":rm_list[index].payment_type.toString()),
                        new SizedBox(height: 10,),




                        //
                        // Form_Title("Booking Amount Type","Booking Amount"),
                        // new SizedBox(height: 5,),
                        // Form_Title_content(rm_list[index].booking_amount_type.toString()==""?"N/A":rm_list[index].booking_amount_type.toString()=="1"?"Fixed":"Percentage",rm_list[index].booking_amount.toString()==""?"N/A":rm_list[index].booking_amount.toString()),
                        // new SizedBox(height: 10,),
                        //
                        //
                        // Form_Title("Power Back Up","Plc & Other Charges"),
                        // new SizedBox(height: 5,),
                        // Form_Title_content(rm_list[index].pow_backup.toString()==""?"N/A":rm_list[index].pow_backup.toString(),rm_list[index].plc.toString()==""?"N/A":rm_list[index].plc.toString()),
                        // new SizedBox(height: 10,),
                        //
                        //
                        // Form_Title("Discount Type","Discount(₹/%)"),
                        // new SizedBox(height: 5,),
                        // Form_Title_content(rm_list[index].discount_type.toString()==""?"N/A":rm_list[index].discount_type.toString()=="1"?"Fixed":"Percentage",rm_list[index].discount_amount.toString()==""?"N/A":rm_list[index].discount_amount.toString()),
                        // new SizedBox(height: 10,),
                        //
                        //
                        // Form_Title2("Approximate Cost after Builder & Broker Discount(₹)"),
                        // new SizedBox(height: 5,),
                        // Form_Title2_content(rm_list[index].cost.toString()==""?"N/A":rm_list[index].cost.toString()),
                        // new SizedBox(height: 10,),
                        // if(rm_list[index].cost.toString().length>0)new Container(
                        //       margin: EdgeInsets.only(top: 10),
                        //       child:new Row(
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         mainAxisAlignment: MainAxisAlignment.end,
                        //         children: [
                        //           new Text(AppUtils.convertCurrency(rm_list[index].cost.toString()),style: new TextStyle(fontSize: 17,fontFamily: "regular"),)
                        //
                        //         ],
                        //       )
                        //   ),
                        new SizedBox(height: 10,),

                        if(rm_list[index].is_approved.toString()=="0")
                          new Container(
                              child:  new Row
                                (
                                children: [
                                  Expanded(child:InkWell(child:  new Container(alignment: Alignment.center,height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),),color: ColorFile.greens),child: new Text("Mark Interested",style: Styles().styles_medium(12, ColorFile.white),),),onTap: (){
                                    accept_or_not("1",rm_list[index].id.toString(),index);
                                  },)),
                                  Expanded(child:InkWell(child:  new Container(alignment: Alignment.center,height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10),),color: ColorFile.red_900),child: new Text("Mark Not Interested",style: Styles().styles_medium(12, ColorFile.white))),onTap: (){
                                    accept_or_not("2", rm_list[index].id.toString(),index);
                                  },))


                                ],
                              )),

                        if(rm_list[index].is_approved.toString()=="1")
                          new Container(
                              child:  new Row
                                (
                                children: [
                                  Expanded(child:InkWell(child:  new Container(alignment: Alignment.center,height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.greens),child: new Text("Hold Now",style: Styles().styles_medium(12, ColorFile.white),),),onTap: (){

                                    get_property_details(widget.property_preference_id,rm_list[index]);


                                  },)),


                                ],
                              )),

                        if(rm_list[index].is_approved.toString()=="2")
                          new Container(
                              child:  new Row
                                (
                                children: [
                                  Expanded(child:InkWell(child:  new Container(alignment: Alignment.center,height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.red_900),child: new Text("Not Interested",style: Styles().styles_medium(12, ColorFile.white),),),onTap: (){


                                  },)),


                                ],
                              )),
                      ],
                    ),),



                ],
              ),),
              new SizedBox(height: 20,),





















            ],
          )





        ],),

      ),
    );
  }

  Future<void> getDetails() async {

    await  FireBase_Logs().log_screen_view("View All Inventory", "View All Inventory");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String mobile = sharedPreferences.getString("mobile")!;
    var map = <String, dynamic>{};
    map['prop_id'] = widget.property_preference_id.toString();
    map['mobile'] = mobile;
    map['lead_id'] =widget.lead_id.toString();
    print(map.toString());
    FormData formData = new FormData.fromMap(map);
    setState(() {
      get_data = true;
    });
    ServiceConfig().postApiBodyAuthJson(API.getRequirementRMCustomer, formData, context).then((value) {
      Response response = value;
      if (response != null && response.statusCode == 200) {
        var notify = response.data["data"] as List;
        rm_list = notify.map<RM_Inventory_Model>((json) => RM_Inventory_Model.fromJson(json)).toList();
        method();
        setState(() {
          get_data = false;
        });
      } else {
        setState(() {
          get_data = false;
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        AppUtils.toAst(error.toString(),context);
        get_data = false;
      });
    });
  }



  Future<void> accept_or_not(String status, String id, int index) async {
    setState(() {
      update=true;
    });
    var map = Map<String, dynamic>();
    map['id'] =id.toString();
    map['status'] =status.toString();
    print(map);


    // FormData formData = FormData.fromMap(map);
    Response response =await ServiceConfig().postApiBodyAuthJson(API.inventoryAcceptReject, map, context);
    if(response.statusCode!=null &&response.statusCode==200){
      rm_list[index].is_approved=status.toString();
      method();
    }
    setState(() {
      update=false;
    });

  }


  void method() {
    int  count = (rm_list.where((i) => i.is_approved == "1".toString()).toList().length);
    if(count>0){
      is_cost_visible=true;
    }
  }

  Future<void> get_property_details(String property_preference_id, RM_Inventory_Model rm_list) async {
    SharedPreferences sp=await SharedPreferences.getInstance();
    setState(() {
      update=true;
    });
    Map data={"property_id":property_preference_id,'user_id':sp.getString("user_id").toString()};

    print(json.encode(data));



    var response=await Global_connection().post_method(data, context, API.gePropertyListByPropId);
    print(response.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200){
      if(response.data["list"]!=null){
        var builder_details = response.data["list"];
        view_property_model = View_Property_Model.fromJson(builder_details);
        Form_Property_Model model=Form_Property_Model();
        model.property_title=view_property_model!.PropertyTitle!.toString();
        model.image=view_property_model!.FeatureImageUrl!.toString();
        model.logo=view_property_model!.logo!.toString();
        model.rera=view_property_model!.Rera!.toString();
        model.addess=view_property_model!.loc_name!.toString()+" , "+view_property_model!.city_name!.toString()+" - "+view_property_model!.state_name!.toString()+" , "+view_property_model!.country_name!.toString();
        model.booking_min_amount=view_property_model!.booking_min_amount!.toString();;
        model.booking_max_amount=view_property_model!.booking_max_amount!.toString();;
        model.booking_option="1";
        model.property_id=widget.property_preference_id;
        model.BuilderId=view_property_model!.BuilderId!.toString();
        model.view_property_model=view_property_model;
        Book_Now_Model book_now_model=new Book_Now_Model();
        book_now_model.form_property_model=model;
        book_now_model.inventory_data=rm_list;
        book_now_model.lead_id= widget.lead_id.toString();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Requirement_Booking(book_now_model)));





      }

    }



    setState(() {
      update = false;

    });

  }




}