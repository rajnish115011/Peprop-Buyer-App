
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Global_connection/Global_connection.dart';
import '../Utils/AppUtils.dart';
import '../widgets/No_Data_Placeholder.dart';
import 'Notification_Model.dart';
import 'Notification_details.dart';

class Notification_List extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return buildState();
  }

}
class buildState extends State{
  bool loading =false;
  List<Notification_Model>notification_list=[];
  String unread="";
  @override
  void initState() {
    get_notifications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Notifications"),
      body:  Stack(
        children: [
          new SingleChildScrollView(child:  new Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext con,int index){

                  print("point"+notification_list[index].is_view.toString());
                  return new
                  InkWell(child:Card(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10)
                    ),
                    child: Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                        margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                        child:new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(notification_list[index].message_for_sender.toString(),style: TextStyle(color: ColorFile.black,fontSize:12,fontFamily: "regular"),),
                            new SizedBox(height: 10,),
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                               if(notification_list[index].is_view.toString()=="0") Expanded(child: new Container(child: new Text("New",style: Styles().styles_medium(12, Colors.red),),)),
                                Text(AppUtils.server_utc_date_parse(notification_list[index].created_on),style: TextStyle(color: ColorFile.black,fontSize:12,fontFamily: "regular"),),

                              ],
                            )
                          ],
                        )

                    ),),onTap: () async {

                    var res=await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notification_details(notification_list[index].message_for_sender.toString(),notification_list[index].id.toString())));
                    if(res!=null){
                      get_notifications();


                    }

                  },);

                },itemCount:notification_list.length,),
            ],
          ),),
          if(loading==true)Center(child: new CircularProgressIndicator(),),
          if(notification_list.length==0&&loading==false)Center(child: new No_Data_Placeholder("No new Notification..!!"),)

        ],
      ),
    );
  }

  Future<void> get_notifications() async {
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    var _map = new Map<String,String>();
    _map['app_id'] = "1";
    var response=await Global_connection().post_method(_map,context, API.notificationsByUser);
    print(response.toString());
    if(response!=null&&response.data!=null && response.statusCode == 200&&response.data["list"]!=false){
      var notify = response.data["list"] as List;
      notification_list = notify.map<Notification_Model>((json) => Notification_Model.fromJson(json)).toList();

      unread=response.data["unread"].toString();
      prefNew.setString("unread", unread);

    }

    setState(() {
      loading = false;
    });
  }

}
