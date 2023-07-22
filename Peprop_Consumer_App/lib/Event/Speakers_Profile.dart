


import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/Event/Event_Model.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Utils/AppUtils.dart';
import '../Utils/ServiceConfig.dart';
import '../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';

class Speakers_Profile extends StatefulWidget{
  late Speakers event_speaker;

  Speakers_Profile(Speakers event_speaker){
    this.event_speaker=event_speaker;

  }



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Speakers_Profile>{

  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppUtils.appBarTitle(context, "Profile"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Container(
                margin: EdgeInsets.all(10),
                 child: new Card(
                   elevation: 3,
                   shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10),),
                   child: new Container(
                     decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),
                     border: new Border.all(width: .5,color: ColorFile.lightgray)),
                     padding: EdgeInsets.all(10),
                     child: new Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         CircleAvatar(backgroundImage: NetworkImage(widget.event_speaker.profile_picture.toString()),radius: 50,),
                         new Container(margin: EdgeInsets.only(top: 10),child: new Text(widget.event_speaker.first_name.toString()+" "+widget.event_speaker.last_name.toString(),style: Styles().styles_bold(16, Colors.black),),) ,
                         new Container(
                           margin: EdgeInsets.only(top: 10),
                           child: new Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             InkWell(child: new Image.asset("assets/social/linkedin.png",height: 25,),
                             onTap: (){
                               AppUtils().open_url(widget.event_speaker.linkdin.toString(), context);

                             },

                             ),
                             new SizedBox(width: 10,),
                             InkWell(child: new Image.asset("assets/social/twitter.png",height: 25,),
                               onTap: (){
                                 AppUtils().open_url(widget.event_speaker.twitter.toString(), context);

                               },

                             ),
                             new SizedBox(width: 10,),
                             InkWell(child: new Image.asset("assets/social/facebook.png",height: 25,),
                               onTap: (){
                                 AppUtils().open_url(widget.event_speaker.facebook.toString(), context);

                               },

                             ),
                             new SizedBox(width: 10,),
                             InkWell(child: new Image.asset("assets/social/instagram.png",height: 25,),
                               onTap: (){
                                 AppUtils().open_url(widget.event_speaker.instagram.toString(), context);

                               },

                             )



                           ],
                         ),),


                         new Container(
                           margin: EdgeInsets.only(top: 25),
                           child: new Row(
                           children: [
                             Expanded(child: new Container(child: new Text("Full Name:-",style: Styles().semi(15, Colors.black),),)),
                             Expanded(child: new Container(child: new Text(widget.event_speaker.first_name.toString()+" "+widget.event_speaker.last_name.toString(),style: Styles().styles_bold(15, Colors.black),),))

                           ],
                         ),),
                         new Container(
                           margin: EdgeInsets.only(top: 15),
                           child: new Row(
                             children: [
                               Expanded(child: new Container(child: new Text("Current Position:-",style: Styles().semi(15, Colors.black),),)),
                               Expanded(child: new Container(child: new Text(widget.event_speaker.current_position.toString(),style: Styles().styles_bold(15, Colors.black),),))

                             ],
                           ),),
                         new Container(
                           margin: EdgeInsets.only(top: 15),
                           child: new Row(
                             children: [
                               Expanded(child: new Container(child: new Text("Total Experience:-",style: Styles().semi(15, Colors.black),),)),
                               Expanded(child: new Container(child: new Text(widget.event_speaker.experience.toString(),style: Styles().styles_bold(15, Colors.black),),))

                             ],
                           ),),
                         new SizedBox(height: 20,)

                       ],
                     ),
                   ),
                 
                 
               ),),
                new Container(
                  padding: EdgeInsets.all(12),
                  child: new Row(children: [
                  new Text("ABOUT "+widget.event_speaker.first_name.toString().toUpperCase()+" "+widget.event_speaker.last_name.toString().toUpperCase(),style: Styles().styles_bold(16, Colors.black),)
                ],),),
                new Container(
                  margin: EdgeInsets.all(10),
                  child: new Card(
                    elevation: 3,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10),),
                    child: new Container(
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),
                          border: new Border.all(width: .5,color: ColorFile.lightgray)),
                      padding: EdgeInsets.all(10),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          new Container(
                            margin: EdgeInsets.only(top: 5,bottom: 5),
                            child: new Row(
                              children: [
                                Expanded(child: new Container(child: new Text(widget.event_speaker.speaker_description.toString(),style: Styles().styles_regular(12, Colors.black),),))

                              ],
                            ),),


                        ],
                      ),
                    ),

                  ),)
                




              ],
            ),
          )

        ],
      ),
    );
  }







}