


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
import 'Event_All_Builders.dart';
import 'Event_All_Projects.dart';

class Event_Slots extends StatefulWidget{

  late Event_Model event_list;
  Event_Slots(Event_Model event_list){
    this.event_list=event_list;
  }





  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Event_Slots>{

  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppUtils.appBarTitle(context, "Event Slots"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  padding: EdgeInsets.all(5),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.event_list.event_date_detail.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new
                    Container(
                      
                      child: InkWell(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Container(child: new Text("Session "+(index+1).toString(),style: Styles().styles_bold(15, Colors.black),),alignment: Alignment.center,margin: EdgeInsets.only(top: 10,bottom: 10),),
                          new Container(
                            margin: EdgeInsets.only(top: 5),
                            child: new Row(
                              children: [
                                Expanded(child: new Container(child: new Text("Event Title:-",style: Styles().semi(15, Colors.black),),)),
                                Expanded(child: new Container(child: new Text(widget.event_list.event_date_detail[index].event_titles.toString(),style: Styles().styles_bold(15, Colors.black),),))

                              ],
                            ),),
                          new Container(
                            margin: EdgeInsets.only(top: 5),
                            child: new Row(
                              children: [
                                Expanded(child: new Container(child: new Text("Event Date:-",style: Styles().semi(15, Colors.black),),)),
                                Expanded(child: new Container(child: new Text(widget.event_list.event_date_detail[index].event_date.toString(),style: Styles().styles_bold(15, Colors.black),),))

                              ],
                            ),),
                          new Container(
                            margin: EdgeInsets.only(top: 5),
                            child: new Row(
                              children: [
                                Expanded(child: new Container(child: new Text("Event Slot:-",style: Styles().semi(15, Colors.black),),)),
                                Expanded(child: new Container(child: new Text(widget.event_list.event_date_detail[index].event_titles.toString(),style: Styles().styles_bold(15, Colors.black),),))

                              ],
                            ),),

                          new Container(
                            margin: EdgeInsets.only(top: 5),
                            child: new Row(
                              children: [
                                Expanded(child: new Container(child: new Text("Speakers:-",style: Styles().semi(15, Colors.black),),)),
                                Expanded(child: new Container(child: new Text(widget.event_list.event_date_detail[index].speaker.toString(),style: Styles().styles_bold(15, Colors.black),),))

                              ],
                            ),),

                          new Container(
                            margin: EdgeInsets.only(top: 5),
                            child: new Row(
                              children: [
                                Expanded(child: new Container(child: new Text("Event Type:-",style: Styles().semi(15, Colors.black),),)),
                                Expanded(child: new Container(child: new Text(widget.event_list.event_date_detail[index].events_type.toString(),style: Styles().styles_bold(15, Colors.black),),))

                              ],
                            ),),

                          if(widget.event_list.event_date_detail[index].builder_details.length>0)new Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: .5,color: ColorFile.app_color)),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Container(child: new Text("PARTICIPATING BUILDERS",style: Styles().styles_bold(15, Colors.black),),),
                                new SizedBox(height: 10,),
                                GridView.builder(
                                  padding: EdgeInsets.all(10),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:widget.event_list.event_date_detail[index].builder_details.length>6?6:widget.event_list.event_date_detail[index].builder_details.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    height: 50.0,),
                                  itemBuilder: (BuildContext context, int i) {
                                    return new
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: Container(
                                          alignment: Alignment.center,
                                          child: ClipRRect(
                                            borderRadius: new BorderRadius.all(Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              imageUrl:widget.event_list.event_date_detail[index].builder_details[i].builder_logo.toString(),

                                              errorWidget: (context, url, error) =>
                                              new Container(height: 0,),
                                            ),
                                          ),)),
                                        VerticalDivider(color: ColorFile.app_color,)
                                      ],
                                    );


                                  },
                                ),

                                if(widget.event_list.event_date_detail[index].builder_details.length>6)InkWell(child: new Container(
                                  margin: EdgeInsets.only(top: 10,right: 10),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      new Text("View All",style: Styles().styles_bold(12, Colors.black),),
                                      new SizedBox(width: 5,),
                                      new Icon(Icons.arrow_forward_ios_sharp,size: 12,)




                                    ],
                                  ),),onTap: (){

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Event_All_Builders(widget.event_list.event_date_detail[index].builder_details)));
                                },)

                              ],
                            ),),
                          if(widget.event_list.event_date_detail[index].prop_list.length>0)new Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: .5,color: ColorFile.app_color)),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Container(child: new Text("PROJECTS",style: Styles().styles_bold(15, Colors.black),),),
                                new SizedBox(height: 10,),
                                GridView.builder(

                                  padding: EdgeInsets.all(10),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:widget.event_list.event_date_detail[index].prop_list.length>6?6:widget.event_list.event_date_detail[index].prop_list.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    height: 50.0,),
                                  itemBuilder: (BuildContext context, int i) {
                                    return new
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: Container(
                                          alignment: Alignment.center,

                                          child: ClipRRect(
                                            borderRadius: new BorderRadius.all(Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              imageUrl:widget.event_list.event_date_detail[index].prop_list[i].property_logo.toString(),

                                              errorWidget: (context, url, error) =>
                                              new Container(height: 0,),
                                            ),
                                          ),)),
                                        VerticalDivider(color: ColorFile.app_color,),
                                      ],
                                    );


                                  },
                                ),

                                if(widget.event_list.event_date_detail[index].prop_list.length>6)InkWell(child: new Container(
                                  margin: EdgeInsets.only(top: 10,right: 10),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      new Text("View All",style: Styles().styles_bold(12, Colors.black),),
                                      new SizedBox(width: 5,),
                                      new Icon(Icons.arrow_forward_ios_sharp,size: 12,)

                                    ],
                                  ),),onTap: (){

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Event_All_Projects(widget.event_list.event_date_detail[index].prop_list)));


                                },)

                              ],
                            ),),

                        ],
                      ),



                    ),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: .5,color:ColorFile.lightgray)),);
                    


                  },
                )
                




              ],
            ),
          )

        ],
      ),
    );
  }







}