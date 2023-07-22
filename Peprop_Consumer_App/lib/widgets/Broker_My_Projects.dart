

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

class Broker_My_Projects extends StatelessWidget{
  late PropertyDetail propertyDetail;
  Broker_My_Projects(PropertyDetail propertyDetail){
    this.propertyDetail=propertyDetail;

  }

  @override
  Widget build(BuildContext context) {
    String myString = propertyDetail.propertyname.toString();
    String smallString = myString.substring(0, 2).toUpperCase();
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CachedNetworkImage(
                  imageUrl: API.baseUrl + '/uploads/property/banner/' + propertyDetail.propertyname.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        //colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      ),
                    ),
                  ),
                  placeholder: (context, url) => AppUtils.progressBar(true),
                  errorWidget: (context, url, error) => Container(
                    child: Center(
                        child: Text(
                          smallString,
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'semi',
                              color: ColorFile.red_900),
                        )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: ColorFile.new_lead),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        propertyDetail.propertyname.toString(),
                        style: const TextStyle(fontFamily: 'semi', fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        propertyDetail.address.toString(),
                        style: const TextStyle(
                            fontSize: 12, color: ColorFile.light_bc),
                      )
                    ],
                  ),
                ),
              ),
              Icon(Icons.remove_red_eye)
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

}