




import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';

import '../Color/ColorFile.dart';



class Gallery_list extends StatefulWidget {
  List gallery_list=[];
  String type="";
  Gallery_list(List gallery_list, String type){
    this.gallery_list=gallery_list;
    this.type=type;


  }



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return build_Widget();
  }
}

class build_Widget extends State<Gallery_list>   {

  late ScrollController _scrollController;

  String city="";
  int _currentItem=0;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(child: new Icon(Icons.close,color: ColorFile.black,),onTap: (){
         Navigator.pop(context);
        },),
        actions: [
         Container(alignment: Alignment.center,child:  new Text((_currentItem+1).toString()+" of "+widget.gallery_list.length.toString(),style: new TextStyle(fontSize: 12,color: ColorFile.black,fontFamily: "medium"),),),
          new SizedBox(width: 20,),
        ]



      ),
      body:Stack(
        children: [

          Center(child:
          new Container(
            height: 200,
            child: PageView.builder(
              onPageChanged: (index){
                setState(() {
                  _currentItem=index;
                });
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return new Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child:    ClipRRect(
                    borderRadius:
                    new BorderRadius.all(Radius.circular(0)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.png',
                      image: widget.type=="listing"?API.get_post_images+widget.gallery_list[index]:widget.gallery_list[index],
                      height: 200,
                      fit: BoxFit.fitWidth,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/placeholder.png",
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            height: 200); //do something
                      },
                    ),
                  ),);
              },
              itemCount: widget.gallery_list.length, // Can be null
            ),
          ))

        ],
      )
    );

  }
  void _scrollListener() {
    setState(() {
      var index = (_scrollController.offset / 200).round() + 1;
    });
  }
}