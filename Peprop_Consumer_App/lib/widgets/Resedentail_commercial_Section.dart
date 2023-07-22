



import 'package:flutter/material.dart';

import '../Book_Now/my_booking/My_Booking.dart';
import '../Color/ColorFile.dart';
import '../wish_list/Wish_List.dart';
import 'App_Filters.dart';
import 'DashBoard_List_Widget.dart';
import 'Generate_Grid.dart';

class Resedential_commercial_Section extends StatelessWidget{
  String city="";
  Resedential_commercial_Section(String city){
    this.city=city;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              left: 20, right: 20, bottom: 10),
          child: new Text(
            "Residential",
            style: new TextStyle(
                fontSize: 16,
                color: ColorFile.black,
                fontFamily: "bold"),
          ),
        ),
        GridView.builder(
          itemCount:Generate_Grid().generate_resedential().length,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10, right: 10),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (cx, index) {
            return new InkWell(
              child: DashBoard_List_Widget(Generate_Grid().generate_resedential()[index]),
              onTap: () async {
                if (index.toString() == "0") {
                  App_Filters().check_location("1", true, city, context,false,"","");
                }
                if (index.toString() == "1") {
                  App_Filters().check_location("1", false, city, context,true,"","");
                }
                if (index.toString() == "2") {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wish_List("1")));
                }
                if (index.toString() == "3") {
                  Book_Now().check_location("1",  city, context);
                } if (index.toString() == "4") {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Booking(1)));
                }
              },
            );
          },
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1.2),
        ),

        new Container(
          margin: EdgeInsets.only(
              left: 20, right: 20, top: 20, bottom: 10),
          child: new Text(
            "Commercial",
            style: new TextStyle(
                fontSize: 16,
                color: ColorFile.black,
                fontFamily: "bold"),
          ),
        ),
        GridView.builder(
          itemCount:Generate_Grid().generate_resedential().length,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10, right: 10),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return new InkWell(
              child: DashBoard_List_Widget(Generate_Grid().generate_resedential()[index]),
              onTap: () {
                if (index.toString() == "0") {
                  App_Filters().check_location("2", true, city, context,false,"","");
                }
                if (index.toString() == "1") {
                  App_Filters().check_location("2", false, city, context,true,"","");
                }
                if (index.toString() == "2") {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wish_List("2")));
                }
                if (index.toString() == "3") {
                  Book_Now().check_location("2",  city, context);
                }if (index.toString() == "4") {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Booking(2)));
                }
              },
            );
          },
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1.2),
        ),

        //Banking


      ],
    );
  }

}