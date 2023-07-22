

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:peprop_consumer_app/API/API.dart';

import '../../Color/ColorFile.dart';
import 'All_Aminities.dart';

class Detail_Aminity extends StatelessWidget{
  List aminities_list=[];
  String type="";
  Detail_Aminity(List aminities_list, String type){
    this.aminities_list=aminities_list;
    this.type=type;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        new Container(
            margin: EdgeInsets.only(top: 30),
            child: new Container(

              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                      child:Row(
                        children: [
                          Expanded(child: new Container(
                            child:new Text("Key Features",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),
                          )),
                          if(aminities_list.length>8)new InkWell(child:new Container(child: new Text("View All ("+aminities_list.length.toString()+" )",style: new TextStyle(fontFamily: "medium",fontSize: 14,color: ColorFile.app_color),)),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => All_Aminities(aminities_list,type)));

                          },
                          )
                        ],
                      )
                  ),
                  new Container(
                    height: .5,
                    child: new Row(
                      children: [
                        Expanded(child: new Container(
                          color: ColorFile.lightgray,

                        ))
                      ],
                    ),
                  ),
                  new SizedBox(height: 20,),
                  new GridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      children: new List<Widget>.generate(aminities_list.length>8?8:aminities_list.length, (index) {
                        return new GridTile(

                          child:
                            new Container(

                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Container(
                                    child: new Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FadeInImage.assetNetwork(
                                          placeholder: 'assets/loading.png',
                                          image:API.assets+aminities_list[index].logo_image.toString(),
                                          width: 30,
                                          fit: BoxFit.cover,
                                          height: 30,
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return Image.asset("assets/no_data.png",
                                              width: 30,
                                              fit: BoxFit.cover,
                                              height: 30,);//do something
                                          },
                                        ),
                                      ],
                                    ),
                                  ), new SizedBox(height: 15,),new Text(aminities_list[index].name,style: new TextStyle(fontFamily: "regular",fontSize: 10),textAlign: TextAlign.center,)
                                ],
                              ),
                            )
                        );}))


                ],
              ),
            )
        )
      ],
    );
  }

}