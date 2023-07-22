import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Thanks/HomeButton.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Dashboard/Dashboard.dart';
import '../widgets/Custom_Elevation_button.dart';

class Thank_You extends StatefulWidget {
  const Thank_You({Key? key, required this.orderAmount,required this.referenceId}) : super(key: key);

  final String orderAmount;

  final String referenceId;


  @override
  State<Thank_You> createState() => _ThankYouPageState();
}


class _ThankYouPageState extends State<Thank_You> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
            Text("Payment done Successfully",style: Styles().styles_regular(13, ColorFile.black),),
            SizedBox(height: 20),


            Text("Reference ID: "+widget.referenceId,textAlign: TextAlign.center, style: Styles().styles_medium(14, ColorFile.hexblack),),
            SizedBox(height: 3),

            Text("Amount: ₹"+widget.orderAmount,textAlign: TextAlign.center, style: Styles().styles_medium(14, ColorFile.hexblack),),
            SizedBox(height: screenHeight * 0.06),

            Custom_Elevation_button("Back to Home",14,onclick: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Dashboard()),(Route<dynamic> route) => false);

            },),

          ],
        ),
      ),
    ),

        onWillPop:(){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Dashboard()),(Route<dynamic> route) => false);

      return Future.value(true);


    }

    )
      ;
  }

}