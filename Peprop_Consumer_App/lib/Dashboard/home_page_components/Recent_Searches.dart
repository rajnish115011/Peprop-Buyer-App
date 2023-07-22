import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Local_database/Rec_city.dart';

class Recent_Searches extends StatelessWidget{
  Function(String) onselected;
  List<Rec_city> resent_list=[];
  Recent_Searches(List<Rec_city> resent_list, {required this.onselected}){
    this.resent_list=resent_list;
  }

  @override
  Widget build(BuildContext context) {
    return   new Container(
      margin: EdgeInsets.only(left: 10),
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i){
            return InkWell(
              onTap: () {

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      onselected(resent_list[i].city_name);


                    },
                    child: Card(
                      elevation: 0.0,
                      //color: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: ColorFile.tabback,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 5),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              Text(resent_list[i].city_name,style: new TextStyle(fontFamily: "regular",fontSize: 10),),
                            ],
                          )),
                    ),
                  ),

                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            );

          },itemCount: resent_list.length),
    );

  }


}