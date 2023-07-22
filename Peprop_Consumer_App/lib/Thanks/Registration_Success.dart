import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Login/Login.dart';
import 'package:peprop_consumer_app/Thanks/HomeButton.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Dashboard/Dashboard.dart';
import '../widgets/Custom_Elevation_button.dart';

class Registration_Success extends StatefulWidget {
  String message="";
  Registration_Success(String message){
    this.message=message;
  }





  @override
  State<Registration_Success> createState() => _ThankYouPageState();
}


class _ThankYouPageState extends State<Registration_Success> {

  @override
  Widget build(BuildContext context) {

    return WillPopScope(child:
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              padding: EdgeInsets.all(35),

              child: Image.asset(
                "assets/succcess.gif",
                fit: BoxFit.cover,
              ),
            ),
            new SizedBox(height: 20,),
            Text("Successful",style: Styles().styles_bold(32, ColorFile.greens)),
            new SizedBox(height: 10,),
            new Container(padding: EdgeInsets.all(10),child: new Row(children: [Expanded(child: new Container(child: Text(widget.message.toString(),style: Styles().styles_regular(15, ColorFile.black),textAlign: TextAlign.center,),))],),),
            SizedBox(height: 20),
            Custom_Elevation_button("  Login Now  ",14,onclick: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()),(Route<dynamic> route) => false);

            },),


          ],
        ),
      ),
    ),

        onWillPop:(){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()),(Route<dynamic> route) => false);

      return Future.value(true);


    }

    )
      ;
  }

}