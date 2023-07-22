

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/Most_Cities_Model.dart';
import 'package:peprop_consumer_app/widgets/Generate_Grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Color/ColorFile.dart';
import '../../Login/Login.dart';
import '../../Models/Dashboard_grid_model.dart';

import '../../Utils/AppUtils.dart';
import '../../widgets/App_Filters.dart';
import '../../widgets/GridItem.dart';

class Top_Citeis extends StatelessWidget{
  List<Most_Cities_Model> most_cities=[];
  Top_Citeis(List<Most_Cities_Model> most_cities){
    this.most_cities=most_cities;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       if(most_cities.length>0) Padding(
          padding: EdgeInsets.only(top: 12, right: 8, left: 12, bottom: 8),
          child: Text(
            'Explore Projects By Popular Cities',
            style: TextStyle(
              fontFamily: 'bold',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        if(most_cities.length>0) Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: most_cities.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                        if(sharedPreferences.getString("token").toString()=="null"){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

                        }else
                        App_Filters().get_direct("1", true, most_cities[index].city_name, context,true);

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor:ColorFile.lightgray,
                              foregroundColor:ColorFile.lightgray,
                              radius: 36,
                              backgroundImage:
                              NetworkImage(API.baseUrl+"/"+most_cities[index].image),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 8, right: 8, left: 8),
                              child: Text(
                                most_cities[index].city_name,
                                style: TextStyle(
                                    fontFamily: 'regular', fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
      ],
    );
  }



}