import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Rewards/Coupon_types/Users_Coupon.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Model.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Product.dart';
import 'package:peprop_consumer_app/Rewards/ReferAndEarn.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';
import '../../Search/Search_View_Custom.dart';
import '../../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../../wish_list/Styles.dart';


class Ecommerce_Varient extends StatefulWidget{
  late Brand_Model categeory;
  Ecommerce_Varient(Brand_Model categeory){
    this.categeory=categeory;
  }







  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Ecommerce_Varient>{





  List<Varient_Model>categeory=[];
  List<Varient_Model>all_categeory=[];


  @override
  void initState() {
    super.initState();
    categeory.addAll(widget.categeory.varient_list);
    all_categeory.addAll(widget.categeory.varient_list);




  }

  bool loading=false;
  final search_controller=TextEditingController();
  int selected=0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Scaffold(
      appBar: AppUtils.appBarTitle(context, ""),
      body:Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)
          else   new Column(
            children: [
              new Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                      items:AppUtils().createChildren(widget.categeory.banner,context),
                      options: CarouselOptions(
                        height: 200,
                        onPageChanged: (index, reason) {
                          selected=index;
                        },


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
                  new Container(margin: EdgeInsets.only(bottom: 20),child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.categeory.banner.map((image) {
                      int index = widget.categeory.banner.indexOf(image);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:index==selected?ColorFile.black:ColorFile.hint_color
                        ),
                      );
                    },
                    ).toList(), // this was the part the I had to add
                  ),),

                ],
              ),
              new SizedBox(height: 10,),
              Expanded(child: GridView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categeory.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  height: 100.0,),
                itemBuilder: (BuildContext context, int index) {
                  return new InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(alignment: Alignment.center,child: Image.network(categeory[index].logo,height: 50,width: 50,),),
                        new SizedBox(height: 10,),
                        Expanded(child: new Container(alignment: Alignment.topCenter,child: new Text(categeory[index].name,style: Styles().styles_medium(12, ColorFile.black),textAlign: TextAlign.center,),)),

                      ],
                    ),onTap: (){



                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Ecommerce_Product(categeory[index].id)));


                  },);
                },
              ))




            ],
          )
        ],
      ),
    );
  }


  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        categeory.clear();
        categeory.addAll(all_categeory);
      });
    }else{
      categeory.clear();
      all_categeory.forEach((element) {
        if(element.name.toString().toLowerCase().contains(value.toString().toLowerCase())){
          categeory.add(element);
        }
      });
      setState(() {

      });
    }
  }





}