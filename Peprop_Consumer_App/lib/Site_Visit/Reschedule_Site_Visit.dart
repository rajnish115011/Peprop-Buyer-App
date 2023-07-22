



import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/Site_Visit/My_Site_Visit_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Utils/ServiceConfig.dart';
import '../widgets/Bottom_Button.dart';
import '../widgets/Form_Drop_Down.dart';
import '../widgets/Form_Fields.dart';

class Reschedule_Site_Visit extends StatefulWidget{
  My_Site_Visit_Model? sitevisitModel;
  My_Site? tab_model;
  Reschedule_Site_Visit(My_Site_Visit_Model? sitevisitModel, My_Site? tab_model){
    this.sitevisitModel=sitevisitModel;
    this.tab_model=tab_model;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }

}
class BuildState extends State<Reschedule_Site_Visit> {
  final from = TextEditingController();
  final to = TextEditingController();
  final property_name = TextEditingController();
  bool loading = false;

  String from_date = "";

  String to_date = "";

  @override
  void initState() {
    super.initState();
    set_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppUtils.appBarTitle(context, "Reshedule Site Visit"),
        body:
        Stack(children: [
          new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new SizedBox(height: 50,),
                Form_Fields().book_filed(
                    "Property", property_name, 100, false, true),
                Form_Drop_Down(
                  "Select new meeting time", from, 100, false, true,
                  on_slected: () {
                    DatePicker.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        theme: DatePickerTheme(
                            headerColor: ColorFile.app_color,
                            backgroundColor: Colors.white,
                            cancelStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "medium",
                                fontSize: 22),
                            itemStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "medium",
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "medium",
                                fontSize: 22)),
                        onConfirm: (date) {
                          from_date =
                              AppUtils().parse_Date_time(date.toString());
                          to_date = DateFormat("dd MMM yyyy hh:mm aa").format(
                              date.add(new Duration(hours: 1)));


                          from.text = from_date + " - " + to_date;
                        },
                        locale: LocaleType.en);
                  },),


              ],
            ),
          ),
          if(loading)Center(child: new CircularProgressIndicator(),),
        ],),
        bottomNavigationBar: Bottom_Button("Reshedule", onclick: (value) {
          String ac_date = AppUtils().task_Date(from_date);
          String ac_time = AppUtils().task_time(from_date);
          String tt = AppUtils().task_Date(to_date);
          String to_time = AppUtils().task_time(to_date);
          update(ac_date, ac_time, tt, to_time);
        },));
  }

  set_data() {
    if (widget.tab_model == null) {
      property_name.text = widget.sitevisitModel!.propertyName.toString();
      try {
        String fm = widget.sitevisitModel!.fromSchedule.toString() + " " +
            widget.sitevisitModel!.from_time.toString();
        var dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(fm, false);
        var task = dateTime.toLocal();
        from_date = DateFormat("dd MMM yyyy hh:mm aa").format(task).toString();

        String t = widget.sitevisitModel!.toSchedule.toString() + " " +
            widget.sitevisitModel!.to_time.toString();
        var dateTime_to = DateFormat("yyyy-MM-dd HH:mm").parse(t, false);
        var task_to = dateTime_to.toLocal();
        to_date = DateFormat("dd MMM yyyy hh:mm aa").format(task_to).toString();

        from.text = from_date + " - " + to_date;
      } catch (e) {

      }
    } else {
      property_name.text = widget.tab_model!.PropertyTitle.toString();
      try {
        String fm = widget.sitevisitModel!.fromSchedule.toString() + " " +
            widget.sitevisitModel!.from_time.toString();
        var dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(fm, false);
        var task = dateTime.toLocal();
        from_date = DateFormat("dd MMM yyyy hh:mm aa").format(task).toString();

        String t = widget.sitevisitModel!.toSchedule.toString() + " " +
            widget.sitevisitModel!.to_time.toString();
        var dateTime_to = DateFormat("yyyy-MM-dd HH:mm").parse(t, false);
        var task_to = dateTime_to.toLocal();
        to_date = DateFormat("dd MMM yyyy hh:mm aa").format(task_to).toString();

        from.text = from_date + " - " + to_date;
      } catch (e) {

      }
    }
  }


  void update(String ac_date, String ac_time, String to_date, String to_time) {
    setState(() {
      loading = true;
    });
    var map = Map<String, dynamic>();
    if (widget.tab_model == null) {
      map['id'] = widget.sitevisitModel!.taskId.toString();
      map['task_id'] = "4";
      map['activity_type_id'] = "4";
      map['owner_id'] = widget.sitevisitModel!.owner_id.toString();
      map['subject'] =
          "Site Visit : " + widget.sitevisitModel!.leadName.toString();
      map['property_id'] = widget.sitevisitModel!.propertyId.toString();
      map['lead_id'] = widget.sitevisitModel!.leadId.toString();
      map['from_schedule'] = ac_date;
      map['from_time'] = ac_time;
      map['to_schedule'] = to_date;
      map['to_time'] = to_time;
      map['description'] = widget.sitevisitModel!.description.toString();
    } else {
      map['id'] = widget.tab_model!.task_id.toString();
      map['task_id'] = "4";
      map['activity_type_id'] = "4";
      map['owner_id'] = widget.tab_model!.owner_id.toString();
      map['subject'] = "Site Visit : " + widget.tab_model!.subject.toString();
      map['property_id'] = widget.tab_model!.propertyId.toString();
      map['lead_id'] = widget.tab_model!.lead_id.toString();
      map['from_schedule'] = ac_date;
      map['from_time'] = ac_time;
      map['to_schedule'] = to_date;
      map['to_time'] = to_time;
      map['description'] = widget.tab_model!.description.toString();
    }


    FormData customerData = FormData.fromMap(map);

    ServiceConfig().postApiBodyAuthJson(
        API.updateTaskDetail, customerData, context).then((value) async {
      Response response = value;
      print('response message Sitevisits$response');
      setState(() {
        loading = false;
      });
      if (response != null && response.statusCode == 200) {
        Navigator.pop(context, "response");
      }
    });
  }

}


