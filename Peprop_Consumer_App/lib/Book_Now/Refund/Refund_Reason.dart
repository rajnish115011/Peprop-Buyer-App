



import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Cost_Sheet/Cost_Property.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/widgets/Form_Title.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../../Properties/Properties_Detail.dart';
import '../../Utils/AppUtils.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/My_Booking_Payment_Widget.dart';
import '../../widgets/My_Booking_Property.dart';
import 'Refund_To_Bank.dart';

class Refund_Reason extends StatefulWidget{
  My_Booking_Models? list;
  Refund_Reason(My_Booking_Models list){
    this.list=list;

  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }



}
class Build_State extends State<Refund_Reason>{

 int selected_reason=-1;
 final notes=TextEditingController();

  @override
  void initState()   {
    super.initState();
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
            if(widget.list!.list.length>0&&widget.list!.list[0].form_type.toString()=="online")
            new Column(
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

            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(margin: EdgeInsets.only(left: 10,top: 10),child: new Text("Please Select Reason for Refund",style: Styles().styles_bold(16, ColorFile.black),),),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.list!.reason_list.length,
                    itemBuilder: (context, index) {
                      return new
                      InkWell(child:
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),
                            border: new Border.all(width: 1,color: ColorFile.lightgray)

                        ),
                        margin: EdgeInsets.all(10),
                        child: new Row(
                          children: [

                            selected_reason!=index? new Icon(Icons.radio_button_off):new Icon(Icons.radio_button_checked,color: ColorFile.app_color,),
                            new SizedBox(width: 10,),
                            Expanded(child: new Container(child:new Text(widget.list!.reason_list[index].reason.toString(),style: Styles().styles_regular(14, ColorFile.black),)))


                          ],
                        ),
                      ),onTap: (){
                        setState(() {
                          selected_reason=index;
                        });
                      },);




                    }),
                new SizedBox(height: 15,),
                new Container(child: new Column(

                  children: [
                    new Container(
                        child:new Row(
                          children: [
                            Expanded(child: new Container(
                              child:new Text("Notes",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                            )),


                          ],
                        )
                    ),
                    new SizedBox(height: 10,),
                    FDottedLine(

                      color: ColorFile.lightgray,
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      strokeWidth: 2.0,
                      dottedLength: 10.0,
                      space: 2.0,
                      child: descr("Notes", notes),
                    ),
                  ],
                ),margin: EdgeInsets.all(10),),

                new SizedBox(height: 50,),


              ],
            ),

          ],
        ),
      ),
      bottomNavigationBar:
      Bottom_Button("Continue",onclick: (value) async {
        if(selected_reason!=-1&&widget.list!.reason_list.length>0){
          var response =await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Refund_To_Bank(widget.list!,widget.list!.reason_list.length>0?widget.list!.reason_list[selected_reason].id:"0",notes.text.toString(),widget.list!.property_id)));
          if(response!=null){
            Navigator.pop(context,"saved");
          }

        }else{
          AppUtils.toAst("Please Select Reason for Refund..!!",context);
        }



      },)

    );
  }

   Widget descr(String hint, TextEditingController controller) {
   return Container(
     height: 100,
     child: TextField(
       controller: controller,
       enabled: true,
       maxLength: 100,
       style:TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.black),
       decoration: InputDecoration(
           counterText: "",
           contentPadding: EdgeInsets.only(left: 10, right: 10),
           hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
           hintText: hint,
           border: InputBorder.none,
           enabledBorder: InputBorder.none,
           focusedBorder: InputBorder.none,
           errorBorder: InputBorder.none,
           disabledBorder: InputBorder.none),
     ),
   );
 }
 Future<void> create_log() async {
   await FireBase_Logs().log_screen_view("Initiate Refund Form", "Initiate Refund Form");

 }




}