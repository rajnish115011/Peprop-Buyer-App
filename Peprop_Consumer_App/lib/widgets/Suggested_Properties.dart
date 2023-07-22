

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';

import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Apartments_Model.dart';

import '../../Properties/Properties_Detail.dart';
import '../Models/BrokerPropertiesModel.dart';

class Suggested_Properties extends StatelessWidget{

  List<Sussgested_Model> _propertiesList=[];
  Suggested_Properties(List<Sussgested_Model> _propertiesList){
    this._propertiesList=_propertiesList;
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items:_createChildren(context),
        options: CarouselOptions(
          height: 220,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 1,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));
  }

  List<Widget> _createChildren(BuildContext context) {
    return new List<Widget>.generate(_propertiesList.length, (int index) {
      return InkWell(child: Container(
          margin: const EdgeInsets.all(8.0),
          child:new Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.png',
                  image:API.property_image+_propertiesList[index].FeaturedImage.toString(),
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/placeholder.png",
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ); //do something
                  },
                ),
              ),


              Align(
                alignment: Alignment.bottomCenter,
                child: new Container(
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10) ),
                        color: ColorFile.hexblack
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    height: 85,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: new Container(child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new SizedBox(height: 10,),
                            new Container(child:new Text(_propertiesList[index].propertyTitle.toString(),style: new TextStyle(fontFamily: "medium",fontSize: 14,color: ColorFile.white),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                            new SizedBox(height: 5,),
                            new Container(child:new Text("By "+_propertiesList[index].builder_name.toString(),style: new TextStyle(fontFamily: "medium",fontSize: 14,color: ColorFile.white),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                            new SizedBox(height: 5,),
                            new Container(child:new Text(_propertiesList[index].builder_city.toString()+","+_propertiesList[index].StateName.toString()+"-"+_propertiesList[index].CountryName.toString(),style: new TextStyle(fontFamily: "medium",fontSize: 14,color: ColorFile.white),maxLines: 1,overflow: TextOverflow.ellipsis,),)

                          ],
                        ),)),

                      ],
                    )


                ),
              ),
            ],
          )

      ),onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Properties_Detail(_propertiesList[index].id!,"false")));

      },);
    });
  }

}