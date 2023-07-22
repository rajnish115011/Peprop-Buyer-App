import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

class Form_Title extends StatelessWidget {
  String Title = "";
  String title_2 = "";

  Form_Title(String Title, String title_2) {
    this.Title = Title;
    this.title_2 = title_2;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: [
          Expanded(
              child: new Container(
                child: new Text(
                  Title,
                  style: new TextStyle(fontFamily: "medium"),
                ),
              )),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: new Container(
                child: new Text(
                  title_2,
                  style: new TextStyle(fontFamily: "medium"),
                ),
              ))
        ],
      ),
    );
    // TODO: implement build
  }
}

class Form_Title_content extends StatelessWidget {
  String Title = "";
  String title_2 = "";

  Form_Title_content(String Title, String title_2) {
    this.Title = Title;
    this.title_2 = title_2;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: [
          Expanded(
              child: new Container(
                child: new Text(
                  Title,
                  style: Styles().styles_regular(14, ColorFile.hint_color),
                ),
              )),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: new Container(
                child: new Text(
                  title_2,
                  style: Styles().styles_regular(14, ColorFile.hint_color),
                ),
              ))
        ],
      ),
    );
    // TODO: implement build
  }
}


class Form_Title2 extends StatelessWidget {
  String Title = "";
  String title_2 = "";

  Form_Title2(String Title) {
    this.Title = Title;

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: [
          Expanded(
              child: new Container(
                child: new Text(
                  Title,
                  style: new TextStyle(fontFamily: "medium"),
                ),
              )),

        ],
      ),
    );
    // TODO: implement build
  }
}
class Form_Title2_content extends StatelessWidget {
  String Title = "";


  Form_Title2_content(String Title) {
    this.Title = Title;

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: [
          Expanded(
              child: new Container(
                child: new Text(
                  Title,
                  style: Styles().styles_regular(14, ColorFile.hint_color,),
                  textAlign: TextAlign.justify,
                ),
              )),
          SizedBox(
            width: 15,
          ),

        ],
      ),
    );
    // TODO: implement build
  }
}

