


import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Global_connection/Global_connection.dart';
import 'package:peprop_consumer_app/Models/Campaign_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../Color/ColorFile.dart';
import '../../Models/City_Model.dart';
import '../../Models/User_Model.dart';
import '../../Search/Search_City.dart';
import '../../widgets/Form_Drop_Down.dart';
import '../../widgets/Form_Fields.dart';
import '../../wish_list/Styles.dart';
import 'BoardView.dart';



class User_Form extends StatefulWidget{
  User_Model? list;
  Function (User_Model)onupdate;
  User_Form(User_Model list,{required this.onupdate}){
    this.list=list;
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return User_View();
  }

}

class User_View extends State<User_Form>with SingleTickerProviderStateMixin  {


  final address=TextEditingController();
  final city=TextEditingController();
  final state=TextEditingController();
  final country=TextEditingController();


  final pin=TextEditingController();

  String state_name="";
  String country_name ="";

  @override
  void initState() {
    super.initState();

    address.text=widget.list!.address.toString();
    city.text=widget.list!.city_name.toString();
    pin.text=widget.list!.pin_code.toString();

    state.text=widget.list!.state_name.toString();
    country.text=widget.list!.country_name.toString();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(

        decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,
        ),
        child:new Column(
          children: [
            new SizedBox(height: 20,),
            new Container(alignment: Alignment.center,child: new Text("Change Address",style: Styles().styles_medium(17, Colors.black),),),

            new SizedBox(height: 20,),
            Form_Fields().book_address("Address",address , 200, false, false),
            Form_Drop_Down(
              "City", city, 50, false, true, on_slected: () async {
              var pageResult = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Search_City()));
              if (pageResult != null) {
                setState(() {
                  City_Model model = pageResult;
                  city.text = model.city_name;
                  state.text = model.state_name;
                  country.text = model.country_name;


                });
              }
            },),

            Form_Fields().book_filed("State",state , 200, false, true),
            Form_Fields().book_filed("Country",country , 200, false, true),


            Form_Fields().pins("Pin Code", pin),
            new Container(child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: InkWell(
                  onTap: (){

                    if(address.text.length==0){

                      AppUtils.toAst("Please Enter Delivery Address..!!", context);

                    }
                    else if(pin.text.length<6){

                      AppUtils.toAst("Please Enter 6 Digit Pin Code..!!", context);

                    }else{
                      widget.list!.address=address.text.toString();
                      widget.list!.pin_code=pin.text.toString();
                      widget.list!.city_name=city.text.toString();
                      widget.list!.state_name=state.text.toString();
                      widget.list!.country_name=country.text.toString();
                      widget.onupdate(widget.list!);
                      Navigator.pop(context);


                    }



                  },

                  child: new Container(
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10), color: ColorFile.greens,),
                      margin: EdgeInsets.all(10),
                      height: 60,
                      child:new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new Text("Submit",style: Styles().styles_medium(15, ColorFile.white),),

                        ],)

                  ),)),
              ],
            ),)


          ],
        )


    );
  }


}























class Spin_Sheet extends StatefulWidget{
  Offers_List_Refer? list;
  Function (Offers_List_Refer)onupdate;
  Spin_Sheet(Offers_List_Refer list,{required this.onupdate}){
    this.list=list;
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Spin_Sheet>with SingleTickerProviderStateMixin  {
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
    // TODO: implement build
    return new Container(

      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,
      ),
      child:new Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)else if(usedCount=="0")
            Container(

              decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  image: DecorationImage(
                      image: AssetImage("assets/bggg.png"),
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
                Container(

                    height: MediaQuery.of(context).size.height,width:  MediaQuery.of(context).size.width,decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage("assets/bggg.png"),
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
                                    widget.onupdate(widget.list!);
                                    Navigator.pop(context,);


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
    print(widget.list!.partitions[_index].partition_points);
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
          Navigator.pop(context,widget.list);
        },),
      ),
    );

  }

}