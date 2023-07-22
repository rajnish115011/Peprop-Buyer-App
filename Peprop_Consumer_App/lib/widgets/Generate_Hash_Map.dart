

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:peprop_consumer_app/Models/Listing_Filter_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Generate_Hash_Map {




























  Future<FormData> get_properties(Listing_Filter_Model model, int length, String menu_id) async {
     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     var  map=new Map<String, dynamic>();

    if(model.legal=="1"){
      map['investment_option'] ="1";
    }
    map['prop_type'] =model.filter_type.toString();
    if(menu_id!=""){
      map['space'] =menu_id.toString();

    }


     map['limit'] = 10;
    map['start'] = length;
    map['city'] =model.city.toString().trim();
    map['order_by'] =model.order_by.toString();
    map['user_id'] = sharedPreferences.getString("user_id").toString();
    if(model.filter_apply==true){
      List<String> selected_prjects = [];
     model.project_status.forEach((element) {
        if(element.checked==true)selected_prjects.add(element.id);
      });
      List<String> selected_furniture = [];
      model.furnishing.forEach((element) {
        if(element.checked==true)selected_furniture.add(element.id);
      });
      List<String> selected_property = [];
      List<String> selected_bhk = [];

         if(model.filter_type==1){
       model.res.forEach((element) {
          if(element.checked==true)selected_property.add(element.id);
        });
        model.room_list.forEach((element) {
          if(element.checked==true)selected_bhk.add(element.unit_type);
        });


      }else{
       model.com.forEach((element) {
          if(element.checked==true)selected_property.add(element.id);
        });
      }

      if(model.filter_apply==true){
        map['min_am'] = model.min_budget.toStringAsFixed(2);
        map['max_am'] = model.max_buget.toStringAsFixed(2);
        map['min_area'] = model.min_area.toStringAsFixed(0);
        map['max_area'] =model.max_area.toStringAsFixed(0);
        map['area_id'] = model.area_id;
        if(selected_prjects.length>0){
          map['proj_status'] =selected_prjects.join(",");
        }

        if(selected_furniture.length>0){
          map['furnishing_status'] =selected_furniture.join(",");
        }

        if(selected_property.length>0){
          map['property_type'] =selected_property.join(",");
        }
        if(!model.prop_name.toString().isEmpty){
          map['proj_name'] =model.prop_name;
        }
        if(selected_bhk.length>0){
          map['unit_type'] =selected_bhk.join(",");
        }



  }
    }
     print(json.encode(map));
      FormData formData = new FormData.fromMap(map);

     return formData;
   }


  Future<FormData> for_book_slot(String type,String full_name,String project,String reason,String date,String slot, Map map) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var  map=new Map<String, dynamic>();
    map['legal_id'] =reason;
    map['full_name'] = full_name;
    map['property_name'] = project;
    map['type'] =type;
    map['date'] =date.toString();
    map['mobile'] = sharedPreferences.getString("mobile").toString();
    map['slot'] = slot;
    map['campaign'] = map;
    FormData formData = new FormData.fromMap(map);

    return formData;
  }
  Future<Map> register(String name,String mobile,String email,String password,String city,String state,
   String country,String country_code,String token,String adress,String otp,String otp_id, bool cheked_user_concern, String pin) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var  map=new Map<String, dynamic>();
    map["name"] =name;
    map["mobile"] = mobile;
    map["email"] = email;
    map["password"] =password;
    map["city"] =city;
    map["state"] = state;
    map["country"] = country;
    map["firebase_token"] = token;
    map["c_address"] = adress;
    map["otp"] = otp;
    map["otp_id"] = otp_id;
    map["country_code"] = country_code;
    map["pin_code"] = pin;

    map["pp"] =cheked_user_concern==true?"1":"0";
    FormData formData = new FormData.fromMap(map);
    return map;
  }
}