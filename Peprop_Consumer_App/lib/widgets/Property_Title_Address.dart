

import 'package:flutter/cupertino.dart';

import '../Color/ColorFile.dart';

class Property_Title_Address extends StatelessWidget{
  String title="";String address="";
  Property_Title_Address(String title,String address){
    this.title=title;
    this.address=address;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new SizedBox(height: 10,),
          new Container(alignment: Alignment.centerLeft,
            child: new Text(
                title
                    .toString(), style: new TextStyle(
                fontSize: 16, fontFamily: "bold", color: ColorFile
                .black)),),
          new SizedBox(height: 5,),
          new Container(alignment: Alignment.centerLeft,
            child: new Text(address.toString(),
                style: new TextStyle(fontSize: 13,
                    fontFamily: "medium",
                    color: ColorFile.black)),),
          new SizedBox(height: 20,),
        ],
      ),
    );
  }

}