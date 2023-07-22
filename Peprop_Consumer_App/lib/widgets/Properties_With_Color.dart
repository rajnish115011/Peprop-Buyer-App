

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/Apartments_Model.dart';
import '../Properties/Properties_Detail.dart';
import 'All_Lands_Widget.dart';

class Properties_With_Color extends StatelessWidget{
  List<Apartments_Model> Apartments = [];
  Function (int)on_changed;
  Properties_With_Color(List<Apartments_Model> Apartments,{required this.on_changed}){
    this.Apartments=Apartments;


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView.builder(onPageChanged: (index){
      on_changed(index);

      },
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        return   InkWell(
            onTap: (){
              var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Properties_Detail(Apartments[index].ID,"")));
            },child:All_Lands_Widget(Apartments[index])

        );

      },
      itemCount: Apartments.length, // Can be null
    );
  }

}