import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Models/Apartments_Model.dart';
import '../Properties/Properties_Detail.dart';
import '../wish_list/Styles.dart';
import 'UnicornOutlineButton.dart';

class All_Lands_Widget extends StatelessWidget {
  Random random = new Random();

  // int randomNumber = random.nextInt(100);
  late Apartments_Model apartment;

  All_Lands_Widget(Apartments_Model apartment) {
    this.apartment = apartment;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.topLeft,

      child:
      
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: new BorderRadius.all(Radius.circular(10)),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/loading.png',
              image: apartment.BannerImage,
              height: MediaQuery.of(context).size.height * .2,
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
          Expanded(
              child: new Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.topLeft,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      apartment.PropertyTitle,
                      style: new TextStyle(
                          fontFamily: "bold", fontSize: 18, color: ColorFile.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new Container(
                      child: new Row(
                        children: [
                          new Container(
                              padding: EdgeInsets.all(10),
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(100),
                                  color: ColorFile.white),
                              child: ClipRRect(
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.png',
                                  image:
                                  API.builde_logo + apartment.builder_logo,
                                  width: 50,
                                  height: 50,
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Image.asset("assets/placeholder.png",
                                        width: 50,
                                        fit: BoxFit.cover,
                                        height: 50); //do something
                                  },
                                ),
                                borderRadius: new BorderRadius.circular(100),
                              )),
                          new SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: new Container(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    new Text(
                                      "By " + apartment.builder_name,
                                      style: new TextStyle(
                                          fontFamily: "medium",
                                          fontSize: 16,
                                          color: ColorFile.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    new SizedBox(
                                      height: 5,
                                    ),
                                    new Text(
                                      apartment.Address,
                                      style: new TextStyle(
                                          fontFamily: "regular",
                                          fontSize: 10,
                                          color: ColorFile.white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    new SizedBox(
                                      height: 5,
                                    ),
                                    AppUtils().method_extract(apartment,ColorFile.white),
                                    new SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    apartment.priceList.length > 1
                        ? new Text(
                      apartment.priceList[0].CurrencyName +
                          " " +
                          apartment.priceList[0].unit_price +
                          " " +
                          apartment.priceList[0].name +
                          " - " +
                          apartment.priceList[apartment.priceList.length - 1]
                              .CurrencyName +
                          " " +
                          apartment.priceList[apartment.priceList.length - 1]
                              .unit_price +
                          " " +
                          apartment
                              .priceList[apartment.priceList.length - 1].name,
                      style: new TextStyle(
                          fontFamily: "bold",
                          fontSize: 18,
                          color: ColorFile.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                        : apartment.priceList.length == 1
                        ? new Text(
                      apartment.priceList[0].CurrencyName +
                          " " +
                          apartment.priceList[0].unit_price +
                          " " +
                          apartment.priceList[0].name,
                      style: new TextStyle(
                          fontFamily: "bold",
                          fontSize: 18,
                          color: ColorFile.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                        : new Container(),
                    if (apartment.offer_list.length > 0)
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new SizedBox(
                            height: 20,
                          ),
                          new Text(
                            "Offers",
                            style: new TextStyle(
                                fontFamily: "bold",
                                fontSize: 14,
                                color: ColorFile.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          new SizedBox(
                            height: 5,
                          ),
                          new Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              decoration: new BoxDecoration(
                                  border: new Border.all(
                                      color: ColorFile.white, width: 1)),
                              child: new Row(
                                children: [
                                  new Text(
                                    apartment.offer_list[0].offer_title,
                                    style: new TextStyle(
                                        fontFamily: "semi",
                                        color: ColorFile.white,
                                        fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              )),
                          apartment.offer_list.length > 1
                              ? new Column(
                            children: [
                              new SizedBox(
                                height: 5,
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  new Text(
                                    "Total " +
                                        apartment.offer_list.length
                                            .toString() +
                                        " Offers",
                                    style: new TextStyle(
                                        fontFamily: "semi",
                                        color: ColorFile.white,
                                        fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              )
                            ],
                          )
                              : new Container()
                        ],
                      ),
                    if (apartment.key_feature1 != "")new Container(
                          margin: EdgeInsets.only(top: 20),
                          child: new Row(
                            children: [
                              new Container(
                                height: 5,
                                width: 5,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(100),
                                    color: ColorFile.white),
                              ),
                              new SizedBox(
                                width: 5,
                              ),
                              new Text(
                                apartment.key_feature1,
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    color: ColorFile.white,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    if (apartment.key_feature2 != "")new Container(
                          margin: EdgeInsets.only(top: 20),
                          child: new Row(
                            children: [
                              new Container(
                                height: 5,
                                width: 5,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(100),
                                    color: ColorFile.white),
                              ),
                              new SizedBox(
                                width: 5,
                              ),
                              new Text(
                                apartment.key_feature2,
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    color: ColorFile.white,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    if (apartment.key_feature3 != "")new Container(
                          margin: EdgeInsets.only(top: 20),
                          child: new Row(
                            children: [
                              new Container(
                                height: 5,
                                width: 5,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(100),
                                    color: ColorFile.white),
                              ),
                              new SizedBox(
                                width: 5,
                              ),
                              new Text(
                                apartment.key_feature3,
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    color: ColorFile.white,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    if (apartment.key_feature4 != "")new Container(
                          margin: EdgeInsets.only(top: 20),
                          child: new Row(
                            children: [
                              new Container(
                                height: 5,
                                width: 5,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(100),
                                    color: ColorFile.white),
                              ),
                              new SizedBox(
                                width: 5,
                              ),
                              new Text(
                                apartment.key_feature4,
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    color: ColorFile.white,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    if (apartment.key_feature5 != "")new Container(
                          margin: EdgeInsets.only(top: 20),
                          child: new Row(
                            children: [
                              new Container(
                                height: 5,
                                width: 5,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(100),
                                    color: ColorFile.white),
                              ),
                              new SizedBox(
                                width: 5,
                              ),
                              new Text(
                                apartment.key_feature5,
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    color: ColorFile.white,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),


                  ],
                ),
              )),

          
        ],
      ),
    );
  }


}
