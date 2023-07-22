import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

class Property_Image_Widget extends StatelessWidget{
  String featureImageUrl="";
  String propertyTitle="";
  String logo="";


  List gallery_list=[];

  Property_Image_Widget(String featureImageUrl, String propertyTitle, String logo){
    this.featureImageUrl=featureImageUrl;
    this.propertyTitle=propertyTitle;
    this.gallery_list=gallery_list;
    this.logo=logo;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      InkWell(child: new Container(
        margin:  EdgeInsets.all(10),
          height: 200,
          width: MediaQuery.of(context).size.width,
          child:Stack(
            children: [
              ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(0)),
                child:
                FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.png',
                  image:API.property_image+featureImageUrl.toString(),
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  height: 200,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/placeholder.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        height: 200);//do something
                  },
                ),
              ),
              new Container(padding: EdgeInsets.all(10),child:new Row(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child:
                      new Container(
                        padding: EdgeInsets.all(10),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(100),
                            color: ColorFile.white
                        ),
                        child:
                        ClipRRect(child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.png',
                          image:API.builde_logo+logo,
                          width:70,
                          height: 70,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset("assets/placeholder.png",
                                width: 70,
                                fit: BoxFit.cover,
                                height: 70);//do something
                          },
                        ),  borderRadius: new BorderRadius.circular(100),),
                      )
                  ),



                ],
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  height: 40,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: new Container(
                        child:new Text("RERA - "+propertyTitle,style: new TextStyle(fontFamily: "medium",fontSize: 14,color: ColorFile.white),maxLines: 1,overflow: TextOverflow.ellipsis,),

                      )),
                      new SizedBox(width: 5,),

                    ],
                  ),
                ),
              )
            ],
          )

      ),onTap: (){
      },);
  }

}