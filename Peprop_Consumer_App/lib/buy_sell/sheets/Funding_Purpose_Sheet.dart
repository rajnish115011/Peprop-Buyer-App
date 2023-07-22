

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Master_Model.dart';

import '../../Models/Listing_Filter_Model.dart';

class Funding_Purpose_Sheet extends StatefulWidget {

  List<Master_Model>reportList;
  final Function(Master_Model) onSelectionChanged;
  Funding_Purpose_Sheet(this.reportList, {required this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}
class _MultiSelectChipState extends State<Funding_Purpose_Sheet> {
  var  selectedChoice=null;
  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(
          Container(
            padding:EdgeInsets.only(right: 10,bottom: 10),
            child: ChoiceChip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30),),side: BorderSide(color: ColorFile.light_bc, width:selectedChoice==item? 0:1),),
              label: new Container(
                  height: 30,
                  child: new Column(
                    mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                      Text(item.name,textAlign: TextAlign.center,style: new TextStyle(fontFamily:"regular",fontSize:13,color:selectedChoice== item? ColorFile.white:ColorFile.black)),
                    ],
                  )
              ),
              selectedColor:ColorFile.drawer ,
              backgroundColor: ColorFile.white,
              selected: selectedChoice == item,
              onSelected: (selected) {
                setState(() {
                  selectedChoice = item;
                  widget.onSelectionChanged(selectedChoice);
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