

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/BlogModel/BlogModel.dart';

import '../wish_list/Styles.dart';

class Blog_Widgets extends StatelessWidget{
  BImageModel? bimageDet;
  AuthorModel? authorDet;
  String dataNew="";
  late BlogModel blogModel;
  String type="";
  Blog_Widgets(BImageModel? bimageDet, String dataNew, AuthorModel? authorDet, BlogModel blogModel, String type){
    this.bimageDet=bimageDet;
    this.dataNew=dataNew;
    this.authorDet=authorDet;
    this.blogModel=blogModel;
    this.type=type;



  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin:type=="full"? EdgeInsets.only(right: 15,left: 15,top: 10):EdgeInsets.only(right: 15),
      width:type=="full"?MediaQuery.of(context).size.width: MediaQuery.of(context).size.width-100,
      height: 240,
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),border: new Border.all(width: 1,color: ColorFile.lightgray)),

      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                if(bimageDet != null)Expanded(child: new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CachedNetworkImage(imageUrl: "${bimageDet!.imageLink!}")

                    ],
                  ),
                )),
                // bimageDet == null
                //     ? Container(
                //   width: 50,
                //   height: 50,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage(
                //             "assets/user.png"),
                //         fit: BoxFit.cover,
                //       ),
                //       borderRadius: BorderRadius.all(
                //           Radius.circular(100))),
                // )
                //     : Container(
                //   width: 50,
                //   height: 50,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: NetworkImage(
                //             "${bimageDet!.imageLink!}"),
                //         fit: BoxFit.cover,
                //       ),
                //       borderRadius: BorderRadius.all(
                //           Radius.circular(100))),
                // ),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        blogModel
                            .title!
                            .rendered
                            .toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'medium',
                          color: ColorFile.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                      ),

                    ],
                  ),
                )),

              ],
            ),
            Padding(padding: EdgeInsets.only( top: 10),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container(
                    alignment: Alignment.centerLeft,
                    child:
                    Text(Styles.stripHtmlIfNeeded(blogModel
                          .content!
                          .rendered
                          .toString()),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'regular',
                        color: Colors.grey[700],
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                    ),
                  ))

                ],
              ),
            ),
           new Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [

               new SizedBox(height: 10,),
               Text(
                 dataNew,
                 style: TextStyle(
                   fontSize: 12,
                   fontFamily: 'regular',
                   color: Colors.black54,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ],
           )
          ],
        ),
      ),
    );
  }

}