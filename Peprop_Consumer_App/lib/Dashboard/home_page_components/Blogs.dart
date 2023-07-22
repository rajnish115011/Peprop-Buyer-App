

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Blog_View/Blags_Tab.dart';
import 'package:peprop_consumer_app/Models/BlogModel/BlogModel.dart';

import '../../Blog_View/BlogClass.dart';
import '../../Blog_View/my_webview.dart';
import '../../Color/ColorFile.dart';
import 'package:collection/collection.dart';

import '../../Utils/AppUtils.dart';
import '../../widgets/Blog_Widgets.dart';
class Blogs extends StatelessWidget{
  List<BlogModel> _blogModel=[];
  List<AuthorModel> _getAuthor=[];
  List<BImageModel> _getBImage=[];


  Blogs(List<BlogModel> _blogModel, List<AuthorModel> _getAuthor, List<BImageModel> _getBImage){
    this._blogModel=_blogModel;
    this._getAuthor=_getAuthor;
    this._getBImage=_getBImage;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        Container(
          height: 230,
          margin: EdgeInsets.only(left: 10,top: 20,bottom: 40),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _blogModel.length > 3 ? 3 : _blogModel.length,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final authorDet = _getAuthor.firstWhereOrNull((element) => element.id == _blogModel[index].authorID);
              final bimageDet = _getBImage.firstWhereOrNull((element) => element.id == _blogModel[index].id);
              String dateTime = _blogModel[index].date.toString();
              String newDateTime = dateTime.split("T0").first;
              String dataNew = AppUtils().convert_date3(newDateTime);
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                          selectedUrl:
                          _blogModel[index].link!.toString(),
                        )));

                    // launch(_blogModel[index].link!.toString());
                  },
                  child:Blog_Widgets(bimageDet,dataNew,authorDet,_blogModel[index],"mid")



              );
            },
          ),
        ),

       if(_blogModel.length>0) InkWell(child: new Container(
          height: 60,
          margin: EdgeInsets.only(left: 20,right: 20),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),border: new Border.all(width: 1,color: ColorFile.hexblack)),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text("Explore More News",style: new TextStyle(fontSize: 16,fontFamily: "regular"),)

            ],
          ),
        ),onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Blags_Tab(_getAuthor,_getBImage)));
        },),
        new SizedBox(height: 30,)

      ],
    );
  }

}