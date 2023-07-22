


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Aminities_Model.dart';
import 'package:peprop_consumer_app/Models/Banners_Model.dart';

class App_Banners extends StatelessWidget{
  List<Menu_Slider_Model> sliders=[];
  late BuildContext context;

  App_Banners(List<Menu_Slider_Model> sliders, BuildContext context){
    this.sliders=sliders;
    this.context=context;

  }



  @override
  Widget build(BuildContext context) {
    return

      CarouselSlider(
        items:_createChildren(),
        options: CarouselOptions(
          height: 150,
          aspectRatio: 3 / 1,
          viewportFraction: 1,
          initialPage: 1,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));
  }
  List<Widget> _createChildren() {
    return new List<Widget>.generate(sliders.length, (int index) {
      return InkWell(child: Container(
          margin: const EdgeInsets.all(8.0),
          child:new Stack(
            alignment: Alignment.topRight,
              children: [
              ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.png',
                  image: sliders[index].slider_img.toString(),
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return new Container(height: 0,); //do something
                  },
                ),
              ),

            ],
          )

      ),onTap: (){

      },);
    });
  }
}