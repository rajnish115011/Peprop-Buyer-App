import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';

import '../Color/ColorFile.dart';
import '../Models/Search_Model.dart';
import '../widgets/AppBar_leading.dart';

class Search_Property_Globally extends StatefulWidget{

  String city="";
  int filter_type=1;

  Search_Property_Globally(String city, int filter_type){
    this.city=city;
    this.filter_type=filter_type;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  Build_Widget();
  }

}

class Build_Widget  extends State<Search_Property_Globally>{
  List<Search_Model>list=[];
  final search=TextEditingController();
  bool loading=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new
    SafeArea(top:false,child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorFile.white,
      appBar:new AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:ColorFile.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        leading: new Container(),
        backgroundColor: ColorFile.white,
        toolbarHeight: 160,
        flexibleSpace:new Container(
          child:  new Column(
            children: [
              new SizedBox(height: 40,),
              AppBar_leading(_scaffoldKey),
              new Container(margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 10),
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(30)),
                    color: ColorFile.light_background
                ),
                height: 45,
                child: new Row(
                  children: [
                    new SizedBox(width: 10,),
                    Image.asset("assets/search.png",height: 25,width: 25,),
                    new SizedBox(width: 10,),
                    new Expanded(child: new Container(
                      alignment: Alignment.centerLeft,
                      child: widget_("Search Projects...",search) ,
                    )),
                    loading==true?new Container(margin: EdgeInsets.only(right: 15),width: 20,height:20,child: new Container(
                      child: new CircularProgressIndicator(),
                    ),):new Container()

                  ],
                ),
              ),
            ],
          ),
        ),


        elevation: 0,


      ),



      body:

      new SingleChildScrollView(

        child:
        new Column(
          children: [

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext con,int index){
                if(widget.filter_type.toString()=="1"&&list[index].property_type.toLowerCase()=="residential")
                  return new

                  InkWell(
                    onTap: (){
                      Navigator.pop(context,list[index]);

                    },
                    child: Container(

                      margin: EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child:new Container(

                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Image.asset("assets/left_properties.png",color: ColorFile.hint_color,width: 20,height: 20,),
                            SizedBox(width: 15),
                            Expanded(child: new Container(
                              height: 60,
                              alignment: Alignment.centerLeft,
                              child:
                              new GestureDetector(

                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text(list[index].property_name+" ("+list[index].location+")",style: new TextStyle(fontSize: 13,fontFamily: "regular"),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),))
                          ],
                        ),
                      ),


                    ),);
                else  if(widget.filter_type.toString()=="2"&&list[index].property_type.toLowerCase()=="commercial")

                  return InkWell(
                    onTap: (){
                      Navigator.pop(context,list[index]);

                    },
                    child: Container(

                      margin: EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child:new Container(

                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Image.asset("assets/left_properties.png",color: ColorFile.hint_color,width: 20,height: 20,),
                            SizedBox(width: 15),
                            Expanded(child: new Container(
                              height: 60,
                              alignment: Alignment.centerLeft,
                              child:
                              new GestureDetector(

                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text(list[index].property_name+" ("+list[index].location+")",style: new TextStyle(fontSize: 13,fontFamily: "regular"),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),))
                          ],
                        ),
                      ),


                    ),);
                else return new Container();


              },itemCount: list.length,),

          ],
        ),
      ),
    ));
  }
  Widget widget_(String hint, TextEditingController controller) {
    return Container(
      child: TextField(
        controller: controller,
        enabled: true,
        maxLength: 200,
        textCapitalization: TextCapitalization.words,
        onChanged: (value){
          if(value.length>2){
            get_properties(value);
          }else{
            setState(() {
              list.clear();
            });
          }
        },
        style:  TextStyle(fontSize:14,fontFamily: "medium",color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 5),
          hintStyle:  TextStyle(fontSize:14,fontFamily: "medium",color: Colors.grey),
          hintText: hint,

          border: InputBorder.none,
          focusedBorder:InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder:InputBorder.none,
          disabledBorder:InputBorder.none,
        ),
      ),
    );
  }



  get_properties(String value) {

    var map = new Map<String, dynamic>();
    map['search'] = value;
    map['city'] = widget.city;

    FormData formData = new FormData.fromMap(map);
    print(map.toString());
    setState(() {
      loading = true;
      list.clear();
    });
    ServiceConfig()
        .postApiBodyAuthJson(API.searchPropForListing,formData, context)
        .then((value) {
      Response response = value;
      if (response != null && response.statusCode == 200) {
        print("lead list api response: " + response.data.toString());
        var notify = response.data["list"] as List;
        list = notify.map<Search_Model>((json) => Search_Model.fromJson(json)).toList();
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        AppUtils.toAst("Something Went Wrong..",context);

        loading = false;

      });
    });
  }
}