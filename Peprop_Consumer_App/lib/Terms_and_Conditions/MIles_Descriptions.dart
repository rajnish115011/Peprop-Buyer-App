import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import '../wish_list/Styles.dart';



class MIles_Descriptions extends StatefulWidget{
  String data="";
  MIles_Descriptions(String data){
    this.data=data;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}
class Build_state extends State<MIles_Descriptions>{
  String tnc="";
  bool loading=false;
  @override
  initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Descriptions"),
      body:Stack(
        children: [
          SingleChildScrollView(child: new Column(children: [
            new Container(padding: EdgeInsets.all(10),child: new Row(children: [
              Expanded(child: new Container(child: new Text(widget.data.toString(),style: Styles().styles_regular(12, ColorFile.black),),))
            ],),)
          ],),)


        ],
      ));
  }


}