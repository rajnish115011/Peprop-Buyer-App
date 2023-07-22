import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Apartments_Model.dart';
import '../Color/ColorFile.dart';
import '../Utils/AppUtils.dart';
import '../wish_list/Styles.dart';


class Rewards_List extends StatefulWidget {
  List<Property_Rewards> property_rewards=[];
  Rewards_List(List<Property_Rewards> property_rewards){
    this.property_rewards=property_rewards;
  }



  @override
  _MySiteVIsitsState createState() => _MySiteVIsitsState();
}

class _MySiteVIsitsState extends State<Rewards_List> {




  List<Property_Rewards> list = [];


  @override
  void initState() {
    super.initState();

  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.appBar(context, 'Rewards'),
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.all(10),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.property_rewards.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(

                  child: new Container(
                  padding: EdgeInsets.all(20),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(widget.property_rewards[index].title.toString(),style: Styles().styles_medium(16, ColorFile.black),),
                      new Container(height: 10,),
                      new Container(child: new Row(
                        children: [
                          Expanded(child: new Container(child: new Text(widget.property_rewards[index].desc.toString(),style: Styles().styles_regular(14,ColorFile.hint_color),),))
                        ],
                      ),),
                      new Container(height: 30,),
                      new Container(padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),border: new Border.all(width: 1,color: ColorFile.greens)),child: new Text("+"+widget.property_rewards[index].value.toString()+" Points",style: Styles().styles_medium(17, ColorFile.greens),),)
                      
                    ],

                  ),

                ),);


              },
            ),
          ],
        ),
      ),
    );
  }
}
