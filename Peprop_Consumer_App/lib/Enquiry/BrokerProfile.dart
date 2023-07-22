



import 'package:dio/dio.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Chat/Broker_RM_Chat.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Broker_profile_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/ProfileMenu.dart';
import 'package:peprop_consumer_app/widgets/Suggested_Properties.dart';

import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/BrokerPropertiesModel.dart';
import '../Utils/FireBase_Logs.dart';

class BrokerProfile extends StatefulWidget{
  String name;
  String profileImage;
  String email;
  String mobile;
  String kyc_status;
  String createdOn;
  String req_id;
  String user_id;
  final notes=TextEditingController();
  BrokerProfile({Key? key, required this.name, required this.profileImage, required this.email, required this.mobile, required this.kyc_status, required this.createdOn, required this.req_id, required this.user_id,}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }


}class BuildState extends State<BrokerProfile>{

  bool loading=false;
  bool update=false;


  String acceptStatus = "N/A";
  String compName = "N/A";
  String compType = "N/A";
  String reraNumber = "N/A";
  String since = "N/A";
  String pan = "N/A";
  String gst = "N/A";
  String aadhaar = "N/A";
  String user_level = "";

  final notes=TextEditingController();

  List<Sussgested_Model> property_list = [];
  Broker_Profile_Model? broker_Profile_model;

  @override
  void initState() {
    super.initState();
    _getBrokerProfile();
    create_log();

  }
  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View new Request Developer/Broker List", "View new Request Developer/Broker List");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppUtils.appBar(context, ""),
        body: new Stack(
        children: [
          loading==true?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child:new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(property_list.length>0)Suggested_Properties(property_list),
              new Container(margin: EdgeInsets.all(10),child: new Row(children: [
                Expanded(child: InkWell(child: new Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: new Border.all(width: 1,color: ColorFile.greens)),
                  child: new Text("Accept",style: Styles().styles_bold(14, ColorFile.black),),

                ),onTap: (){
                   acceptRejectProperties("1");
                },),),
                new SizedBox(width: 20,),
                Expanded(child: InkWell(child: new Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: new Border.all(width: 1,color: ColorFile.red_900)),
                  child: new Text("Reject",style: Styles().styles_bold(14, ColorFile.black),),

                ),onTap: (){
                  acceptRejectProperties("2");
                },),),


              ],),),
                InkWell(child: new Container(
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: ColorFile.greens),
                margin: EdgeInsets.all(10),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Text("Chat",style: Styles().styles_bold(14, ColorFile.white),),
                  ],
                ),),onTap: () async {
                final SharedPreferences prefNew =await SharedPreferences.getInstance();
                String mobile=prefNew.getString("mobile").toString();
                var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Broker_RM_Chat(widget.name,mobile,widget.mobile)));

              },),

              if(broker_Profile_model!=null)new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileMenu(title: "NAME", value: "" + (broker_Profile_model!.full_name.toString())+(broker_Profile_model!.user_level=="8"?" (Builder RM)":" (Channel Partner)")),
                  ProfileMenu_Call(title: "MOBILE", value: "+91-" + broker_Profile_model!.mobile.toString()),
                  ProfileMenu(title: "EMAIL", value:  broker_Profile_model!.email.toString()),
                  ProfileMenu(title: "COMPANY NAME", value:  broker_Profile_model!.comp_name.toString()),
                  ProfileMenu(title: "RERA", value:  broker_Profile_model!.rera_number.toString()),
                ],
              ),




              new SizedBox(height: 15,),
              new Container(child: new Column(

                children: [
                  new Container(
                      child:new Row(
                        children: [
                          Expanded(child: new Container(
                            child:new Text("Notes",style: new TextStyle(fontFamily: "medium",color:ColorFile.black,fontSize: 14),),
                          )),


                        ],
                      )
                  ),
                  new SizedBox(height: 10,),
                  FDottedLine(
                    color: ColorFile.lightgray,
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    strokeWidth: 2.0,
                    dottedLength: 10.0,
                    space: 2.0,
                    child: descr("Notes", notes),
                  ),
                ],
              ),margin: EdgeInsets.all(10),),

              new SizedBox(height: 50,),


          ],),



        ),
          if(update==true)Center(child: CircularProgressIndicator(),)

        ]),

    );
  }
  _getBrokerProfile() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String mobile=sharedPreferences.getString("mobile").toString();

    setState(() {
      loading = true;
    });
    Map data = {
       "user_id": widget.user_id,
       "req_id": widget.req_id,
       "mobile":mobile
    };
    print('req_id$data');

    ServiceConfig().postApiBodyAuthJson(API.getUserProfileCP, data, context).then((value) {
      Response response = value;
      print('response User Profile$response');
      if (response != null && response.statusCode == 200) {
        var status = response.data["status"] as bool;
        if (status) {
          var data = response.data['data'];
          if(data==null){
            setState(() {
              loading = false;
            });
          }else{
            if(response.data["broker_details"]!=null){
              var PropertyLocation = response.data["broker_details"];
              broker_Profile_model = Broker_Profile_Model.fromJson(PropertyLocation);

            }

            acceptStatus = response.data['data']['is_approved']??"N/A";

            var notify = response.data["data"]["property_detail"] as List;

            property_list = notify.map<Sussgested_Model>((json) => Sussgested_Model.fromJson(json)).toList();

            print(notify);

            setState(() {
              loading = false;
            });
          }

        } else {
          setState(() {
            loading = false;
          });
        }
      } else {
        setState(() {
          loading = false;
        });
      }
    });

  }

  Future<void> acceptRejectProperties(String statuss) async {
    setState(() {
      update = true;
    });

    Map data = {
      "id": widget.req_id,
      "status": statuss,
    };

    print('data $data');
    ServiceConfig()
        .postApiBodyAuthJson(API.customerAcceptRejectProperty, data, context)
        .then((value) {
      Response response = value;
      print('response Accept/Reject$response');
      if (response != null && response.statusCode == 200) {
        var status = response.data["status"] as bool;
        Navigator.pop(context,"response");

        if (status) {
          setState(() {
            update = false;
            acceptStatus = statuss;
          });
        }
      } else {
        setState(() {
          update = false;
        });
      }
    });
  }
  Widget descr(String hint, TextEditingController controller) {
    return Container(
      height: 100,
      child: TextField(
        controller: controller,
        enabled: false,
        maxLength: 100,
        style:
        TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.black),
        decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
            hintText: hint,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
      ),
    );
  }

}