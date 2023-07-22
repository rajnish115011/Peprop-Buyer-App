



import 'dart:async';
import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:peprop_consumer_app/Models/Campaign_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Global_connection/Global_connection.dart';
import 'Spin/BoardView.dart';
import 'Spin/Luck.dart';

class Spin_View extends StatefulWidget{
  Offers_List_Refer? list;
  Spin_View(Offers_List_Refer list){
    this.list=list;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends  State<Spin_View> with SingleTickerProviderStateMixin {
  double _angle = 0;
  double _current = -1;
 late  AnimationController _ctrl;
  late Animation _ani;

  bool loading=true;


  static const numBehaviours = 6;
  
  String usedCount="";




  @override
  void initState() {
    super.initState();

    get_is_spin();
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);


  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:Colors.white,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        backgroundColor: Colors.white,
        body:

        new Stack(
          children: [
            if(loading)Center(child: new CircularProgressIndicator(),)else if(usedCount=="0")

              Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.fill

                  )
              ),
              child: AnimatedBuilder(
                  animation: _ani,
                  builder: (context, child) {
                    final _value = _ani.value;
                    final _angle = _value * this._angle;
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        BoardView(items: widget.list!.partitions, current: _current, angle: _angle,reward:widget.list!.reward_type),
                        _buildGo(),
                        _buildResult(_value),
                        Back_arrow(),
                      ],
                    );
                  }),
            )else new Stack(
                children: [
                  Container(height: MediaQuery.of(context).size.height,width:  MediaQuery.of(context).size.width,decoration: new BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background.png"),
                          fit: BoxFit.fill

                      )
                  )),
                  Back_arrow(),
                  Container(
                      padding: EdgeInsets.all(10),
                      child:new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          new Text("Thank you for participating",style: Styles().styles_medium(18, ColorFile.black),),
                          new SizedBox(height: 10,),
                          new Text("you have already completed your spin for this wheel.Stay tuned for more contests",style: Styles().styles_medium(15, ColorFile.black),textAlign: TextAlign.center,),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                            height: 80,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);


                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: Colors.orangeAccent),
                                      child: Shimmer.fromColors(
                                        period: const Duration(milliseconds: 1500),
                                        baseColor: Colors.black,
                                        highlightColor: Colors.orangeAccent,
                                        child:  Text(
                                          "Explore More",style: TextStyle(fontFamily: "bold", fontSize: 16, color: ColorFile.black,),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),



                        ],
                      )),

                ],
              )



          ],
        )


      );
    }

    _buildGo() {
      return Material(
        color: Colors.white,
        shape: CircleBorder(),
        child: InkWell(
          customBorder: CircleBorder(),
          child: Container(
            alignment: Alignment.center,
            height: 65,
            width: 65,
            child: Text(
              "GO",
              style: TextStyle(fontSize: 20.0, fontFamily: "semi"),
            ),
          ),
          onTap:(){
            if(widget.list!.is_spin==false&&widget.list!.click==false){
              setState(() {
                widget.list!.click=true;
              });

              _animation();
            }

          },
        ),
      );
    }

    _animation() {
      if (!_ctrl.isAnimating) {
        var _random = Random().nextDouble();
        _angle = 20 + Random().nextInt(5) + _random;
        _ctrl.forward(from: 0.0).then((_) {
          _current = (_current + _random);
          _current = _current - _current ~/ 1;
          _ctrl.reset();
        });
      }
    }

    int _calIndex(value) {
      var _base = (2 * pi /  widget.list!.partitions.length / 2) / (2 * pi);
      return (((_base + value) % 1) *  widget.list!.partitions.length).floor();
    }

    _buildResult(_value) {
      var _index = _calIndex(_value * _angle + _current);
      String _asset = widget.list!.partitions[_index].partition_points+" "+widget.list!.reward_type.toString();
      if(_ctrl.isDismissed==true&&widget.list!.click==true){
        widget.list!.is_spin=true;
        update(widget.list!.partitions[_index].partition_points);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child:new Text("Congratulation!!\nYou Won "+_asset,style: Styles().styles_bold(20, ColorFile.black),textAlign: TextAlign.center,),
          ),
        );
      }else{
        return new Container();
      }

    }


  Future<void> update(String partition_points) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    var map = new Map<String, dynamic>();
    map['point'] =partition_points.toString();
    map['user_id'] =sharedPreferences.getString("user_id").toString();

    print(map.toString());
    FormData formData = new FormData.fromMap(map);


    print(API.markSpinned+widget.list!.id.toString());
    var response=await Global_connection().post_method(formData,context, API.markSpinned+widget.list!.id.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200){

      print(response.data.toString());


    }

  }

  Future<void> get_is_spin() async {
    setState(() {
      loading=true;
    });
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();


    var map = new Map<String, dynamic>();
    map['user_id'] =sharedPreferences.getString("user_id").toString();

    print(map.toString());
    FormData formData = new FormData.fromMap(map);
    var response=await Global_connection().post_method(formData,context, API.isSpinned+widget.list!.id.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["usedCount"]!=null){
      usedCount=response.data["usedCount"].toString();
      print(response.data.toString());



    }
    setState(() {
      loading=false;
    });


  }

  Widget Back_arrow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 15),
      child: Align(
        alignment: Alignment.topLeft,
        child:InkWell(child: new Container(child: Icon(Icons.arrow_back_ios,color: ColorFile.black,),height: 40,),onTap: (){
          Navigator.pop(context);
        },),
      ),
    );

  }
  }


