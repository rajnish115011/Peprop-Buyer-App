


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Campaign_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:scratcher/scratcher.dart';

import '../wish_list/Styles.dart';

class Scrachers extends StatefulWidget{
  Scrachers(Campaign_Model list);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Scrach & Win"),
        body: new GridView.builder(
          itemCount: 50,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
          itemBuilder: (BuildContext context, int index) {
            return new
            InkWell(child: Card(
                child:new Container(decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/scrach.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),)
            ),onTap: (){
              scratchDialog(context);
            },);
          },
        )
    );
  }


  Future<void> scratchDialog(BuildContext context) {
    bool is_scrach=false;
    return showDialog(context: context,
        useSafeArea: false,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return new  
              ClipRRect(child:is_scrach==false?
              Scratcher(
                image: Image.asset("assets/scrach.jpg",height: 280,width: 280,),
                color: Colors.white,
                accuracy: ScratchAccuracy.low,
                threshold: 50,
                brushSize: 40,
                onThreshold: () {
                  setState(() {
                    is_scrach=true;
                  });
                },
                child:
                new Container(height: 280,width: 280,child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/trophy.png",height: 50,width: 50,),
                    new SizedBox(height: 10,),
                    new Text("You won",style: Styles().styles_bold(16, Colors.black),),
                    new Text("10% off",style: Styles().styles_bold(20, Colors.black),),

                  ],
                ),),

              ):

              new Container(height: 280,width: 280,child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/trophy.png",height: 50,width: 50,),
                  new SizedBox(height: 10,),
                  new Text("You won",style: Styles().styles_bold(16, Colors.black),),
                  new Text("10% off",style: Styles().styles_bold(20, Colors.black),),

                ],
              ),),borderRadius: new BorderRadius.circular(10),);
            }),
          );
        }
    );
  }

}