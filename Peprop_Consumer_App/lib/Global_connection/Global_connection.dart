

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';

class Global_connection {


 Future<dynamic> post_method(var body,BuildContext context,String url) async {

    try{
      var response=await ServiceConfig().postApiBodyAuthJson(url, body, context);
      return response;
    } on DioError catch (e) {

    }


  }
 Future<dynamic> get_method(BuildContext context,String url) async {

   try{
     var response=await ServiceConfig().getApiAuth(url, context);
     return response;
   } on DioError catch (e) {
     AppUtils.toAst(e.toString(),context);
   }


 }

}