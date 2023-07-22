import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Blog_Tab_Model.dart';
import 'package:peprop_consumer_app/Models/buy/Property_Kind.dart';

class For_Kind_property extends StatefulWidget {

  List<Property_Kind>reportList;
  final Function(Property_Kind) onSelectionChanged;
  For_Kind_property(this.reportList, {required this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}
class _MultiSelectChipState extends State<For_Kind_property> {
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
                padding: EdgeInsets.only(left: 10,right: 10),
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
    return Wrap(
      spacing: 1.0, // spacing between adjacent chips
      runSpacing: 0.0,

      children: _buildChoiceList(),
    );
  }
}

class Legal_chips extends StatefulWidget {

  List<Legal_model>reportList;
  final Function(Legal_model) onSelectionChanged;
  Legal_chips(this.reportList, {required this.onSelectionChanged});
  @override
  States createState() => States();
}
class States extends State<Legal_chips> {
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
                  padding: EdgeInsets.only(left: 10,right: 10),
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
