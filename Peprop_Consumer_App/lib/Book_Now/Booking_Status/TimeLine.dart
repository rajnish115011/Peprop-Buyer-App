


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Book_Now/Booking_Status/Booking_Status.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Timeline extends StatelessWidget {

  My_Booking_Models? list;
  Timeline(My_Booking_Models? list){
    this.list=list;

  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[

          //booked on
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            endChild:  RightChild( 'Booked On',AppUtils.server_utc_date_parse(list!.booking_date),"assets/booked_on.png","",0,0,"",list,""),
            beforeLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
          ),

          //payment
            TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            indicatorStyle:  IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            endChild:RightChild( 'Payments(Booking Amount)',(  "( ₹ "+list!.booking_amount.toString()+")"),"assets/booking_amount.png","",0,0,"",list,""),
            beforeLineStyle: const LineStyle(
              color:Color(0xFF27AA69),
            ),
            afterLineStyle:  LineStyle(
              color:list!.booking_status_data.length>0?Color(0xFF27AA69):ColorFile.white,
            ),

          ),
          new Column(
            children:generate(list!.booking_status_data,list!.booking_option,list),
          )















          // if(list!.refund_status.toString()!="null") TimelineTile(
          //     alignment: TimelineAlign.manual,
          //     lineXY: 0.1,
          //     indicatorStyle: const IndicatorStyle(
          //       width: 20,
          //       color: Color(0xFF27AA69),
          //       padding: EdgeInsets.all(6),
          //     ),
          //     endChild:  RightChild( 'Refund Request',"Refund Request Initiated","assets/booking_approved.png"),
          //     beforeLineStyle:  LineStyle(
          //       color:Color(0xFF27AA69),
          //     ),
          //     afterLineStyle:  LineStyle(
          //       color: Color(0xFF27AA69),
          //     )),
          // if(list!.refund_status.toString()!="null") TimelineTile(
          //     alignment: TimelineAlign.manual,
          //     lineXY: 0.1,
          //     indicatorStyle: const IndicatorStyle(
          //       width: 20,
          //       color: Color(0xFF27AA69),
          //       padding: EdgeInsets.all(6),
          //     ),
          //     endChild:  RightChild( 'Refund Status',list!.refund_status.toString()=="0"?"Pending":list!.refund_status.toString()=="1"?"Approved":list!.refund_status.toString()=="2"?"Rejected":"Approved","assets/booking_approved.png"),
          //     beforeLineStyle:  LineStyle(
          //       color:Color(0xFF27AA69),
          //     ),
          //     afterLineStyle:  LineStyle(
          //       color:list!.refund_status.toString()=="0"?ColorFile.lightgray:list!.refund_status.toString()=="1"?ColorFile.greens:list!.refund_status.toString()=="2"?ColorFile.status_rejected:ColorFile.greens,
          //     )),
          //
          // if(list!.refund_status.toString()!="null") TimelineTile(
          //     alignment: TimelineAlign.manual,
          //     lineXY: 0.1,
          //     indicatorStyle:  IndicatorStyle(
          //       width: 20,
          //       color:list!.refund_status.toString()=="0"?ColorFile.lightgray:list!.refund_status.toString()=="1"?ColorFile.greens:list!.refund_status.toString()=="2"?ColorFile.status_rejected:ColorFile.greens,
          //       padding: EdgeInsets.all(6),
          //     ),
          //     endChild:  RightChild( 'Refund Completed',list!.refund_status.toString()!="3"?"No":"Yes","assets/booking_approved.png"),
          //     beforeLineStyle:  LineStyle(
          //       color:list!.refund_status.toString()=="0"?ColorFile.lightgray:list!.refund_status.toString()=="1"?ColorFile.greens:list!.refund_status.toString()=="2"?ColorFile.status_rejected:ColorFile.greens,
          //
          //     ),
          //     afterLineStyle:  LineStyle(
          //       color:ColorFile.white,
          //     )
          //
          // ),


        ],
      ),
    );
  }

 List<Widget> generate(List<Booking_status_data> booking_status_data, String booking_option, My_Booking_Models? model) {
    List<Widget>list=[];
    for(int i=0;i<booking_status_data.length;i++){
      list.add(TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF27AA69),
            padding: EdgeInsets.all(6),
          ),
          endChild:RightChild(booking_status_data[i].comments,AppUtils.server_utc_date_parse(booking_status_data[i].created_on),"assets/booking_approved.png",booking_status_data[i].status_history,i,booking_status_data.length-1,booking_option,model,booking_status_data[i].unit_name_number),
          beforeLineStyle:  LineStyle(
            color:Color(0xFF27AA69),
          ),
          afterLineStyle:  LineStyle(
            color:i!=booking_status_data.length-1?Color(0xFF27AA69):ColorFile.white,
          )),

      );
    }


    



    return list;

  }

}