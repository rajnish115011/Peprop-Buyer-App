



import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Book_Now/Booking_Status/TimeLine.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Cost_Sheet/Cost_Property.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/widgets/Form_Title.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../../Properties/Properties_Detail.dart';
import '../../Utils/AppUtils.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/My_Booking_Payment_Widget.dart';
import '../../widgets/My_Booking_Property.dart';
import '../Booking/Online_Booking.dart';
import 'Reschedule_Booking.dart';


class Booking_Status extends StatefulWidget{
  My_Booking_Models? list;
  Booking_Status(My_Booking_Models list){
    this.list=list;

  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }



}
class Build_State extends State<Booking_Status>{



  @override
  void initState()   {
    super.initState();



  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBarTitle(context, "Back"),
      body:new SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child:  new Column(
          children: [
            My_Booking_Property(widget.list,on_click: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Properties_Detail(widget.list!.property_id,"false")));

            },),
            Timeline(widget.list),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(margin: EdgeInsets.only(left: 10,top: 10),child: new Text("Payment Details",style: Styles().styles_bold(16, ColorFile.black),),),
                new SizedBox(height: 10,),
                My_Booking_Payment_Widget(widget.list),
              ],
            ),

          ],
        ),
      ),


    );
  }





}
class RightChild extends StatelessWidget {
  RightChild(String title,String message, String image_path, String status_history, int current, int last_index, String booking_option, My_Booking_Models? model, String unit_name_number){
    this.title=title;
    this.message=message;
    this.image_path=image_path;
    this.status_history=status_history;
    this.current=current;
    this.last_index=last_index;
    this.booking_option=booking_option;
    this.model=model;
    this.unit_name_number=unit_name_number;



  }
  My_Booking_Models? model;
   String title="";
   String message="";
  String image_path="";
  String status_history="";
  int current=0;
  int last_index=0;
  String booking_option="";
  String unit_name_number="";



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[

          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(unit_name_number!=""&&model!.booking_option!="2")Text(title+"(Unit No - "+unit_name_number+")",style: Styles().styles_medium(12, status_history!="7"?ColorFile.black:ColorFile.red_900),)else Text(title.toString(),style: Styles().styles_medium(12, status_history!="7"?ColorFile.black:ColorFile.red_900),),

              SizedBox(height: 5),
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(message,style: Styles().styles_regular(10, ColorFile.hint_color),),
                if(status_history=="7"&&current==last_index&&booking_option=="1")  ElevatedButton(
                    child: Text(
                        "Select another inventory",
                        style: TextStyle(fontSize: 12,color: ColorFile.white,fontFamily: "medium")
                    ),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(ColorFile.greens),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: Colors.green)
                            )
                        )
                    ),
                    onPressed: (){
                      var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Reschedule_Booking(model)));


                    }
                ),
              ],)




            ],
          ),
        ],
      ),
    );
  }
}
class RightChild_rejected extends StatelessWidget {
  RightChild_rejected(String title,String message, String image_path){
    this.title=title;
    this.message=message;
    this.image_path=image_path;

  }

  String title="";
  String message="";
  String image_path="";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          new Image.asset(image_path,height: 50,),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title,style: Styles().styles_medium(12, ColorFile.black),),
              SizedBox(height: 5),
              Text("Rejected",style: Styles().styles_bold(10, ColorFile.red_900),),
            ],
          ),
        ],
      ),
    );
  }
}
