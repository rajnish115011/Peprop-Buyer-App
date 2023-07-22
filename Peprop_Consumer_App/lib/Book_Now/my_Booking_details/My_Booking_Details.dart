



import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Cost_Sheet/Cost_Property.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/Form_Title.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../../Models/MileStone_Payment_Model.dart';
import '../../Properties/Properties_Detail.dart';
import '../../Utils/AppUtils.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/Mile_Stone_Widget.dart';
import '../../widgets/My_Booking_Payment_Widget.dart';
import '../../widgets/My_Booking_Property.dart';

class My_Booking_Details extends StatefulWidget{
  My_Booking_Models? list;
  My_Booking_Details(My_Booking_Models list){
    this.list=list;

  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }



}
class Build_State extends State<My_Booking_Details>{
  List<MileStone_Payment_Model>mile_stone=[];


  @override
  void initState()   {
    super.initState();

    get_milestone();


    create_log();



  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Back"),
      body:new SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child:  new Column(
          children: [
            My_Booking_Property(widget.list,on_click: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Properties_Detail(widget.list!.property_id,"false")));

            },),

            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.list!.list.length>0)new Container(margin: EdgeInsets.only(left: 10,top: 10),child: new Text("Customer Details",style: Styles().styles_bold(16, ColorFile.black),),),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.list!.list.length,
                    itemBuilder: (context, index) {
                      return new Container(
                        padding: EdgeInsets.all(10),
                        decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),
                            border: new Border.all(width: 1,color: ColorFile.lightgray)

                        ),
                        margin: EdgeInsets.all(10),
                        child: new Column(
                          children: [
                            Form_Title("Full Name","Father Name"),
                            new SizedBox(height: 5,),
                            Form_Title_content(widget.list!.list[index].full_name,widget.list!.list[index].father_name),
                            new SizedBox(height: 10,),

                            Form_Title("Gender","Address"),
                            new SizedBox(height: 5,),
                            Form_Title_content(widget.list!.list[index].gender.toString()=="M"?"Male":"Female",widget.list!.list[index].address),
                            new SizedBox(height: 10,),

                            Form_Title("Bank Loan Required","DOB"),
                            new SizedBox(height: 5,),
                            Form_Title_content(widget.list!.list[index].bank_loan_required.toString()=="0"?"Yes":"No",AppUtils.convert_yyyy_mm_dd(widget.list!.list[index].d_o_b)),
                            new SizedBox(height: 10,),

                            Form_Title("Pan",""),
                            new SizedBox(height: 5,),
                            Form_Title_content(widget.list!.list[index].pancard_details.toString(),""),
                            new SizedBox(height: 10,),

                          ],
                        ),
                      );




                    }),
              ],
            ),
            if(widget.list!.list.length>0&&widget.list!.list[0].form_type.toString()=="online")new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(margin: EdgeInsets.only(left: 10,top: 10),child: new Text("Inventory Details",style: Styles().styles_bold(16, ColorFile.black),),),

                new SizedBox(height: 10,),
                My_Booking_inv(widget.list),
                new SizedBox(height: 10,),
              ],
            ),


            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(margin: EdgeInsets.only(left: 10,top: 10),child: new Text("Payment Details",style: Styles().styles_bold(16, ColorFile.black),),),
                new SizedBox(height: 10,),
                My_Booking_Payment_Widget(widget.list),
              ],
            ),
            if(mile_stone.length>0) new Container(child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mile_Stone_Widget(mile_stone,widget.list)
              ],
            ),)







          ],
        ),
      )


    );
  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("My Booking Details", "My Booking Details");

  }

  Future<void> get_milestone() async {
    var map = new Map<String, dynamic>();
    map['booking_id'] =widget.list!.id.toString();
    print("booking_id"+widget.list!.id.toString());
    FormData formData = FormData.fromMap(map);
    var response=await ServiceConfig().postApiBodyAuthJson(API.milestonesListsForBooking, formData, context);
    if(response!=null&&response.statusCode == 200&&response.data["data"]!=null){
      var notify = response.data["data"] as List;
      mile_stone = notify.map<MileStone_Payment_Model>((json) => MileStone_Payment_Model.fromJson(json)).toList();

    }
    setState(() {
    });




  }






}