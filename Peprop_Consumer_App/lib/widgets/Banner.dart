import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

import '../dashboard_model/Home_Model.dart';

class Banners extends StatelessWidget{
  List<Home_List_Model> buy_now_list=[];
  late BuildContext context;
  int current=0;
  Function(int) on_changed;
  final CarouselController _controller = CarouselController();
  Banners(List<Home_List_Model> buy_now_list,int current,BuildContext context,{required this.on_changed}){
    this.buy_now_list=buy_now_list;
    this.context=context;
    this.current=current;

  }

  @override
  Widget build(BuildContext context) {
    return new Column(

      children: [

        if(buy_now_list.length>1)

          new Container(child: PageView.builder(
          onPageChanged: (index){
            on_changed(index);


          },
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            return Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
              ),
                margin: const EdgeInsets.all(8.0),
                child:new Stack(
                  alignment: Alignment.topRight,
                  children: [
                    new Container(child: ClipRRect(
                      borderRadius: new BorderRadius.all(Radius.circular(10)),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/loading.png',
                        image: buy_now_list[index].banner.toString(),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return  new Container();
                        },
                      ),
                    ))

                  ],
                )

            );

          },
          itemCount: buy_now_list.length, // Can be null
        ),height: 130,),





        if(buy_now_list.length>1)new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: create_dot(),)

      ],
    );
  }

  List<Widget> create_dot() {
    return new List<Widget>.generate(buy_now_list.length, (int index) {
      return
        Container(
          margin: EdgeInsets.only(right: 2),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:current==index?ColorFile.black:ColorFile.hint_color,
          ),
        );
    });
  }

  fundtion() {


  }
}
