import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/legal/My_Legal_Widget.dart';
import 'package:peprop_consumer_app/legal/Update_Slot.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Models/My_Legal_Enquiry_Model.dart';
import '../Utils/AppUtils.dart';
import '../Utils/ServiceConfig.dart';
import '../widgets/No_Data_Placeholder.dart';

class My_Legal_Enquiry_List extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<My_Legal_Enquiry_List> {

  bool _isLoading = true;

  List<My_Legal_Enquiry_Model>my_list = [];

  @override
  void initState() {
    get_Data(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Scaffold(
        appBar: AppUtils.appBarTitle(context,"My Legal Enquiry"),
        backgroundColor: ColorFile.white,
        body:
        Stack(
          children: [
            _isLoading == true? Center(child: new CircularProgressIndicator(),):
            ListView.builder(
                shrinkWrap: false,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

                itemCount: my_list.length,
                itemBuilder: (context, index) {
                  return new InkWell(child: My_Legal_Widget(my_list[index],edit: () async {
                    var move=await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Update_Slot(my_list[index])));
                    if(move!=null){
                      setState(() {
                        get_Data(context);
                      });
                    }

                  },),onTap: (){

                  },);



                }),
            if(my_list.length == 0 && _isLoading == false)Center(child: No_Data_Placeholder("No Record Found..!!"),)

          ],
        ));
  }

  get_Data(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    Response response=await ServiceConfig().getApiAuth(API.booking_slot_list, context);
    print(response.data.toString());
    if(response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      var notify = response.data["data"] as List;
      my_list = notify.map<My_Legal_Enquiry_Model>((json) =>My_Legal_Enquiry_Model.fromJson(json)).toList();
    }

    setState(() {
      _isLoading=false;
    });


  }

}