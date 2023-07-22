


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';


import 'model/Builder_Detail_Model.dart';


class Cost_property extends StatelessWidget{
  Cost_Prop? cost_prop;
  Cost_property(Cost_Prop? cost_prop){
    this.cost_prop=cost_prop;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 330,
                width: 300,
              ),
              Container(
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                child:
                ClipRRect(
                  borderRadius: new BorderRadius.all(Radius.circular(10)),
                  child:FadeInImage.assetNetwork(
                    placeholder: 'assets/loading.png',
                    image:API.property_image+cost_prop!.FeaturedImage.toString(),
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
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 40,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        child: Card(
                            color: Colors.white,
                            //color: AppTheme.statusRequested,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    cost_prop!.PropertyName.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorFile.black,
                                      fontSize: 14,
                                      fontFamily: 'semi',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    cost_prop!.Address.toString(),
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 12,
                                      fontFamily: 'regular',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 4.0),
                                    child: Text(
                                      "by",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11,
                                        fontFamily: 'regular',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    cost_prop!.fullname.toString(),
                                    style: TextStyle(
                                      color:ColorFile.black,
                                      fontSize: 13,
                                      fontFamily: 'semi',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}



