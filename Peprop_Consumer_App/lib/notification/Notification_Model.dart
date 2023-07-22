


import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Notification_Model {
  String id="";
  String label="";
  String message_for_sender="";
  String is_view="";
  String created_on="";


  Notification_Model({required this.id, required this.label,required this.message_for_sender,required this.is_view,required this.created_on});
  factory Notification_Model.fromJson(Map<String, dynamic> json) {
    return Notification_Model(
      id: json["id"].toString(),
      label: json["label"].toString().replaceAll("null", ""),
      message_for_sender: json["message"].toString().replaceAll("null", ""),
      is_view: json["is_view"].toString().replaceAll("", ""),
      created_on: json["created_on"].toString(),



    );
  }




}