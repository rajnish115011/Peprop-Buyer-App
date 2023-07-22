import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

class MyVerticalText extends StatelessWidget {
  final String text;

  const MyVerticalText(this.text);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Text(text.toString(),style: TextStyle(fontSize: 12,color: ColorFile.white,fontFamily: "medium"),textAlign: TextAlign.center,),
    );

    //   Wrap(
    //   runSpacing: 30,
    //   direction: Axis.vertical,
    //   alignment: WrapAlignment.center,
    //   children: text.split("").map((string) => Text(string, style: TextStyle(fontSize: 12,color: ColorFile.white,fontFamily: "medium"))).toList(),
    // );
  }
}
class MyHorizontalText extends StatelessWidget {
  final String text;

  const MyHorizontalText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text.toString(),style: TextStyle(fontSize: 12,color: ColorFile.white,fontFamily: "medium"),textAlign: TextAlign.center,);

  }
}