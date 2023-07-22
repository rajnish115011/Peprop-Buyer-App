

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Enquiry/BrokerProfile.dart';
import 'package:peprop_consumer_app/Models/CPModel.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Search/Search_View_Custom.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/My_Enquiry_Request.dart';


class New_Request_Tab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}
class Build_state extends State{
  String _mobileNumber="";
  bool loading=false;
  List<CPModel> cpList = [];
  List<CPModel> all_list = [];


  final search_controller=TextEditingController();
  @override
  void initState() {

    _getCPList();
    create_log();
    super.initState();
  }
  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View New Enquiry Request List", "View New Enquiry Request List");

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widgetNewProperties() ;
  }

  Widget widgetNewProperties() {
    return Stack(
      children: [
        loading == true? Center(child: new CircularProgressIndicator()): all_list.length > 0?
        new Container(child: new Column(
          children: [
            Search_View_Custom(search_controller,on_search: (value){
              onchanged(value.toString());

            }),
            Expanded(child:ListView.builder(
                shrinkWrap: false,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: cpList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: My_Enquiry_Request(cpList[index]),
                    onTap: () async {
                      String name =cpList[index].fullname.toString();
                      String userID =cpList[index].userId.toString();
                      String profileImage =cpList[index].profileImage.toString();
                      String mobile =cpList[index].mobile.toString();
                      String email =cpList[index].email.toString();
                      String kyc_status =cpList[index].kyc_status.toString();
                      String createdOn =cpList[index].createdOn.toString();
                      String req_id =cpList[index].req_id.toString();
                      var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => BrokerProfile(name: name, profileImage: profileImage, email: email, mobile: mobile, kyc_status: kyc_status, createdOn: createdOn, req_id: req_id, user_id: userID,)));
                      if(response!=null){
                        setState(() {
                          cpList.removeAt(index);
                        });
                      }
                    },
                  );
                }),)
          ],
        ),)



        :Center(
            child: No_Data_Placeholder("New Request Not Found.")),

      ],
    );
  }
  Future<void> _getCPList() async {
    final SharedPreferences prefNew = await SharedPreferences.getInstance();
    _mobileNumber = prefNew.getString('mobile')!;
    setState(() {
      loading = true;
    });
    var _map = new Map<String, String>();
    _map['mobile'] = _mobileNumber;
    FormData mobile = new FormData.fromMap(_map);
    print(_map);
    ServiceConfig().postApiBodyAuthJson(API.getCPByLeadidCustomerEnquiry, mobile, context).then((value) {
      Response response = value;
      print('response broker$response');
      if (response != null && response.statusCode == 200&&response.data["data"].toString()!=""&&response.data["data"].toString()!="null") {
        var notify = response.data["data"] as List;
        cpList = notify.map<CPModel>((json) => CPModel.fromJson(json)).toList();
        all_list = notify.map<CPModel>((json) => CPModel.fromJson(json)).toList();


        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        AppUtils.toAst("Something Went Wrong..",context);
        loading = false;
      });
    });
  }

  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        cpList.clear();
        cpList.addAll(all_list);
      });
    }else{
      cpList.clear();
      all_list.forEach((element) {
        print(element.mobile.toString());
        if(element.broker_Profile_model!.full_name.toString().toLowerCase().contains(value.toString().toLowerCase())){
          cpList.add(element);
        }else  if(element.broker_Profile_model!.mobile.toString().toLowerCase().contains(value.toString().toLowerCase())){
          print("flaf");
          cpList.add(element);
        }
      });
      setState(() {

      });
    }
  }
}