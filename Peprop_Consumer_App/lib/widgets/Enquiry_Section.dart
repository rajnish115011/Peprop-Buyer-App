


import 'package:flutter/material.dart';

import '../Enquiry/My_Enquiry.dart';
import '../My_Inrested_Projects/MyBrokerProperties.dart';
import '../Site_Visit/My_Site_Visit.dart';
import 'DashBoard_List_Widget.dart';
import 'Generate_Grid.dart';

class Enquiry_Section extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 18, right: 8, left: 8, bottom: 8),
          child: Text(
            'Enquiries',
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
          itemCount:Generate_Grid().enquiry().length,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10, right: 10),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (cx, index) {
            return new InkWell(
              child: DashBoard_List_Widget(Generate_Grid().enquiry()[index]),
              onTap: () async {
                if(index==0){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Enquiry()));
                } if(index==1){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_Site_Visit()));

                }
                if(index==2){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyBrokerProperties()));

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