import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'AppUtils.dart';

class ServiceConfig {
  var dio = Dio();

  ServiceConfig() {
    dio.options.connectTimeout = 25000;
    dio.options.receiveTimeout = 30000;
    dio.options.sendTimeout = 40000;
  }

  String convertLeadDetailDate(String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    var dateLocal = dateTime.toLocal();
    var notificationDate = DateFormat("dd MMM yyyy").format(dateLocal);
    return notificationDate;
  }

  String parseTimeStamp(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    var d12 = DateFormat('MM-dd-yyyy').format(date);
    return d12;
  }


  Future<dynamic> getApiAuth(String url , BuildContext context) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? tokenN = sharedPreferences.getString("token");
    print(tokenN);
    try {
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options,handler){
            var customHeaders = {"Authorization": tokenN};
            print(customHeaders);
            options.headers.addAll(customHeaders);
            return handler.next(options);
          }));
      Response response = await dio.get(url);
      return response;
    } on DioError catch (e) {


      networkError(e,context);
    }
  }

  Future<dynamic> deleteMethod(String url,
      BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    try {
      dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options,RequestInterceptorHandler handler) async {
        var customHeaders = {
          "Authorization": sharedPreferences.getString("token").toString().trim(),
        };
        print(customHeaders);
        options.headers.addAll(customHeaders);
        return handler.next(options);
      }));
      Response response = await dio.delete(url);
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<dynamic> putMethod(String url,
      BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    try {
      dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options,RequestInterceptorHandler handler) async {
        var customHeaders = {
          "Authorization": sharedPreferences.getString("token").toString().trim(),
        };
        print(customHeaders);
        options.headers.addAll(customHeaders);
        return handler.next(options);
      }));
      Response response = await dio.put(url);
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }






  Future<dynamic> pumethod_with_header_body(String url, var body,
      BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    try {
      dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options,RequestInterceptorHandler handler) async {
        var customHeaders = {"Authorization": sharedPreferences.getString("token")};
        options.headers.addAll(customHeaders);
        return handler.next(options);
      }));
      Response response = await dio.put(url, data: body).then((value) => value).catchError((onError){
        //  toAst("Something Went Wrong...!!!",context);
        return null;
      });
      print(response.data.toString());
      return response;
    } on DioError catch (e) {
      print("error"+e.response.toString());
      //  show_network_exception(e,context);
    }
  }


  Future<dynamic> postApiBodyAuthJsonWithOutParam(String url , BuildContext context) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    String? tokenN = sharedPreferences.getString("token").toString().trim();
    try {
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options,handler) async {
            var customHeaders = {
              "Authorization": tokenN
            };
            print("customHeaderssss$customHeaders");
            options.headers.addAll(customHeaders);
            return handler.next(options);
          }));
      Response response = await dio.post(url );
      return response;
    } on DioError catch (e) {
      networkError(e,context);
    }
  }

  Future<dynamic> postApiBodyAuthJson(String url ,var body, BuildContext context) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    String? tokenN = sharedPreferences.getString("token").toString().trim();
    try {
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options,handler) async {
            var customHeaders = {
              "Authorization": tokenN
            };
            print("TOKEN$customHeaders");
            options.headers.addAll(customHeaders);
            return handler.next(options);
          }));

      Response response = await dio.post(url,data: body );
      return response;
    } on DioError catch (e) {

      networkError(e,context);
    }
  }

  Future<void> networkError(DioError e, BuildContext context) async {


    if(e.response!=null&&e.response!.statusCode==400&&e.response.toString().toLowerCase().contains("token")){
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString("token", "null");
      AppUtils.toAst("Login Session Expired..!!",context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
      return;
    }
    if (e.type == DioErrorType.connectTimeout) {
      AppUtils.toAst("Connection Timeout",context);
      return ;
    }
    else if (e.type == DioErrorType.receiveTimeout) {
      AppUtils.toAst("Connection Timeout",context);
      return ;
    } else if (e.type == DioErrorType.other) {
      AppUtils.toAst("Something went wrong.Please try again later.!!",context);
      return ;
    }
    else if (e.response == null) {
      AppUtils.toAst("No Internet Connection",context);
      return ;
    }else if (e.response!.statusCode == 401) {
      if(e.response!.data["message"].toString()=="Unauthenticated."){
        SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        sharedPreferences.setString("token", "null");
        AppUtils.toAst("Login Session Expired..!!",context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
      }else{
        AppUtils.toAst(e.response!.data["message"].toString(),context);
      }



      return;
    }
    else if (e.response!.statusCode == 500) {
      AppUtils.toAst("Internal Server Error",context);
      print(e.response!.data.toString());
      return;
    } else if (e.response!.statusCode == 424) {
      if(e.response!.data["msg"]!=null){
       AppUtils().show_error(context,e.response!.data["msg"]);
      }

      return;
    } else if (e.response!.statusCode == 402) {
      AppUtils.toAst("Duplicate transactions..!!",context);
      print(e.response!.data.toString());
      return;
    }
    else if (e.response!.statusCode == 400) {
      if (e.response!.data["message"] != null) {
        try {
          List<dynamic> list = e.response!.data["message"];
          if(list[0].toString().toString().toLowerCase().trim().contains("invalid token")){
            AppUtils.toAst("Please Login First..!!",context);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
            return;

          }else{
            AppUtils.toAst(list[0],context);
            return null;
          }
        } catch (ee) {
          if(e.response!.data["message"].toString().toLowerCase().trim().contains("invalid token")){

            AppUtils.toAst("Please Login First..!!",context);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
            return;

          }
        }
        return;
      }
      else {

        return ;
      }

    }
    else if (e.response!.statusCode == 404) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data["error"] != null) {
        AppUtils.toAst(e.response!.data["error"].toString(),context);
        return;
      } else {
        AppUtils.toAst("Invalid User!",context);
        return;
      }
    }
    else if (e.response!.statusCode == 302) {
      if (e.response!.data["error"] != null) {
        AppUtils.toAst(e.response!.data["error"].toString(),context);
        return;
      } else {
        AppUtils.toAst("Connection Failed",context);
        return;
      }
    }
    else if (e.response!.statusCode == 461) {
      if (e.response!.data["error"] != null) {
        AppUtils.toAst(e.response!.data["error"].toString(),context);
        return;
      } else {
        AppUtils.toAst("Please verify email Address",context);
        return;
      }
    }
    else {
      if (e.response!.data == null) {
        AppUtils.toAst("Something Went Wrong...",context);
        return;
      }
      else if (e.response!.data["email"] != null) {
        String s = ((e.response!.data["email"]
            .toString()
            .substring(1, e.response!.data["email"]
            .toString()
            .length - 1)));
        AppUtils.toAst(s,context);
        return ;
      }
      else if (e.response!.data["error"] != null) {
        String s = ((e.response!.data["error"].toString()));
        AppUtils.toAst(s,context);
        return ;
      }
      else {
        AppUtils.toAst("Something Went Wrong",context);
        return ;
      }
    }
  }
}