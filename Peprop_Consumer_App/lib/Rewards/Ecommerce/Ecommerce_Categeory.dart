import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Rewards/Coupon_types/Users_Coupon.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Brand.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Model.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Varient.dart';
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
import 'Ecommerce_Product.dart';


class Ecommerce_Categeory extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Ecommerce_Categeory>{





  List<Ecommerce_Model>categeory=[];
  List<Ecommerce_Model>all_categeory=[];


  @override
  void initState() {
    super.initState();
    get_campaign();

  }

  bool loading=false;
  final search_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Scaffold(
      appBar: AppUtils.appBarTitle(context, "All Categories"),
      body:Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)
          else new SingleChildScrollView(
            child: new Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categeory.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(categeory[index].brand_list.length>0)
                            new Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CarouselSlider(
                                  items:AppUtils().createChildren(categeory[index].banner,context),
                                  options: CarouselOptions(
                                    height: 200,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        categeory[index].selected=index;
                                      });
                                    },


                                    viewportFraction: 1,
                                    initialPage: 1,
                                    enableInfiniteScroll: true,

                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  )),
                                new Container(margin: EdgeInsets.only(bottom: 20),child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: categeory[index].banner.map((image) {
                                  int ind = categeory[index].banner.indexOf(image);
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:ind==categeory[index].selected?ColorFile.black:ColorFile.hint_color
                                    ),
                                  );
                                },
                                ).toList(), // this was the part the I had to add
                              ),),


                            ],
                          ),
                          if(categeory[index].brand_list.length>0) new Container(margin: EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),alignment: Alignment.centerLeft,child: new Text(categeory[index].name,style: Styles().styles_medium(20, ColorFile.black),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),
                          GridView.builder(
                            padding: EdgeInsets.all(10),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: categeory[index].brand_list.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 20,
                              height: 80.0,),
                              itemBuilder: (BuildContext context, int i) {
                              return new

                              InkWell(
                                onTap: (){

                                  if(categeory[index].brand_list[i].varient_list.length>0){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Ecommerce_Varient(categeory[index].brand_list[i])));

                                  }else{
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Ecommerce_Product(categeory[index].brand_list[i].id)));

                                  }
                                },
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Expanded(child: new Container(alignment: Alignment.topCenter,child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CachedNetworkImage(width: MediaQuery.of(context).size.width/4-50,height: 50, imageUrl:categeory[index].brand_list[i].logo,)
                              ]))),
                              new SizedBox(height: 10,),
                              new Container(alignment: Alignment.topCenter,child: new Text(categeory[index].brand_list[i].name+"\n",style: Styles().styles_regular(12, ColorFile.black),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),)],));
                            },
                          ),
                          new SizedBox(height: 10,),

                        ],
                      ));
                  },
                ),



              ],
            ),
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

  get_campaign() async {


    setState(() {
      loading=true;
    });
    var response=await Global_connection().get_method(context, API.ecpm_cat);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      var notify = response.data["data"] as List;
      categeory = notify.map<Ecommerce_Model>((json) => Ecommerce_Model.fromJson(json)).toList();
      all_categeory = notify.map<Ecommerce_Model>((json) => Ecommerce_Model.fromJson(json)).toList();

    }
    setState(() {
      loading=false;
    });


  }

}