

import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';
import '../widgets/Custom_Elevation_button.dart';
import '../wish_list/Styles.dart';

class Location_Picker_Sheet extends StatefulWidget{

  final Function() onSelectionChanged;
  final Function() choose_location;

  String message="";

  Location_Picker_Sheet(String message, {required this.onSelectionChanged,required this.choose_location}){
    this.message=message;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Location_Picker_Sheet> {
  @override
  Widget build(BuildContext context) {

    return new Container(
      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,
      ),
      child: new SingleChildScrollView(
          child:new Container(
            child:Padding(child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                new Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          widget.onSelectionChanged();
                          Navigator.pop(context);
                        },
                        child:  Container(
                          margin: const EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          child:  Container(
                            width: 30,
                            height: 30,
                            decoration:  BoxDecoration(
                              borderRadius: new BorderRadius.all(Radius.circular(100)),
                              color: ColorFile.hexblack,

                            ),
                            child:  Icon(Icons.close,color: ColorFile.white,) ,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Image.asset("assets/lc.png",height: 100,),

                new SizedBox(height: 20,),
                new Container(child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: new Container(alignment: Alignment.center,child:new Text(widget.message.toString().length==0?"It seems the details that you entered are wrong.Please enter correct details and try again.":widget.message.toString(),style: Styles().styles_medium(14, ColorFile.black),), )),



                  ],
                ),),
                new SizedBox(height: 20,),
                Custom_Elevation_button("Choose Location",10,onclick: (){
                  Navigator.pop(context);
                  widget.choose_location();



                },),
                new SizedBox(height: 20,)

              ],
            ),padding: EdgeInsets.all(10),),
          )




      ),
    );
  }


}

