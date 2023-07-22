



import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Profile/Edit_Profile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:peprop_consumer_app/widgets/ProfileMenu.dart';
import 'package:peprop_consumer_app/widgets/Suggested_Properties.dart';
import 'package:peprop_consumer_app/widgets/User_Profile_Mode.dart';

import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/BrokerPropertiesModel.dart';
import '../widgets/Custom_Elevation_button.dart';

class User_Profile extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }


}class BuildState extends State<User_Profile>{

  bool loading=false;
  bool update=false;


  List<Sussgested_Model> property_list = [];

  User_Profile_Model? profile_model;
  @override
  void initState() {
    super.initState();
    _getBrokerProfile();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppUtils.appBar(context, ""),
        body: new Stack(
        children: [
          if(loading==true)Center(child: CircularProgressIndicator(),)

          else if(profile_model!=null)SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child:new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new SizedBox(height: 30,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  new Container(
                    alignment: Alignment.center,
                    width:100,
                    height: 100,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(100),
                        color: ColorFile.bgs
                    ),
                    child:ClipRRect(child:FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.png',
                      image:API.profile_path+profile_model!.photo.toString(),
                      width:100,
                      height: 100,
                      imageErrorBuilder: (context, error, stackTrace) {
                      return  Container(
                          height: 100,
                          alignment: Alignment.center,
                          width: 100,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: ColorFile.app_color),
                          child: Text(profile_model!.full_name!.length > 1 ? profile_model!.full_name!.substring(0, 2).toUpperCase() : "",style: const TextStyle(fontFamily: "bold", fontSize: 17, color: ColorFile.white)),
                        );
                      },
                    ),  borderRadius: new BorderRadius.circular(100),),
                  ),



                ],),
              const SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profile_model!.full_name!,
                    style: const TextStyle(
                        fontSize: 16, fontFamily: "bold"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(profile_model!.email!, style: const TextStyle(fontSize: 12, fontFamily: "regular"),),
                  const SizedBox(
                    height: 10,
                  ),

                  Custom_Elevation_button("Edit Profile",14,onclick: () async {
                    var response=await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Edit_Profile(profile_model)));
                    if(response!=null){
                      _getBrokerProfile();
                    }
                  },),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),

               new Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(10),
                    color: ColorFile.hex_cyan
                ),
                child: Row(
                  children: [
                    Expanded(child: new Container(
                      child: new Column(
                        children: [
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Container(child: new Text("Your RM Name is ",style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.black),)),
                              new SizedBox(height: 10,),
                              new Container(child: new Text(profile_model!.rm_name!.toString(),style: new TextStyle(fontFamily: "medium",color: ColorFile.app_color),))

                            ],
                          ),
                          new SizedBox(height: 5,),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Container(child: new Text("Mobile Number ",style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.black),)),
                              new SizedBox(height: 10,),
                              new Container(child: new Text(profile_model!.rm_mobile!.toString(),style: new TextStyle(fontFamily: "medium",color: ColorFile.app_color),))

                            ],
                          ),
                          new SizedBox(height: 5,),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Container(child: new Text("Email Id ",style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.black),)),
                              new SizedBox(height: 10,),
                              new Container(child: new Text(profile_model!.rm_email!.toString(),style: new TextStyle(fontFamily: "medium",color: ColorFile.app_color),))

                            ],
                          ),
                        ],
                      ),
                    )),
                    new InkWell(onTap: (){
                      AppUtils().open_dialer(profile_model!.rm_mobile!.toString());

                    },child:new Container(child: new Text("Call",style: new TextStyle(fontSize: 13,color: ColorFile.white,fontFamily: "regular"),),padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.app_color),),)


                  ],
                ),
              ),
              ProfileMenu(title: "MOBILE", value: "+91-" + profile_model!.mobile!),
              ProfileMenu(title: "EMAIL", value: profile_model!.email!,),
              ProfileMenu_verify("PAN NUMBER",  profile_model!.pan!.length==10?"xxxxxx"+ profile_model!.pan!.substring(6,10).toString(): profile_model!.pan!,profile_model),
              ProfileMenu(title: "CITY", value: profile_model!.city_name!,),

              ProfileMenu(title: "Correspondence Address", value: profile_model!.c_address!.length==0?"N/A":profile_model!.c_address!,),

              if(profile_model!.kyc_status=="1")ProfileMenu(title: "Aadhaar Address", value: profile_model!.address!,),




            ],),



        )else Center(child: No_Data_Placeholder("Profile Not Available..!!"),),

        ]),

    );
  }
  _getBrokerProfile() async {
    profile_model=null;
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String user_id=sharedPreferences.getString("user_id").toString();
    setState(() {
      loading = true;
    });
    var map = <String, String>{};
    map['user_id'] = user_id.toString();
    print(map);
    FormData data = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.usersList, data, context).then((value) {
      Response response = value;
      setState(() {
        loading = false;
      });
      print('response User Profile$response');
      if (response != null && response.statusCode == 200&&response.data["list"].toString()!="null") {
        var builder_details = response.data["list"];
        profile_model = User_Profile_Model.fromJson(builder_details);

      }
    }).catchError((onError){
      setState(() {
        loading = false;
      });
    });

  }


}