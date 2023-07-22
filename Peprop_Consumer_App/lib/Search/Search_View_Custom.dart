


import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';

class Search_View_Custom extends StatelessWidget{
  late TextEditingController controller;
  Function (String)on_search;
  Search_View_Custom(TextEditingController controller,{required this.on_search}){
    this.controller=controller;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return new Container(
     margin:
     EdgeInsets.only(left: 20, right: 20, top: 15),
     decoration: new BoxDecoration(
         borderRadius: new BorderRadius.all(Radius.circular(30)),
         color: ColorFile.light_background),
     height: 45,
     child: new Row(
       children: [
         new SizedBox(
           width: 10,
         ),
         Image.asset(
           "assets/search.png",
           height: 25,
           width: 25,
         ),
         new SizedBox(
           width: 10,
         ),
         new Expanded(
             child: new Container(
               alignment: Alignment.centerLeft,
               child: widget_("Search Broker/Developer..", controller),
             )),

       ],
     ),
   );
  }
  Widget widget_(String hint, TextEditingController controller) {
    return Container(
      child: TextField(
        controller: controller,
        enabled: true,
        maxLength: 200,

        onChanged: (value) {
          on_search(value.toString());
        },
        style:
        TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          hintStyle:
          TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

}
class Search_View_Project extends StatelessWidget{
  late TextEditingController controller;
  Function (String)on_search;
  Search_View_Project(TextEditingController controller,{required this.on_search}){
    this.controller=controller;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin:
      EdgeInsets.only(left: 20, right: 20, top: 15),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(30)),
          color: ColorFile.light_background),
      height: 45,
      child: new Row(
        children: [
          new SizedBox(
            width: 10,
          ),
          Image.asset(
            "assets/search.png",
            height: 25,
            width: 25,
          ),
          new SizedBox(
            width: 10,
          ),
          new Expanded(
              child: new Container(
                alignment: Alignment.centerLeft,
                child: widget_("Search Project...", controller),
              )),

        ],
      ),
    );
  }
  Widget widget_(String hint, TextEditingController controller) {
    return Container(
      child: TextField(
        controller: controller,
        enabled: true,
        maxLength: 200,

        onChanged: (value) {
          on_search(value.toString());
        },
        style:
        TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          hintStyle:
          TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

}


class Search_Brand extends StatelessWidget{
  late TextEditingController controller;
  Function (String)on_search;
  Search_Brand(TextEditingController controller,{required this.on_search}){
    this.controller=controller;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin:
      EdgeInsets.only(left: 20, right: 20, top: 15),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(30)),
          color: ColorFile.light_background),
      height: 45,
      child: new Row(
        children: [
          new SizedBox(
            width: 10,
          ),
          Image.asset(
            "assets/search.png",
            height: 25,
            width: 25,
          ),
          new SizedBox(
            width: 10,
          ),
          new Expanded(
              child: new Container(
                alignment: Alignment.centerLeft,
                child: widget_("Search here...", controller),
              )),

        ],
      ),
    );
  }
  Widget widget_(String hint, TextEditingController controller) {
    return Container(
      child: TextField(
        controller: controller,
        enabled: true,
        maxLength: 200,

        onChanged: (value) {
          on_search(value.toString());
        },
        style:
        TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          hintStyle:
          TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

}