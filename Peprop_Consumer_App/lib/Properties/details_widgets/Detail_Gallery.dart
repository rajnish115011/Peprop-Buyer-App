

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Color/ColorFile.dart';
import '../../widgets/Gallery_Widget.dart';
import '../Gallery_List.dart';


class Detail_gallery extends StatelessWidget{
  List gallery_list=[];
  String type="";
  Detail_gallery(List gallery_list, String type){
    this.gallery_list=gallery_list;
    this.type=type;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        new Container(
          margin: EdgeInsets.only(top: 30),
          child:
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Container(
                child:new Text("Take a tour of the Project",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 150,
                child:
                new Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                           padding: EdgeInsets.only(right: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: gallery_list.length,
                          itemBuilder: (BuildContext context, int index) =>
                              InkWell(child: Gallery_Widget(index,gallery_list.length,gallery_list[index],type),onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Gallery_list(gallery_list,type)));

                              },)
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }

}