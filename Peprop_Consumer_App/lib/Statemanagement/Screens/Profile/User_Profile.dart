



import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peprop_consumer_app/Statemanagement/Controllers/MyProfile_Controller.dart';




class User_Profile extends GetView<MyProfile_Controller>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    body: controller.obx(
    (state) => Container(
        child: Column(
          children: [
            new Text("data")
          ],
        )),

    // here you can put your custom loading indicator, but
    // by default would be Center(child:CircularProgressIndicator())
    onLoading: CircularProgressIndicator(),
    onEmpty:new Container(),
    onError: (error) => Text(''),
    ));
  }

}




