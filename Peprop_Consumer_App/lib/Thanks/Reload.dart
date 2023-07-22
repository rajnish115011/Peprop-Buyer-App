import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Thanks/HomeButton.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Dashboard/Dashboard.dart';
import '../widgets/Custom_Elevation_button.dart';

class Reload extends StatelessWidget{
  final Function() on_click;
  Reload({required this.on_click});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return     Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            padding: EdgeInsets.all(35),

            child: Image.asset(
              "assets/price.png",
              fit: BoxFit.cover,
            ),
          ),
          new SizedBox(height: 20,),

          Custom_Elevation_button("Reload",14,onclick: (){
            on_click();

          },),

        ],
      ),
    );
  }

}