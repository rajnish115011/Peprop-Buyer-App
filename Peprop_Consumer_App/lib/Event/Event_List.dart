


import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/Event/Event_All_Banks.dart';
import 'package:peprop_consumer_app/Event/Event_All_Builders.dart';
import 'package:peprop_consumer_app/Event/Event_All_Projects.dart';
import 'package:peprop_consumer_app/Event/Event_Model.dart';
import 'package:peprop_consumer_app/Event/Event_Slots.dart';
import 'package:peprop_consumer_app/Event/Speakers_Profile.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Utils/AppUtils.dart';
import '../Utils/ServiceConfig.dart';
import '../widgets/Event_Address.dart';
import '../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';

class Event_List extends StatefulWidget{
  String id="";
  Event_List(String id){
    this.id=id;

  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Event_List>{
  bool loading=false;
  List<Event_Model>event_list=[];
  @override
  void initState() {
    super.initState();
    get_event();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppUtils.appBarTitle(context, "Event"),
      body: Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)else if(loading==false&&event_list.length>0)
          SingleChildScrollView(
            child: new Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.all(5),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: event_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Container(child: ClipRRect(
                            borderRadius: new BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl:event_list[index].event_banner.toString(),
                              height: 220,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                               new Container(height: 0,),
                            ),
                          ),),



                          new Container(height: 10,),
                          new Container(child: new Text(event_list[index].event_title,style: Styles().styles_bold(15, ColorFile.black),),),
                          new Container(height: 10,),
                          new Container(child: new Text(event_list[index].event_auditorium,style: Styles().styles_bold(15, ColorFile.black),),),
                          new Container(height: 10,),

                          Event_Address(event_list[index]),


                          if(event_list[index].event_speaker.length>0)new Container(
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.bgs),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Container(child: new Text("SPEAKERS",style: Styles().styles_bold(15, Colors.black),),),
                                new SizedBox(height: 10,),
                                new Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 130,
                                  child:  ListView.builder(
                                      padding: EdgeInsets.all(5),
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: event_list[index].event_speaker.length,
                                      itemBuilder: (BuildContext context, int i) {
                                        return new
                                        InkWell(child: Container(
                                          margin: EdgeInsets.only(right: 15),
                                          child: Column(
                                            children: [
                                              CircleAvatar(radius: 30,backgroundImage: NetworkImage(API.event_speakers+event_list[index].event_speaker[i].profile_picture),),
                                              new Container(margin: EdgeInsets.only(top: 10),child: new Text(event_list[index].event_speaker[i].first_name+""+event_list[index].event_speaker[i].last_name,style: Styles().styles_medium(12, Colors.black),maxLines: 2,overflow: TextOverflow.ellipsis,),),
                                              new Container(margin: EdgeInsets.only(top: 5),child: new Text(event_list[index].event_speaker[i].current_position,style: Styles().styles_regular(12, Colors.black),),)

                                            ],
                                          ),width: 100,),onTap: (){

                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Speakers_Profile(event_list[index].event_speaker[i])));


                                        },);


                                      }),
                                )
                              ],
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(top: 15,bottom: 10),
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.lblue),alignment: Alignment.center,height: 30,child: new Text("About the Event",style: Styles().styles_medium(17, ColorFile.app_color),),),
                          new Container(
                            margin: EdgeInsets.only(top: 5,bottom: 5),
                            child: new Row(
                              children: [
                                Expanded(child: new Container(child: new Text(event_list[index].event_tnc.toString(),style: Styles().styles_regular(12, Colors.black),),))

                              ],
                            ),),
                          if(event_list[index].builder_details.length>0)new Container(
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
                                itemCount:event_list[index].builder_details.length>6?6:event_list[index].builder_details.length,
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
                                            imageUrl:event_list[index].builder_details[i].builder_logo.toString(),

                                            errorWidget: (context, url, error) =>
                                            new Container(height: 0,),
                                          ),
                                        ),)),
                                       VerticalDivider(color: ColorFile.app_color,)
                                    ],
                                  );


                                },
                              ),

                              if(event_list[index].builder_details.length>6)InkWell(child: new Container(
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

                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Event_All_Builders(event_list[index].builder_details)));
                              },)

                            ],
                          ),),
                          if(event_list[index].prop_list.length>0)new Container(
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
                                  itemCount: event_list[index].prop_list.length>6?6:event_list[index].prop_list.length,
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
                                              imageUrl:event_list[index].prop_list[i].property_logo.toString(),

                                              errorWidget: (context, url, error) =>
                                              new Container(height: 0,),
                                            ),
                                          ),)),
                                        VerticalDivider(color: ColorFile.app_color,),
                                      ],
                                    );


                                  },
                                ),

                                if(event_list[index].prop_list.length>6)InkWell(child: new Container(
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

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Event_All_Projects(event_list[index].prop_list)));


                                },)

                              ],
                            ),),
                          if(event_list[index].bank_detail.length>0)new Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: .5,color: ColorFile.app_color)),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Container(child: new Text("Participating Banks",style: Styles().styles_bold(15, Colors.black),),),
                                new SizedBox(height: 10,),
                                GridView.builder(
                                  padding: EdgeInsets.all(10),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:event_list[index].bank_detail.length>4?4:event_list[index].bank_detail.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    height: 50.0,),
                                   itemBuilder: (BuildContext context, int i) {
                                    return new
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(child: Container(
                                          alignment: Alignment.center,

                                          child: ClipRRect(
                                            borderRadius: new BorderRadius.all(Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              imageUrl:event_list[index].bank_detail[i].bank_image.toString(),

                                              errorWidget: (context, url, error) =>
                                              new Container(height: 0,),
                                            ),
                                          ),)),
                                        VerticalDivider(color: ColorFile.app_color,),
                                      ],
                                    );


                                  },
                                ),

                                if(event_list[index].bank_detail.length>8)InkWell(child: new Container(
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

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Event_All_Banks(event_list[index].bank_detail)));

                                },)

                              ],
                            ),),

                          InkWell(child: new Container(
                            margin: EdgeInsets.only(top: 20,bottom: 30),
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.app_color),alignment: Alignment.center,height: 45,child: new Text("Book Now",style: Styles().styles_medium(17, ColorFile.white),),),onTap: (){

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Event_Slots(event_list[index])));

                          },)



                          
                        ],
                      ),



                    );


                  },
                )



              ],
            ),
          )else No_Data_Placeholder("No Event Found..!!")

        ],
      ),


    );
  }





  get_event() async {
    setState(() {
      loading = true;
    });
    var map = new Map<String, dynamic>();
    map['id'] ="8";
    FormData formData = new FormData.fromMap(map);
    Response response = await ServiceConfig().postApiBodyAuthJson(API.eventList_id, formData, context);
    print(response);
    if (response.data != null && response.statusCode == 200&&response.data["data"]!=null&&response.data["data"]!="") {
      var notify = response.data["data"] as List;
      event_list = notify.map<Event_Model>((json) => Event_Model.fromJson(json)).toList();

    }

    setState(() {
      loading=false;
    });

  }

}