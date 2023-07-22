


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Cost_Sheet/Cost_Property.dart';

import 'package:peprop_consumer_app/Cost_Sheet/Pay_Milestone_Model.dart';
import 'package:peprop_consumer_app/Cost_Sheet/model/Builder_Detail_Model.dart';
import 'package:peprop_consumer_app/Cost_Sheet/payment/Other_Payment_Form_For_MileStone.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widgets/Form_Title.dart';
import '../wish_list/Styles.dart';




class Cost_Sheet_Details extends StatefulWidget{
  String lead_id="";
  String prop_id="";
  Cost_Sheet_Details(String lead_id, String prop_id){
    this.lead_id=lead_id;
    this.prop_id=prop_id;


  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState() ;
  }

}
class BuildState extends State<Cost_Sheet_Details>{
  bool loading=false;
  Builder_Detail_Model? builder_detail_model;

  Customer_details? customer_details;

  String paid_status="1";

  Inventory_details_With_Price? inventory_details_with_price;
  ChannelPartnerDetail? channelPartnerDetail;
  Cost_Prop? cost_prop;


  List<MileStone>milestone_list=[];
  List<Others>others_list=[];
  List<Others>extra_aminities=[];


  String planName="";
  String inventoryStatus="";
  bool update=false;
  int payposition=-1;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    get_cost_details();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBarTitle(context, "Cost Sheet"),      
      body:Stack(
        children: [
          loading==true?Center(child: new CircularProgressIndicator(),): inventoryStatus!="null"&&builder_detail_model!=null&&(inventory_details_with_price!.costsheet_status=="1"||inventory_details_with_price!.costsheet_status=="2"||inventory_details_with_price!.costsheet_status=="3"||inventory_details_with_price!.costsheet_status=="4")?
          new SingleChildScrollView(
            child: new Column(
              children: [
                if(customer_details!=null)   new Container(
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      children: [

                        new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                          children: [
                            new Container(height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.light_blue), child:new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [new Text("Customer Details",style: Styles().styles_bold(16, ColorFile.white),)],),),
                            new Container(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  Form_Title("Name","Mobile"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(customer_details!.first_name.toString()+" "+customer_details!.last_name.toString(),customer_details!.mobile.toString()),
                                  new SizedBox(height: 15,),


                                  Form_Title("Email","Source Name"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(customer_details!.email.toString(),customer_details!.SourceName.toString()),
                                  new SizedBox(height: 15,),

                                  Form_Title2("Address",),
                                  new SizedBox(height: 5,),
                                  Form_Title2_content(customer_details!.address_1.toString()),
                                  new SizedBox(height: 15,),






                                ],
                              ),),



                          ],
                        ),),


                      ],
                    )

                ),


                if(builder_detail_model!=null)   new Container(
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      children: [

                        new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                          children: [
                            new Container(height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.light_blue), child:new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [new Text("Builder Details",style: Styles().styles_bold(16, ColorFile.white),)],),),
                            new Container(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  Form_Title("Company Name","Project RERA"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(builder_detail_model!.fullname.toString(),builder_detail_model!.Rera.toString()),
                                  new SizedBox(height: 15,),


                                  Form_Title("Project Name","PAN"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(builder_detail_model!.proj_name.toString(),builder_detail_model!.user_pan.toString()),
                                  new SizedBox(height: 15,),


                                  Form_Title("Company Address","Builder Address"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(builder_detail_model!.comp_address.toString(),builder_detail_model!.builder_address.toString()),
                                  new SizedBox(height: 15,),





                                ],
                              ),),



                          ],
                        ),),


                      ],
                    )

                ),





               if(cost_prop!=null)Cost_property(cost_prop),

                if(channelPartnerDetail!=null)   new Container(
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      children: [

                        new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                          children: [
                            new Container(height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.light_blue), child:new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [new Text("Channel Partner Details",style: Styles().styles_bold(16, ColorFile.white),)],),),
                              new Container(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  Form_Title("Name","Rera"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(channelPartnerDetail!.FullName.toString(),channelPartnerDetail!.rera_number.toString()),
                                  new SizedBox(height: 15,),


                                  Form_Title("Mobile","Email"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(channelPartnerDetail!.mobile.toString(),channelPartnerDetail!.email.toString()),
                                  new SizedBox(height: 15,),






                                ],
                              ),),



                          ],
                        ),),


                      ],
                    )

                ),

                if(inventory_details_with_price!=null)   new Container(
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      children: [

                        new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                          children: [
                            new Container(height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.light_blue), child:new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [new Text("Inventory Details With Price",style: Styles().styles_bold(16, ColorFile.white),)],),),
                            new Container(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  Form_Title("Property Name","Tower Selected"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(inventory_details_with_price!.property_name.toString(),inventory_details_with_price!.tower_id.toString()),
                                  new SizedBox(height: 15,),


                                  Form_Title("Floor","Unit Number"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content( Styles.stripHtmlIfNeeded(inventory_details_with_price!.floor_id.toString()),inventory_details_with_price!.unit_no.toString()),
                                  new SizedBox(height: 15,),


                                  Form_Title("Super Area","Carpet Area"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(inventory_details_with_price!.super_area.toString(),inventory_details_with_price!.carpet_area.toString()),
                                  new SizedBox(height: 15,),


                                  Form_Title("Common Area","Build-up Area"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(inventory_details_with_price!.common_area.toString(),inventory_details_with_price!.build_up_area.toString()),
                                  new SizedBox(height: 15,),


                                  Form_Title("Basic Price","Furnishing Charges"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content("₹"+inventory_details_with_price!.price.toString(),"₹"+inventory_details_with_price!.furnishing_amount.toString()),
                                  new SizedBox(height: 15,),




                                  Form_Title("Discount Offered","Total Amount"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content("₹"+inventory_details_with_price!.discount_amount.toString(),"₹"+inventory_details_with_price!.net_amount.toString()),
                                  new SizedBox(height: 15,),


                                  Form_Title("Unit Type","Payment Plan"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(inventory_details_with_price!.UnitName.toString(),planName.toString()),
                                  new SizedBox(height: 15,),










                                ],
                              ),),



                          ],
                        ),),


                      ],
                    )

                ),





                if(others_list.length>0)new Container(child: new Text("Other Charges",style: new TextStyle(fontFamily: "medium",fontSize: 17),),),
                new Container(

                 child:  ListView.builder(
                   itemCount: others_list.length,
                   shrinkWrap: true,
                   scrollDirection: Axis.vertical,
                   physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (context, index) {
                     return Card(
                       margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                       child: Container(
                         padding: EdgeInsets.all(10),
                         width: MediaQuery.of(context).size.width,
                         child: new Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             new Container(child: new Text(others_list[index].charge_title.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 16,color: ColorFile.selectd_color),),),
                             new SizedBox(height: 10,),
                             new Container(child: new Text(others_list[index].is_chargable.toString()=="0"?"FOC":"Chargeable",style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
                             new SizedBox(height: 10,),
                             if(others_list[index].mandatory_price.toString()!="") new Container(child: new Text(others_list[index].mandatory_unit_num.toString()+" ( ₹ "+others_list[index].mandatory_price.toString()+") Mandatory",style: new TextStyle(fontFamily: "regular",fontSize: 14,color: ColorFile.red_900),),),
                             if(others_list[index].mandatory_price.toString()!="")  new SizedBox(height: 10,),


                             if(others_list[index].total_amount.toString()!="")new Container(child: new Text("Amount: ₹"+others_list[index].total_amount.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
                             new SizedBox(height: 10,),



                           ],),

                       ),
                     );


                   },

                 ),
               ),

                if(extra_aminities.length>0)new Container(child: new Text("Extra Amenities",style: new TextStyle(fontFamily: "medium",fontSize: 17),),),
                new Container(child:
                ListView.builder(
                    itemCount: extra_aminities.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Container(child: new Text(extra_aminities[index].title.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 16,color: ColorFile.selectd_color),),),
                              new SizedBox(height: 10,),


                              if(extra_aminities[index].mandatory_price.toString()!="") new Container(child: new Text(extra_aminities[index].mandatory_unit_num.toString()+" ( ₹ "+extra_aminities[index].mandatory_price.toString()+") Mandatory",style: new TextStyle(fontFamily: "regular",fontSize: 14,color: ColorFile.red_900),),),
                              if(extra_aminities[index].mandatory_price.toString()!="")  new SizedBox(height: 10,),

                              new Container(child: new Text("Price  : "+extra_aminities[index].charge_amount.toString()+" "+extra_aminities[index].unit_name.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
                              new SizedBox(height: 10,),
                              new Container(child: new Text("Extra Demand : "+extra_aminities[index].qtys.toString()+" "+extra_aminities[index].unit_name.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
                              new SizedBox(height: 10,),

                              new Container(child: new Text("Amount: ₹ "+extra_aminities[index].total_amount.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
                              new SizedBox(height: 10,),



                            ],),

                        ),
                      );


                    },

                  ),
                ),

                ListView.builder(
                  itemCount: milestone_list.length,
                  controller: _controller,
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    String paid_status=milestone_list[index].paid_status;
                    if(paid_status=="0"&&payposition==-1){
                      payposition=index;
                    }

                    return
                      Card(
                      margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(child: new Text("MileStone "+(index+1).toString(),style: new TextStyle(fontFamily: "bold",fontSize: 16,color: ColorFile.selectd_color),),),
                            new SizedBox(height: 10,),
                            new Container(child: new Text("MileStone: "+milestone_list[index].MileStoneName+"("+milestone_list[index].BSP+")",style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
                            new SizedBox(height: 10,),
                            new Container(child: new Text("Stage: "+(index+1).toString(),style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
                            new SizedBox(height: 10,),
                            new Container(child: new Text("Amount: ₹"+milestone_list[index].BasicInstallment.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
                            new SizedBox(height: 10,),
                           if(inventory_details_with_price!.costsheet_status=="3")
                             new Container(
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if(payposition==index)InkWell(
                                    onTap: () async {
                                      Pay_Milestone_Model model=new Pay_Milestone_Model();
                                      model.id=inventory_details_with_price!.lead_id.toString();
                                      model.invid=inventory_details_with_price!.lead_inventory_id.toString();
                                      model.planid=inventory_details_with_price!.payment_plan_id.toString();
                                      model.builderid=builder_detail_model!.builder_id.toString();
                                      model.mileStone=milestone_list[index];


                                      var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Other_Payment_Form_For_MileStone(model)));


                                      // var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Pay_MileStone(model,index)));



                                    },
                                    child: new Container(

                                      height: 40,
                                      child: new Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          new Container(
                                            padding: EdgeInsets.only(left: 10,right: 10),
                                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.yellowdark),
                                            alignment: Alignment.center,
                                            child: new Text("Pay Now",style: new TextStyle(fontSize: 12,color: ColorFile.white,fontFamily: "medium"),),
                                          )
                                        ],
                                      ),
                                    ),
                                  )


                                ],
                              ),
                            )



                          ],),

                      ),
                    );


                  },

                ),

              ],
            ),
          ):
          loading==false&&builder_detail_model==null?Center(child: new No_Data_Placeholder("No Cost Sheet linked with this Lead."),):Center(child: new No_Data_Placeholder("No Cost Sheet linked with this Lead."),),
          if(update)Center(child: new CircularProgressIndicator(),)
        ],
      ),

    );
  }



  void get_cost_details() {
    setState(() {
      loading = true;
    });
     payposition=-1;
    var map = Map<String, dynamic>();
    map['lead_id'] =widget.lead_id;
    map['prop_id'] =widget.prop_id.toString();
    print(json.encode(map));
    ServiceConfig().postApiBodyAuthJson(API.shareInventoryApi, map, context).then((value) {
      Response response = value;

      if (response != null && response.statusCode == 200) {
        print(response.data);
        if(response.data["data"]!=null&&response.data["data"]["data"]!=null) {
          if( response.data["data"]["data"]["BuilderDetail"]!=null){
            var builder_details = response.data["data"]["data"]["BuilderDetail"];
            builder_detail_model = Builder_Detail_Model.fromJson(builder_details);


          }


          inventoryStatus = response.data["data"]["data"]["inventoryStatus"].toString();
          if(response.data["data"]["milestonesdata"]!=null){
            var notify = response.data["data"]["milestonesdata"] as List;
            milestone_list =notify.map<MileStone>((json) => MileStone.fromJson(json)).toList();
          }




          if(response.data["data"]["inventorydata"]!=null){
            var inventorydata = response.data["data"]["inventorydata"];
            inventory_details_with_price = Inventory_details_With_Price.fromJson(inventorydata);

          }


          //
          planName = response.data["data"]["planName"].toString();
          //

          //
          //

          if(response.data["data"]["inventorydata"]["others"]!=null){
            var others_array = response.data["data"]["inventorydata"]["others"] as List;
            others_list =others_array.map<Others>((json) => Others.fromJson(json)).toList();
            others_list = (others_list.where((i) =>i.is_chargable.toString()=="0".toString()).toList());


          }


          if(response.data["data"]["inventorydata"]["extra_amenities"]!=null){
            var ext = response.data["data"]["inventorydata"]["extra_amenities"] as List;
            extra_aminities =ext.map<Others>((json) => Others.fromJson(json)).toList();

          }

          if(response.data["data"]["data"]["PropertyLocation"]!=null){
            var PropertyLocation = response.data["data"]["data"]["PropertyLocation"];
            cost_prop = Cost_Prop.fromJson(PropertyLocation);

          }



          if(response.data["data"]["data"]["customerDetail"]!=null){
            var cus = response.data["data"]["data"]["customerDetail"];
            customer_details = Customer_details.fromJson(cus);
          }




          if(response.data["data"]["data"]["ChannelPartnerDetail"]!=null){
            var ChannelPartner = response.data["data"]["data"]["ChannelPartnerDetail"];
            channelPartnerDetail = ChannelPartnerDetail.fromJson(ChannelPartner);
          }





        }

      }
      setState(() {
        loading = false;
      });
    }).catchError((onError){

      setState(() {
        loading = false;
      });
    });



  }

  void update_status(String status) {
    setState(() {
      update = true;
    });

    var map = Map<String, dynamic>();
    map['lead_id'] =widget.lead_id;
    map['prop_id'] =widget.prop_id.toString();
    map['costsheet_status'] =status;
    map['lead_inventory_id'] =inventory_details_with_price!.lead_inventory_id;

    print(map.toString());


    print(json.encode(map));
    ServiceConfig().postApiBodyAuthJson(API.shareCostSheet, map, context).then((value) {
      Response response = value;
      setState(() {
        update = false;
      });
      if (response != null && response.statusCode == 200) {
        inventory_details_with_price?.costsheet_status=status.toString();
        _scrollDown();


      }
    }).catchError((onError){

      setState(() {
        update = false;
      });
    });


  }

  void confirmation_dialog(String status) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'Please Confirm',
              style: new TextStyle(fontFamily: "medium", fontSize: 15),
            ),
            content: Text(
              status=="4"?'Are you sure? Do you want to reject Cost Sheet?':'Are you sure? Do you want to Accept Cost Sheet?',
              style: new TextStyle(fontFamily: "regular", fontSize: 12),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop("Discard");
                  update_status(status);

                },
                child: Text(
                  'OK',
                  style: new TextStyle(fontFamily: "regular", fontSize: 13),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop("Discard");

                },
                child: Text(
                  'Cancel',
                  style: new TextStyle(fontFamily: "regular", fontSize: 12,color: ColorFile.red_700),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });

  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

}