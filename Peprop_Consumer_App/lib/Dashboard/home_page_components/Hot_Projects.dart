

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';

import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Apartments_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Login/Login.dart';
import '../../Properties/Properties_Detail.dart';
import '../../Utils/AppUtils.dart';

class Hot_Projects extends StatelessWidget{

  List<Apartments_Model> _propertiesList=[];
  Hot_Projects(List<Apartments_Model> _propertiesList){
    this._propertiesList=_propertiesList;
  }

  @override
  Widget build(BuildContext context) {
    print("dkjahd");
    return

      Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       if(_propertiesList.length>0) new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 18, right: 16,bottom: 20),
                child: Text(
                  'Hot Projects',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "bold",
                    fontSize: 16,

                  ),
                ),
              ),

            ],
          ),
        ),
        if(_propertiesList.length>0) const SizedBox(
          height: 16,
        ),
        if(_propertiesList.length>0)  new Container(
          margin: EdgeInsets.only(left: 10),
          height: 350,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i){
                return InkWell(
                  onTap: () async {

                    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                    if(sharedPreferences.getString("token").toString()=="null"){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

                    }else
                    var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Properties_Detail(_propertiesList[i].ID,"")));


                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Stack(
                      children: <Widget>[
                        LayoutBuilder(
                          builder: (BuildContext c,
                              BoxConstraints constraints) {





                            return Container(
                              width: MediaQuery.of(context).size.width *
                                  .65,
                              height: constraints.maxHeight - 20,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:NetworkImage(API.property_image+_propertiesList[i].FeaturedImage.toString()),
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.hardLight,
                                  ),
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  bottomLeft: Radius.circular(35),
                                  bottomRight: Radius.circular(35),
                                ),
                              ),
                            );
                          },
                        ),
                          Positioned(
                          top: 15,
                          left: 15,
                          child:new Container(
                              padding: EdgeInsets.all(10),
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(100),
                                  color: ColorFile.white),
                              child: ClipRRect(
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.png',
                                  image: API.builde_logo + _propertiesList[i].builder_logo,
                                  width: 50,
                                  height: 50,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset("assets/placeholder.png",
                                        width: 50,
                                        fit: BoxFit.cover,
                                        height: 50); //do something
                                  },
                                ),
                                borderRadius: new BorderRadius.circular(100),
                              )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xfffd8b00),
                            ),
                            child: Icon(
                              Icons.navigate_next,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 35,
                          left: 10,
                          width:
                          MediaQuery.of(context).size.width * .65,
                          child: ListTile(
                            title: Text(
                              _propertiesList[i]
                                  .PropertyTitle
                                  .toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: "bold"
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment:MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _propertiesList[i].Address.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "medium"
                                  ),
                                ),
                                Text(
                                  "By "+_propertiesList[i]
                                      .builder_name
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "medium"
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              },itemCount: _propertiesList.length),
        ),

        if(_propertiesList.length>0) const SizedBox(
          height: 16,
        ),
      ],
    );
  }

}