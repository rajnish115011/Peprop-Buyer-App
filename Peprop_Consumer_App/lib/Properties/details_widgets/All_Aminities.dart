

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../../Color/ColorFile.dart';


class All_Aminities extends StatefulWidget{
  List aminities_list=[];
  String type="";
  All_Aminities(List aminities_list, String type){
    this.aminities_list=aminities_list;
    this.type=type;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<All_Aminities>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBar(context,"Details"),
      body: new SingleChildScrollView(
        child: new Column(
          children: [
            new GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children: new List<Widget>.generate(widget.aminities_list.length, (index) {
                  return new GridTile(
                      child:new Container(

                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Container(
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeInImage.assetNetwork(
                                    placeholder: 'assets/loading.png',
                                    image:API.assets+widget.aminities_list[index].logo_image.toString(),
                                    width: 30,
                                    fit: BoxFit.cover,
                                    height: 30,
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return Image.asset("assets/no_data.png",
                                        width: 30,
                                        fit: BoxFit.cover,
                                        height: 30,);//do something
                                    },
                                  ),
                                ],
                              ),
                            ), new SizedBox(height: 15,),new Text(widget.aminities_list[index].name,style: new TextStyle(fontFamily: "regular",fontSize: 10),textAlign: TextAlign.center,)
                          ],
                        ),
                      )
                  );}))
          ],
        ),
      ),
    );
  }

}