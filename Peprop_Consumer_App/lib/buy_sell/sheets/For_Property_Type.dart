

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Listing_Filter_Model.dart';


class For_Property_Type extends StatefulWidget {

  List<PropertyType>reportList;
  var selectedChoice=null;
  final Function(PropertyType) onSelectionChanged;


  For_Property_Type(this.reportList,  this.selectedChoice, {required this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}
class _MultiSelectChipState extends State<For_Property_Type> {

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {


      choices.add(
          Container(
            padding:EdgeInsets.only(right: 10,bottom: 10),
            child: ChoiceChip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30),),side: BorderSide(color: ColorFile.light_bc, width:widget.selectedChoice==item? 0:1),),
              label: new Container(
                  height: 30,
                  child: new Column(
                    mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                      Text(item.PropertType,textAlign: TextAlign.center,style: new TextStyle(fontFamily:"regular",fontSize:13,color:widget.selectedChoice== item? ColorFile.white:ColorFile.black)),
                    ],
                  )
              ),
              selectedColor:ColorFile.drawer ,
              backgroundColor: ColorFile.white,
              selected: widget.selectedChoice == item,
              onSelected: (selected) {
                setState(() {
                  widget.selectedChoice = item;
                  widget.onSelectionChanged(widget.selectedChoice);
                });
              },
            ),
          )


      );
    });
    return choices;
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 1.0, // spacing between adjacent chips
      runSpacing: 0.0,

      children: _buildChoiceList(),
    );
  }
}
