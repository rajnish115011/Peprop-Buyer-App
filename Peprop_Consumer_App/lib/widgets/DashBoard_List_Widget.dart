

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Dashboard_grid_model.dart';
import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';

import '../wish_list/Styles.dart';


class DashBoard_List_Widget extends StatelessWidget{
  late Dashboard_grid_model listing_grid;
  DashBoard_List_Widget(Dashboard_grid_model listing_grid){
    this.listing_grid=listing_grid;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Card(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(7),
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: AssetImage(listing_grid.bg),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.circular(
                10),
            // border: new Border.all(width: 1,
            //     color: ColorFile.lightgray)

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
                  mainAxisAlignment: MainAxisAlignment
                      .center,
                  children: [
                    new Container(
                      child:  Image.asset(
                        listing_grid.path,
                        height: 35,
                        width: 35,
                      ),
                    )
                  ],
                ),
              )),
              new SizedBox(height: 5,),
              new Container(
                child:
                new Text(listing_grid.name,
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

class DashBoard_List_Widget_dynamic extends StatelessWidget{
  late Home_List_Model listing_grid;
  int index=0;
  Function () viewall;
  DashBoard_List_Widget_dynamic(Home_List_Model listing_grid, int index,{required this.viewall}){
    this.listing_grid=listing_grid;
    this.index=index;


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(listing_grid.type.toLowerCase()=="section"&&index!=7) 
      return Card(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
        elevation: 2,
        child: Container(
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
    if(listing_grid.type.toLowerCase()=="section"&&index==7)
      return
        InkWell(child: Card(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
          elevation: 2,
          child: Container(
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
                    mainAxisAlignment: MainAxisAlignment
                        .center,
                    children: [
                      new Container(
                          child: Icon(Icons.arrow_forward,color: Colors.black,size: 35,)
                      )
                    ],
                  ),
                )),
                new SizedBox(height: 5,),
                new Container(
                  child:
                  new Text("View All",
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
        ),onTap: (){
          viewall();
        },);
    else{
      return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: new BorderRadius.all(Radius.circular(10)),child:FadeInImage.assetNetwork(
              placeholder: 'assets/ld.jpg',
              image:listing_grid.banner.toString(),
              imageErrorBuilder: (context, error, stackTrace) {
                return new Container()
                ;}))
        ],
      );
    }
  }



}


class wallet_dynamic extends StatelessWidget{
  late Home_List_Model listing_grid;
  int index=0;

  late Home_Model home_list;

  wallet_dynamic(Home_List_Model listing_grid, Home_Model home_list, int index){
    this.listing_grid=listing_grid;
    this.index=index;
    this.home_list=home_list;


  }


  @override
  Widget build(BuildContext context) {

    print("dladm"+home_list.earn_points.toString());

    return

      Container(
      padding: EdgeInsets.all(7),


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

                if(index==0)new Text(home_list.earn_points.toString()!="null"?home_list.earn_points.toString():"0",style: Styles().styles_bold(20, Colors.black),),
                if(index==1)new Text(home_list.redeem_points.toString()!="null"?home_list.redeem_points.toString():"0",style: Styles().styles_bold(20, Colors.black),),
                if(index==2)new Text(home_list.balance_points.toString()!="null"?home_list.balance_points.toString():"0",style: Styles().styles_bold(20, Colors.black),)


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

    );

  }



}