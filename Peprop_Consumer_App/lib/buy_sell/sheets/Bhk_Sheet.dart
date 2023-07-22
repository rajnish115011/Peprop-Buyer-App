import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/buy/Property_Kind.dart';

class Bhk_Sheet extends StatefulWidget {

  List<Property_Kind>reportList;
  final Function(Property_Kind) onSelectionChanged;

  String selection_type="";
  Bhk_Sheet(this.reportList, this. selection_type, {required this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}
class _MultiSelectChipState extends State<Bhk_Sheet> {
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
                      Text(item.proj_type_name,textAlign: TextAlign.center,style: new TextStyle(fontFamily:"regular",fontSize:13,color:selectedChoice== item? ColorFile.white:ColorFile.black)),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: new Row(children:_buildChoiceList(),),

    );
  }
}