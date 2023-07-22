

import 'Broker_profile_Model.dart';

class All_Brokers_Model{
  String? user_id;
  String? full_name;
  String? mobile;
  String? email;
  String? userlevel;
  String? Rera;
  String? incentory_count;
  Broker_Profile_Model?broker_Profile_model;
  String? broker_tasks_count;

    All_Brokers_Model.fromJson(Map<String, dynamic> json) {
     user_id=json["user_id"].toString();
     full_name=json["full_name"].toString();
     mobile=json["mobile"].toString();
     email=json["email"].toString();
     userlevel=json["userlevel"].toString();
     Rera=json["Rera"].toString();
     incentory_count=json["incentory_count"].toString();
     broker_tasks_count=json["broker_tasks_count"].toString();


     if(json["broker_details"]!=null){
       var PropertyLocation = json["broker_details"];
       broker_Profile_model = Broker_Profile_Model.fromJson(PropertyLocation);

     }

  }


}