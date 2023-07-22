import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import '../API/API.dart';
import '../Global_connection/Global_connection.dart';
import '../Utils/FireBase_Logs.dart';





class Privacy_Policy extends StatefulWidget {







  @override
  State<StatefulWidget> createState() {
    return Build_Statess();
  }

}

class Build_Statess extends State{
  String tnc="";
  bool loading=false;
  @override
  initState() {
    super.initState();
    get_tnc();

  }
  Future<void> get_tnc() async {

    await  FireBase_Logs().log_screen_view("View App Privacy Policy", "View App Privacy Policy");
    setState(() {
      loading=true;
    });

    var response=await Global_connection().post_method(new Map(),context, API.tnc);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      tnc = response.data["data"]["privacy_policy"].toString();



    }
    setState(() {
      loading=false;
    });


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppUtils.appBarTitle(context, "Privacy Policy"),
      body: Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)else new SingleChildScrollView(
            child:  new Container(
              padding: EdgeInsets.all(10),
              child:new Column(
                children: [
                  new Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Flexible(child: Html(data: tnc,
                            style: {
                              "body": Style(
                                  fontFamily: "regular",
                                  fontSize: FontSize(14.0),
                                  color: ColorFile.black

                              ),
                              'html': Style(textAlign: TextAlign.justify,color: ColorFile.black),
                              "table": Style(
                                  color: ColorFile.black,
                                  fontFamily: "Medium"
                              ),
                              "tr": Style(
                                fontFamily: "regular",
                                color: ColorFile.black,
                              ),
                              "th": Style(
                                fontFamily: "regular",
                                color: ColorFile.black,
                              ),
                              "td": Style(
                                fontFamily: "regular",
                                color: ColorFile.black,

                              ),
                              "h1": Style(
                                  fontFamily: "medium"
                              ),
                            },





                          )),
                        ],
                      )),

                ],
              ),
            ),

          )

        ],

      ),
    );
  }
}