import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';

class AppBar_leading extends StatelessWidget{
  late GlobalKey<ScaffoldState> scaffoldKey;
  AppBar_leading(GlobalKey<ScaffoldState> scaffoldKey){
    this.scaffoldKey=scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {

    return
      Container(
        color: ColorFile.white,
        child: Column(
          children: [
            new Container(
              height: 65,
              child:new Row(
                children: [
                  new InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: new Row(
                      children: [
                        new SizedBox(width: 20,),
                        Icon(Icons.arrow_back,color: ColorFile.black,),
                        new SizedBox(width: 10,),
                        new Text("Back",style: new TextStyle(fontSize:17,fontFamily: "bold",color: ColorFile.black),),
                      ],
                    ),
                  ),
                  Expanded(child:
                  new Container(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset("assets/logo.png",width:150,height: 35,)
                      ],
                    ),
                  ))
                ],
              ),

            ),

          ],
        ),
      );
    // TODO: implement build

  }

}
