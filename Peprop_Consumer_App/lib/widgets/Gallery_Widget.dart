
import 'package:flutter/cupertino.dart';
import 'package:peprop_consumer_app/API/API.dart';


class Gallery_Widget extends StatelessWidget{
  int index=0;
  int size=0;
  late dynamic gallery_list;
  String type="";

  Gallery_Widget(int index, int size, gallery_list, String type){
    this.index=index;
    this.size=size;
    this.gallery_list=gallery_list;
    this.type=type;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.only(left: 10),
      height: 150,
      width: 150,
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
            new BorderRadius.all(Radius.circular(0)),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/loading.png',
              image:type=="listing"?API.get_post_images+gallery_list: gallery_list,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/placeholder.png",
                    width: 150,
                    fit: BoxFit.cover,
                    height: 150); //do something
              },
            ),
          ),


        ],
      ),
    );
  }
  
}