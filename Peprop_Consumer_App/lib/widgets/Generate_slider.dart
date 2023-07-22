

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard_model/Home_Model.dart';

class Generate_slider extends StatelessWidget{
  late Home_List_Model listing_grid;
  int index=0;
  Function () viewall;
  Generate_slider(Home_List_Model listing_grid, int index,{required this.viewall}){
    this.listing_grid=listing_grid;
    this.index=index;


  }


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
      elevation: 2,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(7),
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(listing_grid.bg_icon.toString()),
            fit: BoxFit.cover,
          ),
          borderRadius: new BorderRadius.circular(
              10),


        ),
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment
              .center,
          children: [
            Expanded(child: new Container(
              alignment: Alignment.center,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      CachedNetworkImage(
                      imageUrl:listing_grid.icon.toString(),
                      width: 35,
                      fit: BoxFit.cover,
                      height: 35,

                  ),

                ],
              ),
            )),
            new SizedBox(height: 5,),
            new Container(
              child:
              new Text(listing_grid.alt.toString(),
                style: new TextStyle(
                    fontFamily: "regular",
                    fontSize: 10),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,),

            ),
            new SizedBox(height: 5,),

          ],
        ),

      ),
    );
  }

}