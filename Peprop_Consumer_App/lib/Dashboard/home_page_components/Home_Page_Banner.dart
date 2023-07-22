

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/Apartments_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Color/ColorFile.dart';
import '../../Event/Event_List.dart';
import '../../Login/Login.dart';
import '../../Models/Most_Cities_Model.dart';
import '../../Properties/Properties_Detail.dart';
import '../../legal/Legals.dart';
import '../../loan/Apply_Loan.dart';
import '../../widgets/UnicornOutlineButton.dart';
import '../../wish_list/Styles.dart';

class Home_Page_Banner extends StatelessWidget{
  List<Apartments_Model> buy_now_list=[];
  late BuildContext context;
  Function (int) onchanged;
  int selected_banner=0;
  int current=0;

  Home_Page_Banner(List<Apartments_Model> buy_now_list,BuildContext context, int selected_banner,{required this.onchanged}){
    this.buy_now_list=buy_now_list;
    this.context=context;
    this.selected_banner=selected_banner;

  }

  @override
  Widget build(BuildContext context) {
    return
      new Column(
        children: [
          CarouselSlider(
              items:_createChildren(),
              options: CarouselOptions(
                height: 220,
                onPageChanged: (index, reason) {
                  onchanged(index);


                },
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              )),





          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buy_now_list.map((image) {
              int index = buy_now_list.indexOf(image);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:index==selected_banner?ColorFile.black:ColorFile.hint_color
                ),
              );
            },
            ).toList(), // this was the part the I had to add
          ),
        ],
      );
  }
  List<Widget> _createChildren() {
    return new List<Widget>.generate(buy_now_list.length, (int index) {
      return InkWell(child:
      Container(
          margin: const EdgeInsets.all(8.0),
          child:new Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl:buy_now_list[index].banner,
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,

                ),
              ),


            ],
          )

      ),onTap: () async {

        SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        if(sharedPreferences.getString("token").toString()=="null"){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Login()));

        }


        else if(buy_now_list[index].banner_url.toString().contains("www")){
          AppUtils().open_url(buy_now_list[index].banner_url.toString(),context);

        }else if(buy_now_list[index].banner_url.toString()=="#"){

          AppUtils.toAst("Redirect url is invalid.",context);

        }else if(buy_now_list[index].banner_url.toString()=="?type=loan"){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Apply_Loan(null)));


        }else if(buy_now_list[index].banner_url.toString()=="?type=legal"){

          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Legals()));


        }else{
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Properties_Detail(buy_now_list[index].banner_url,"")));

        }



      },);
    });
  }
}


class Event_Banner extends StatelessWidget{
  List<Event_Model> buy_now_list=[];
  late BuildContext context;
  Function (int) onchanged;
  int selected_banner=0;
  int current=0;

  Event_Banner(List<Event_Model> buy_now_list,BuildContext context, int selected_banner,{required this.onchanged}){
    this.buy_now_list=buy_now_list;
    this.context=context;
    this.selected_banner=selected_banner;

  }

  @override
  Widget build(BuildContext context) {
    return
      new Column(
        children: [
          CarouselSlider(
              items:createevent(),
              options: CarouselOptions(

                onPageChanged: (index, reason) {
                  onchanged(index);


                },


                initialPage: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              )),





          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buy_now_list.map((image) {
              int index = buy_now_list.indexOf(image);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:index==selected_banner?ColorFile.black:ColorFile.hint_color
                ),
              );
            },
            ).toList(), // this was the part the I had to add
          ),
        ],
      );
  }

  List<Widget> createevent() {
    return new List<Widget>.generate(buy_now_list.length, (int index) {
      return InkWell(child:
      Container(
          margin: const EdgeInsets.all(8.0),
          child:new Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>Image.asset("assets/loading.png"),
                  imageUrl:API.event+buy_now_list[index].banner,
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>Image.asset(
                    "assets/placeholder.png",
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),


            ],
          )

      ),onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Event_List(buy_now_list[index].id)));
      },);
    });
  }
}





