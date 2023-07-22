import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Site_Visit/Widget_Site_Visit.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Chat/Broker_RM_Chat.dart';
import '../../Models/BrokerPropertiesModel.dart';
import '../../Models/Broker_profile_Model.dart';
import '../../Properties/Properties_Detail.dart';
import '../../Requirements/Requirements_Descriptions.dart';
import '../../Site_Visit/My_Site_Visit_Model.dart';
import '../../Utils/AppUtils.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../Utils/ServiceConfig.dart';
import '../../widgets/My_Enquiry_Projects.dart';
import '../../widgets/ProfileMenu.dart';
import '../../widgets/Upcomming_Site_Visit.dart';
import '../../widgets/User_Profile_Mode.dart';


class About_Profile extends StatefulWidget {
  BrokerModelEn? brokerModelList;
  Function() on_click;
  About_Profile(BrokerModelEn? brokerModelList,{required this.on_click}){
    this.brokerModelList=brokerModelList;
  }



  @override
  _MySiteVIsitsState createState() => _MySiteVIsitsState();
}

class _MySiteVIsitsState extends State<About_Profile> {


  bool _loading = true;
  Broker_Profile_Model?broker_Profile_model;

  List<My_Site_Visit_Model>sitevisitModel=[];
  List<BrokerPropertiesModel>propertyList=[];
  String user_id="";
  String total_lead="";



  bool update = false;

  @override
  void initState() {
    super.initState();
    get_Sitevisit();
    create_log();

  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View Developer/Broker Profile", "View Developer/Broker Profile");

  }
  get_Sitevisit() async {
    setState(() {
      _loading=true;
    });
    final prefs = await SharedPreferences.getInstance();
     user_id = prefs.getString('user_id')!;
    String mobile = prefs.getString('mobile').toString();



    var _map = <String, String>{};
    _map['customer_id'] = user_id;
    _map['broker_id'] = widget.brokerModelList!.created_by.toString();
    _map['created_by'] = widget.brokerModelList!.created_by.toString();
    _map['mobile'] = mobile;
    print(json.encode(_map));
    FormData customerData = FormData.fromMap(_map);
    try{
      Response response =await ServiceConfig().postApiBodyAuthJson(API.upcommingSiteVisit, customerData, context);

      if (response != null && response.statusCode == 200) {
        if(response.data["count_share_inventory"]!=null&&response.data["count_share_inventory"]["total_lead"]!=null){
          total_lead=response.data["count_share_inventory"]["total_lead"].toString();
        }

        var builder_details = response.data["broker_details"];
        broker_Profile_model = Broker_Profile_Model.fromJson(builder_details);


        var data = response.data["data"] as List;
        sitevisitModel = data.map<My_Site_Visit_Model>((json) => My_Site_Visit_Model.fromJson(json)).toList();

        print(data);

        var notify = response.data["customer_list"] as List;
        propertyList = notify.map<BrokerPropertiesModel>((json) => BrokerPropertiesModel.fromJson(json)).toList();

      }
    }catch(e){
      print(e.toString());

    }
    setState(() {
      _loading=false;
    });


  }


  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        _loading==true?Center(child: new CircularProgressIndicator(),):
        broker_Profile_model!=null?
        new Column(
          children: [
              Expanded(child: new Container(padding: EdgeInsets.all(10),child: SingleChildScrollView(child: new Column(
              children: [
                new SizedBox(height: 20,),
                Card(
                  elevation: .5,
                  child: new Container(padding: EdgeInsets.all(10),child: new Column(
                  children: [
                    new Container(
                      child: new Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/loading.png',
                                image:broker_Profile_model!.user_level.toString()=="3"?(API.chnnale_partner_profile+broker_Profile_model!.profile_image.toString()):(API.builder_profile+broker_Profile_model!.profile_image.toString()),
                                width:70,
                                height: 70,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset("assets/placeholder.png",
                                      width: 70,
                                      fit: BoxFit.cover,
                                      height: 70);//do something
                                },
                              ),
                            ),
                          ),
                          new SizedBox(width: 10,),
                          Expanded(child: new Container(child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Container(child:new Text(broker_Profile_model!.full_name.toString(),style:Styles().styles_bold(15, ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                              new SizedBox(height: 5,),

                            ],
                          ),)),






                        ],
                      ),
                    ),
                    new Container(margin: EdgeInsets.only(top: 20),child: new Row(children: [
                      Expanded(child: InkWell(child: new Container(alignment: Alignment.center,height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.app_color),child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.call,color:ColorFile.white,size: 15,),
                          new SizedBox(width: 10,),
                          new Text("Call",style: Styles().styles_regular(12, ColorFile.white),)
                        ],),),onTap: (){
                        AppUtils().open_dialer(broker_Profile_model!.mobile.toString());
                      },)),
                      new SizedBox(width: 10,),
                      Expanded(child:

                      InkWell(child: new Container(alignment: Alignment.center,height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.app_color),child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.email,color:ColorFile.white,size: 15,),
                          new SizedBox(width: 10,),
                          new Text("Email",style: Styles().styles_regular(12, ColorFile.white),)
                        ],),),onTap: (){
                        AppUtils().launchEmailSubmission(broker_Profile_model!.email.toString());
                      },)),
                      new SizedBox(width: 10,),
                        Expanded(child: InkWell(child: new Container(alignment: Alignment.center,height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.app_color),child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.chat,color:ColorFile.white,size: 15,),
                            new SizedBox(width: 10,),
                            new Text("Chat",style: Styles().styles_regular(12, ColorFile.white),)
                          ],),),onTap: (){
                          open_chat();
                        },)),
                    ],),),





                  ],
                ),),),

                Card(child: new Container(padding: EdgeInsets.all(10),child: new Column(
                  children: [
                    new Container(
                      width: MediaQuery.of(context).size.width,
                      child: new Text("Details",style: new TextStyle(fontFamily: "bold",fontSize: 17),),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Expanded(flex: 4,child: new Container(child: new Text("Mobile Number",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text("+91- "+broker_Profile_model!.mobile.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),))

                      ],),),
                    new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Expanded(flex: 4,child: new Container(child: new Text("Email",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text(broker_Profile_model!.email.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),))

                      ],),),

                    new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Expanded(flex: 4,child: new Container(child: new Text("Company Type",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text((broker_Profile_model!.user_level.toString()=="3"?"Broker":"Developer"),style:Styles().styles_medium(14, ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),))

                      ],),),



                    new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Expanded(flex: 4,child: new Container(child: new Text("Company Name",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text(broker_Profile_model!.comp_name.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),))

                      ],),),


                    new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Expanded(flex: 4,child: new Container(child: new Text("RERA Number",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text(broker_Profile_model!.rera_number.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                      ],),),

                    new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Expanded(flex: 4,child: new Container(child: new Text("Address",style:Styles().styles_regular(14, ColorFile.hint_color),maxLines: 1,overflow: TextOverflow.ellipsis,),)),
                        Expanded(flex: 6,child: new Container(child: new Text(broker_Profile_model!.comp_address.toString(),style:Styles().styles_medium(14, ColorFile.black),maxLines: 5,overflow: TextOverflow.ellipsis,),)),

                      ],),),

                  ],
                ),),),





                if(propertyList.length>0)new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, right: 8, left: 5, bottom: 8),
                      child: Text(
                        'Suggested Projects',
                        style: TextStyle(
                          fontFamily: 'bold',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: propertyList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: My_Enquiry_Projects(propertyList[index],false,null),
                            onTap: () {
                              widget.on_click();

                            },
                          );


                        }),


                  ],),

                new SizedBox(height: 15,),

                Upcomming_Site_Visit(sitevisitModel,broker_Profile_model!.full_name.toString(),user_id,accept: (index){
                  acceptRejectSitevisits("1", index);

                },reject: (index){
                  acceptRejectSitevisits("2", index);


                },reschedule: (){
                  get_Sitevisit();

                },),


              ],
            ),),)),

          ],
        ):Center(child: No_Data_Placeholder("Profile Not Found"),),
        if(update)Center(child: new CircularProgressIndicator(),)



      ],
    );

  }
  acceptRejectSitevisits(String status, int index) async {
    setState(() {
      update=true;
    });
    var _map = <String, String>{};
    _map['task_id'] = sitevisitModel[index].taskId.toString();
    _map['status'] = status;


    try{
      Response response =await ServiceConfig().postApiBodyAuthJson(API.customersitevisitAcceptReject, _map, context);
      if (response != null && response.statusCode == 200) {
        sitevisitModel[index].cus_status=status.toString();
      }

    }catch(e){
      print(e.toString());

    }
    setState(() {
      update=false;
    });



  }

  open_chat() async {
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
    String mobile=prefNew.getString("mobile").toString();
    var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Broker_RM_Chat(broker_Profile_model!.full_name.toString(),mobile,broker_Profile_model!.mobile.toString())));

  }
}
