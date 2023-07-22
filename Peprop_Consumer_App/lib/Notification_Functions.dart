

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/main.dart';

class Notification_Functions {



  void registerNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {


    String messageN="";
    String name = message.data['title'];
    messageN = message.data['message']!=null&&message.data['message']!=""?message.data['message']:message.data['body'];




    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(channel.id, channel.name, channelDescription: 'your channel description',importance: Importance.max, priority: Priority.high, largeIcon:const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'), ticker: 'ticker',styleInformation: BigTextStyleInformation(""));
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, name, messageN, platformChannelSpecifics, payload: messageN);




  }




}