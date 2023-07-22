

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Properties/View_Property_Model.dart';
import 'package:peprop_consumer_app/builder_profile/Builder_Profile.dart';

import '../Color/ColorFile.dart';
import '../Properties/Gallery_List.dart';


class Widget_Detail_Page_Image_Logo extends StatelessWidget{
  String featureImageUrl="";
  String propertyTitle="";
  String logo="";
  String invoice_insurance="";
  View_Property_Model? view_property_model;

  List gallery_list=[];

  Widget_Detail_Page_Image_Logo(String featureImageUrl, String propertyTitle, List gallery_list, String logo, String invoice_insurance, View_Property_Model? view_property_model){
    this.featureImageUrl=featureImageUrl;
    this.propertyTitle=propertyTitle;
    this.gallery_list=gallery_list;
    this.logo=logo;
    this.invoice_insurance=invoice_insurance;
    this.view_property_model=view_property_model;


  }

  @override
  Widget build(BuildContext context) {
    print(API.builde_logo+view_property_model!.logo.toString());
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      InkWell(child: new Container(
       height: 250,
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
                height: 250,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/placeholder.png",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      height: 250);//do something
                },
              ),
            ),
            new Container(padding: EdgeInsets.all(10),child:new Row(
              children: [
                InkWell(child: Align(
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
                        image:API.builde_logo+view_property_model!.logo.toString(),
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
                ),onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Builder_profile(view_property_model!.BuilderId.toString())));

                },),
                if(invoice_insurance=="1")Expanded(child: new Container(
                  margin: EdgeInsets.all(10),
                  child: new Column(
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(child:  Image.asset("assets/assured.png",height: 80,width: 80,color: ColorFile.white,),),
                        ],
                      )
                    ],
                  ),
                ))



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
                    Icon(Icons.photo_sharp,color: ColorFile.white,size: 15,),
                    new SizedBox(width: 5,),
                    new Text(gallery_list.length.toString(),style: new TextStyle(fontFamily: "bold",fontSize: 12,color: ColorFile.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    new SizedBox(width: 5,),
                  ],
                ),
              ),
            )
          ],
        )

    ),onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Gallery_list(gallery_list,"prop")));
       },),
        new SizedBox(height: 10,),
        new Container(
          child: new Row(
            children: [
              new Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(3),color: ColorFile.lightgray),
                child:new Text(view_property_model!.ProjectStatus.toString(),style: new TextStyle(fontSize: 8,fontFamily: "regular",color: ColorFile.black),),
              ),
              new SizedBox(width: 10,),
              new Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(3),color: ColorFile.lightgray),
                child:new Text(view_property_model!.furnishing_name.toString(),style: new TextStyle(fontSize: 8,fontFamily: "regular",color: ColorFile.black),),
              ),
            ],
          ),
        ),
        new SizedBox(height: 10,),
        new Container(alignment: Alignment.centerLeft,child: new Text((view_property_model!.PropertyType.toString().toString()=="1"?"Residential ":"Commercial ")+ view_property_model!.PropertyTypeName.toString()+" in",style: new TextStyle(fontSize: 12,fontFamily: "regular",color: ColorFile.black),),),
        new SizedBox(height: 5,),
        new Container(alignment: Alignment.centerLeft,child: new Text(view_property_model!.PropertyTitle.toString(),style: new TextStyle(fontSize: 16,fontFamily: "bold",color: ColorFile.black)),),
        new SizedBox(height: 5,),
        new Container(alignment: Alignment.centerLeft,child: new Text("by "+view_property_model!.fullname.toString(),style: new TextStyle(fontSize: 12,fontFamily: "regular",color: ColorFile.black)),),

        new SizedBox(height: 5,),
        new Container(alignment: Alignment.centerLeft,child: new Text(view_property_model!.loc_name.toString()+" , "+view_property_model!.city_name.toString()+" - "+view_property_model!.state_name.toString()+" , "+view_property_model!.country_name.toString(),style: new TextStyle(fontSize: 13,fontFamily: "medium",color: ColorFile.black)),),
        new SizedBox(height: 10,),
        view_property_model!.priceList.length>1?
        new Text( view_property_model!.priceList[0].CurrencyName+" "+ view_property_model!.priceList[0].unit_price+" "+ view_property_model!.priceList[0].name+" - "+ view_property_model!.priceList[ view_property_model!.priceList.length-1].CurrencyName+" "+ view_property_model!.priceList[ view_property_model!.priceList.length-1].unit_price+" "+ view_property_model!.priceList[ view_property_model!.priceList.length-1].name,style: new TextStyle(fontFamily: "bold",fontSize: 18,color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,): view_property_model!.priceList.length==1?
        new Text( view_property_model!.priceList[0].CurrencyName+" "+ view_property_model!.priceList[0].unit_price+" "+ view_property_model!.priceList[0].name,style: new TextStyle(fontFamily: "bold",fontSize: 18,color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,):new Container(),




      ],
    );

  }

}
class Widget_Detail_Page_Image_Logo1 extends StatelessWidget{
  String featureImageUrl="";
  String propertyTitle="";
  String logo="";
  String invoice_insurance="";
  View_Property_Model1? view_property_model;

  List gallery_list=[];

  Widget_Detail_Page_Image_Logo1(String featureImageUrl, String propertyTitle, List gallery_list, String logo, String invoice_insurance, View_Property_Model1? view_property_model){
    this.featureImageUrl=featureImageUrl;
    this.propertyTitle=propertyTitle;
    this.gallery_list=gallery_list;
    this.logo=logo;
    this.invoice_insurance=invoice_insurance;
    this.view_property_model=view_property_model;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new

    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(child: new Container(
            height: 250,
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
                    height: 250,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/placeholder.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          height: 250);//do something
                    },
                  ),
                ),
                new Container(padding: EdgeInsets.all(10),child:new Row(
                  children: [
                    InkWell(child: Align(
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
                    ),onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Builder_profile(view_property_model!.BuilderId.toString())));

                    },),
                    if(invoice_insurance=="1")Expanded(child: new Container(
                      margin: EdgeInsets.all(10),
                      child: new Column(
                        children: [
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Center(child:  Image.asset("assets/assured.png",height: 80,width: 80,color: ColorFile.white,),),
                            ],
                          )
                        ],
                      ),
                    ))



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

                      ],
                    ),
                  ),
                )
              ],
            )

        ),onTap: (){




        },),
        new SizedBox(height: 10,),
        new Container(
          child: new Row(
            children: [
              new Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(3),color: ColorFile.lightgray),
                child:new Text(view_property_model!.ProjectStatus.toString(),style: new TextStyle(fontSize: 8,fontFamily: "regular",color: ColorFile.black),),
              ),
              new SizedBox(width: 10,),
              new Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(3),color: ColorFile.lightgray),
                child:new Text(view_property_model!.furnishing_name.toString(),style: new TextStyle(fontSize: 8,fontFamily: "regular",color: ColorFile.black),),
              ),
            ],
          ),
        ),
        new SizedBox(height: 10,),
        new Container(alignment: Alignment.centerLeft,child: new Text((view_property_model!.PropertyType.toString().toString()=="1"?"Residential ":"Commercial ")+ view_property_model!.PropertyTypeName.toString()+" in",style: new TextStyle(fontSize: 12,fontFamily: "regular",color: ColorFile.black),),),
        new SizedBox(height: 5,),
        new Container(alignment: Alignment.centerLeft,child: new Text(view_property_model!.PropertyTitle.toString(),style: new TextStyle(fontSize: 16,fontFamily: "bold",color: ColorFile.black)),),

        new SizedBox(height: 5,),
        new Container(alignment: Alignment.centerLeft,child: new Text(view_property_model!.loc_name.toString()+" , "+view_property_model!.city_name.toString()+" - "+view_property_model!.state_name.toString()+" , "+view_property_model!.country_name.toString(),style: new TextStyle(fontSize: 13,fontFamily: "medium",color: ColorFile.black)),),
        new SizedBox(height: 10,),
        view_property_model!.priceList.length>1?
        new Text( view_property_model!.priceList[0].CurrencyName+" "+ view_property_model!.priceList[0].unit_price+" "+ view_property_model!.priceList[0].name+" - "+ view_property_model!.priceList[ view_property_model!.priceList.length-1].CurrencyName+" "+ view_property_model!.priceList[ view_property_model!.priceList.length-1].unit_price+" "+ view_property_model!.priceList[ view_property_model!.priceList.length-1].name,style: new TextStyle(fontFamily: "bold",fontSize: 18,color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,): view_property_model!.priceList.length==1?
        new Text( view_property_model!.priceList[0].CurrencyName+" "+ view_property_model!.priceList[0].unit_price+" "+ view_property_model!.priceList[0].name,style: new TextStyle(fontFamily: "bold",fontSize: 18,color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,):new Container(),




      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);

  }

}

