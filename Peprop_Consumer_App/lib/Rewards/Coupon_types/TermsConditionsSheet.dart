


import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/Rewards/Spin/Luck.dart';

import '../../Color/ColorFile.dart';
import '../../wish_list/Styles.dart';



class TermsConditionsSheet extends StatefulWidget{

  Function() onSelectionChanged;
  late Offers offer;

  TermsConditionsSheet(Offers offer, {required this.onSelectionChanged}){
    this.offer=offer;

  }



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<TermsConditionsSheet> {
  int selected_price=-1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(

      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,
      ),
      child: new SingleChildScrollView(
        child:Padding(padding: EdgeInsets.all(20),child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(child: new Text("Offer Details",style: Styles().styles_bold(20, ColorFile.black),),),
            new SizedBox(height: 20,),
            new Row(
              children: [
                FDottedLine(
                  color: ColorFile.app_color,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  strokeWidth: 2.0,
                  dottedLength: 10.0,
                  space: 2.0,
                  child:new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 15,right: 15),height: 33,child: new Text(widget.offer.benefits_code.toString()),),
                ),



              ],
            ),
            new SizedBox(height: 20,),

            new Row(
              children: [
                
                new Container(height: 40,width: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),border: new Border.all(width: 1,color: ColorFile.app_color)),child: new Image.asset("assets/offerstag.png"),padding: EdgeInsets.all(10),),
                new SizedBox(width: 20,),
                new Text(widget.offer.benefits.toString().trim(),style: Styles().styles_medium(15, ColorFile.black),),new SizedBox(height: 10,),



              ],
            ),

            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Flexible(child: Html(data:widget.offer.how_to_avail.toString(),
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
                new Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Flexible(child: Html(data:widget.offer.tnc.toString(),
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
            )
          ],
        ),)


      ),
    );
  }


}