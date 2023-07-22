import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Site_Visit/Widget_Site_Visit.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Color/ColorFile.dart';
import '../Cost_Sheet/Cost_Sheet_Details.dart';
import '../Requirements/Requirements_Descriptions.dart';
import '../Utils/AppUtils.dart';
import '../Utils/FireBase_Logs.dart';
import '../Utils/ServiceConfig.dart';
import '../wish_list/Shimmers_Effect.dart';
import 'My_Site_Visit_Model.dart';
import 'Reschedule_Site_Visit.dart';

class My_Site_Visit extends StatefulWidget {
  const My_Site_Visit({Key? key}) : super(key: key);

  @override
  _MySiteVIsitsState createState() => _MySiteVIsitsState();
}

class _MySiteVIsitsState extends State<My_Site_Visit> {

  late String _mobile;
  bool _loading = true;
  bool update = false;


  List<My_Site_Visit_Model> _sitevisitModel = [];
  String user_id="";

  @override
  void initState() {
    super.initState();
    _getSiteVisits();
  }

  _getSiteVisits() async {
    await  FireBase_Logs().log_screen_view("View My Site Visits", "View My Site Visits");

    final prefs = await SharedPreferences.getInstance();
    user_id=prefs.getString("user_id").toString();
    setState(() {
      _mobile = prefs.getString('mobile')!;
    });
    var _map = <String, String>{};
    _map['mobile'] = _mobile;
    print('mobile$_mobile');
    FormData customerData = FormData.fromMap(_map);
    ServiceConfig().postApiBodyAuthJson(API.getSiteVisitByConsumerId, customerData, context).then((value) async {
      Response response = value;
      print(response.data.toString());
      setState(() {
        _loading = false;
      });
      if (response != null && response.statusCode == 200) {
        bool status = response.data["status"];
        if (status) {
          var data = response.data["data"] as List;
          if (data.isEmpty) {

          } else {
            var data = response.data["data"] as List;
            _sitevisitModel = data.map<My_Site_Visit_Model>((json) => My_Site_Visit_Model.fromJson(json)).toList();

          }
        }
      } else {
      }
      setState(() {
        _loading = false;
      });
    });
  }

  acceptRejectSitevisits(String status, int index) async {


    setState(() {
      update=true;
    });
    var _map = <String, String>{};
    _map['task_id'] = _sitevisitModel[index].taskId.toString();
    _map['status'] = status;


    try{
      Response response =await ServiceConfig().postApiBodyAuthJson(API.customersitevisitAcceptReject, _map, context);
      if (response != null && response.statusCode == 200) {
        _sitevisitModel[index].cus_status=status.toString();
      }

    }catch(e){
      print(e.toString());

    }
    setState(() {
      update=false;
    });



  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.appBar(context, 'title'),
      body: SafeArea(
        child: Stack(
          children: [
            (_loading==true)?Shimmers_Effect(): (_sitevisitModel.isEmpty)?
              No_Data_Placeholder('No Site Visit Found'):ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: _sitevisitModel.length,

              itemBuilder: (context, index) {
                return  Widget_Site_Visit(_sitevisitModel[index],"",user_id,accept: (){
                  acceptRejectSitevisits("1",index);

                },reject: (){
                  acceptRejectSitevisits("2",index);
                },reschedule: () async {
                  var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Reschedule_Site_Visit(_sitevisitModel[index],null)));
                  if(response!=null)
                  {
                    _getSiteVisits();

                  }
                },);
              },
            ),
            if(update)Center(child: new CircularProgressIndicator(),),

          ],
        ),
      ),
    );
  }
}
