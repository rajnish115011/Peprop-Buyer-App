import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Dashboard/Dashboard.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../Utils/AppUtils.dart';
import '../Utils/FireBase_Logs.dart';
import '../Utils/ServiceConfig.dart';

class Book_Site_Visit extends StatefulWidget {
  String? propId, userId;

  final Function onselected;

  Book_Site_Visit(String propId, String userId,{required this.onselected}) {
    this.propId = propId;
    this.userId = userId;
  }

  @override
  NewSheetState createState() => NewSheetState();
}

class NewSheetState extends State<Book_Site_Visit> {
  bool _loading = false;

  ///==================TIME PICKER==================================================>
  TimeOfDay _time = TimeOfDay.now();

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorFile.app_color,
              onPrimary: ColorFile.yellowdark,
              onSurface: Colors.blueGrey,
            ),
            dialogTheme: const DialogTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
          ),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
    //return _time;
  }

  ///==================DATE PICKER==================================================>
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: ColorFile.app_color,
                onPrimary: ColorFile.white,
                onSurface: Colors.blueGrey,
              ),
              dialogTheme: const DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)))),
            ),
            child: child!,
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2099));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  @override
  void initState()   {
    super.initState();
    create_log();


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height/2-50,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
                topRight: const Radius.circular(15.0),
                topLeft: const Radius.circular(15.0)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 8,
                    ),
                    child: Text(
                      "Do you want to book a site visit?",
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'semi',
                        fontWeight: FontWeight.bold,
                        color: ColorFile.red_900,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                    child: Text(
                      "Please select date & time below",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                      color:  ColorFile.yellowdark,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "I can visit on:  ",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'semi',
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'regular',
                        color:  ColorFile.yellowdark,
                      ),
                    ),
                    IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.orange,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      size: 20,
                      color:  ColorFile.yellowdark,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "I can visit at:  ",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'semi',
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      "${_time.format(context)}",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'regular',
                        color: ColorFile.yellowdark,
                      ),
                    ),
                    IconButton(
                        onPressed: () => _selectTime(),
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.orange,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ]),
          ),
        ),

        ///=============================== BOOK/NO BUTTONS ==============================>
        Positioned(
            bottom: 0,
            left: 5,
            right: 5,
            child: (_loading)
                ? Center(
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator()))
                : Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///===================================== NO =====================================>
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        child: Card(
                          color: Colors.grey[200],
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "No",
                                style: TextStyle(
                                    fontFamily: 'semi',
                                    fontSize: 15,
                                    color: Colors.orange),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///===================================== BOOK ===================================>
                    GestureDetector(
                      onTap: () {
                        _showIntrest(widget.propId.toString(),widget.userId.toString(),1);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        child: Card(
                          color: ColorFile.yellowdark,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Book!",
                                style: TextStyle(
                                    fontFamily: 'semi',
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ]),
    );
  }

  Future<void> _showIntrest(String propId, String userId, int i) async {
    setState(() {
      _loading = true;
    });

    SharedPreferences sp=await SharedPreferences.getInstance();
    var _map = new Map<String, String>();
    _map['user_id'] = sp.getString("user_id").toString();
    _map['prop_id'] = propId;
    if(i==1){
      _map['from_schedule'] =AppUtils().parseDataTimeSeconds(selectedDate.toString());
      _map['from_time'] = _time.format(context).toString();
    }
    print(_map);
    FormData mobile = new FormData.fromMap(_map);
    print(_map);
    ServiceConfig().postApiBodyAuthJson(API.show_intrest, mobile, context).then((value) async {
      Response response = value;
      print(response);
      if (response != null && response.statusCode == 200) {
        setState(() {
          _loading=false;
        });
        var data=await All_Bottom_Sheets().Success_dialog("Thanks for showing interest. Your site visit details will be shared with developer shortly.", context);
        if(data!=null&&data==true){
          widget.onselected();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard()));
        }
        setState(() {
          _loading = false;

        });
      }
    }).catchError((error, stackTrace) {
      AppUtils.toAst("Something Went Wrong..",context);
      setState(() {
        _loading = false;
      });
    });
  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("Book Site Visit Form", "Book Site Visit Form");
  }

}