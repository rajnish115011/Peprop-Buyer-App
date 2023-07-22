

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Properties/Book_Now_Properties/Book_Now_Properties.dart';
import 'package:peprop_consumer_app/Properties/Pre_Leased.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../API/API.dart';
import '../Filters/All_Projects_Filter.dart';
import '../Models/Listing_Filter_Model.dart';
import '../Properties/All_Apartments.dart';
import '../Utils/Lg.dart';
import '../Utils/ServiceConfig.dart';

class App_Filters {
  check_location(String type,bool is_all,String city,BuildContext context, bool is_direct_open, String legal, String menu_id) async {
    if (city != "Choose City") {
      AppUtils().showProgressDialog(context);
      get_filters(type,is_all,city,context,is_direct_open,legal,menu_id);

    } else {
      AppUtils().showProgressDialog(context);
      city = await Lg().getGeoLocationPosition();
      get_filters(type,is_all,city,context,is_direct_open,legal,menu_id);

    }
  }


  get_filters(String type,bool is_all,String city,BuildContext context, bool is_direct_open, String legal, String menu_id) {
    Listing_Filter_Model model = new Listing_Filter_Model();
    ServiceConfig().getApiAuth(API.all_master_data, context).then((value) async {
     Response response = value;
     Navigator.of(context, rootNavigator: true).pop("Discard");
      if (response != null && response.statusCode == 200) {
        var property_type = response.data["list"]["property_type"] as List;
        List<PropertyType> all_cat_list = property_type.map<PropertyType>((json) => PropertyType.fromJson(json)).toList();
        List<PropertyType> res =
        (all_cat_list.where((i) => i.property_category_id == "1").toList());
        List<PropertyType> com =
        (all_cat_list.where((i) => i.property_category_id == "2").toList());
        var notify = response.data["list"]["furnishing"] as List;
        List<FurnishingMaster> furnishing_list = notify
            .map<FurnishingMaster>((json) => FurnishingMaster.fromJson(json))
            .toList();
        var size_list = response.data["list"]["size"] as List;
        List<Measurement_Unit> size = size_list
            .map<Measurement_Unit>((json) => Measurement_Unit.fromJson(json))
            .toList();
        var ststus = response.data["list"]["project_status"] as List;
        List<FurnishingMaster> project_status_list = ststus
            .map<FurnishingMaster>((json) => FurnishingMaster.fromJson(json))
            .toList();
        List<Room_Type_Model> room_list = [
          new Room_Type_Model("1", false),
          new Room_Type_Model("2", false),
          new Room_Type_Model("3", false),
          new Room_Type_Model("4", false),
          new Room_Type_Model("5+", false),
        ];
        model.min_budget = 0;
        model.max_buget = 200000000;
        model.room_list = room_list;
        model.res = res;
        model.com = com;
        model.city = city;
        model.order_by=is_all==true?"ASC":"DESC";
        model.measurement = size;
        model.furnishing = furnishing_list;

        model.filter_type = int.parse(type);
        model.project_status = project_status_list;
        model.filter_apply = false;
        model.legal = legal;


        push_method(is_all,context,model,is_direct_open,menu_id);
      }

    }).catchError((onError) {
      Navigator.of(context, rootNavigator: true).pop("Discard");
    });
  }
  Future<void> push_method(bool is_all,BuildContext context, Listing_Filter_Model model,bool is_direct_open, String menu_id) async {
      if(is_direct_open==false){
        var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => All_Projects_Filter(model)));
        if(get_res!=null){
          var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => All_Apartments(model)));
        }
      }else{
        if(menu_id!=""){
          var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pre_Leased(model,menu_id)));

        }else{
          var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => All_Apartments(model)));

        }


      }

  }
  get_direct(String type,bool is_all,String city,BuildContext context, bool is_direct_open) async {
      AppUtils().showProgressDialog(context);
      get_filters(type,is_all,city,context,is_direct_open,"","");

    }
}



class Book_Now {
  check_location(String type,String city,BuildContext context) async {
    if (city != "Choose City") {
      AppUtils().showProgressDialog(context);
      get_filters(type,city,context);

    } else {
      AppUtils().showProgressDialog(context);

      city = await Lg().getGeoLocationPosition();

      get_filters(type,city,context);

    }
  }


  get_filters(String type,String city,BuildContext context) {
    Listing_Filter_Model model = new Listing_Filter_Model();
    ServiceConfig().getApiAuth(API.all_master_data, context).then((value) async {
      Response response = value;
      Navigator.of(context, rootNavigator: true).pop("Discard");

      print('response$response');
      if (response != null && response.statusCode == 200) {
        var property_type = response.data["list"]["property_type"] as List;
        List<PropertyType> all_cat_list = property_type.map<PropertyType>((json) => PropertyType.fromJson(json)).toList();
        List<PropertyType> res =
        (all_cat_list.where((i) => i.property_category_id == "1").toList());
        List<PropertyType> com =
        (all_cat_list.where((i) => i.property_category_id == "2").toList());
        var notify = response.data["list"]["furnishing"] as List;
        List<FurnishingMaster> furnishing_list = notify
            .map<FurnishingMaster>((json) => FurnishingMaster.fromJson(json))
            .toList();
        var size_list = response.data["list"]["size"] as List;
        List<Measurement_Unit> size = size_list
            .map<Measurement_Unit>((json) => Measurement_Unit.fromJson(json))
            .toList();
        var ststus = response.data["list"]["project_status"] as List;
        List<FurnishingMaster> project_status_list = ststus
            .map<FurnishingMaster>((json) => FurnishingMaster.fromJson(json))
            .toList();
        List<Room_Type_Model> room_list = [
          new Room_Type_Model("1", true),
          new Room_Type_Model("2", false),
          new Room_Type_Model("3", false),
          new Room_Type_Model("4", false),
          new Room_Type_Model("5+", false),
        ];

        model.min_budget = 0;
        model.max_buget = 200000000;
        model.room_list = room_list;
        model.res = res;
        model.com = com;
        model.city = city;
        model.order_by="ASC";
        model.measurement = size;
        model.furnishing = furnishing_list;
        model.filter_type = int.parse(type);
        model.project_status = project_status_list;
        model.filter_apply = false;
        var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Book_Now_Properties(model)));

      }
    }).catchError((onError) {
      Navigator.of(context, rootNavigator: true).pop("Discard");
    });
  }
}