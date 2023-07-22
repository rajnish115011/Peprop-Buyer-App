

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/buy_sell/Buy_Sell_Form.dart';

import '../../Color/ColorFile.dart';
import '../../Models/Dashboard_grid_model.dart';

import '../../widgets/GridItem.dart';
import '../buy_sell/MY_Buy_Sell.dart';
import '../widgets/DashBoard_List_Widget.dart';
import '../widgets/Generate_Grid.dart';

class Listing_Widget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 18, right: 8, left: 8, bottom: 8),
          child: Text(
            'Listing',
            style: TextStyle(
              fontFamily: 'bold',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        GridView.builder(
          itemCount: Generate_Grid().listing().length,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10, right: 10),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (cx, index) {
            return new InkWell(
              child: DashBoard_List_Widget( Generate_Grid().listing()[index]),
              onTap: () async {
                if(index==0){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MY_Buy_Sell("1")));
                } if(index==1){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MY_Buy_Sell("2")));
                }if(index==2){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Buy_Sell_Form("",null)));
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


      ],
    );
  }



}