import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Rewards/All_Brands.dart';
import 'package:peprop_consumer_app/Rewards/Coupon_types/Users_Coupon.dart';
import 'package:peprop_consumer_app/Rewards/My_Coupon/My_Coupon.dart';
import 'package:peprop_consumer_app/Rewards/My_Gift_Card/Gift_Tab.dart';
import 'package:peprop_consumer_app/Rewards/My_Gift_Card/My_Gift_Card.dart';
import 'package:peprop_consumer_app/Rewards/ReferAndEarn.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/API.dart';
import '../All_transactions/Wallet_Transaction.dart';
import '../Color/ColorFile.dart';
import '../Cost_Sheet/model/Builder_Detail_Model.dart';
import '../Global_connection/Global_connection.dart';
import '../Models/Campaign_Model.dart';
import '../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../wish_list/Styles.dart';
import 'My_Gift_Card/My_Gift_Card_Details.dart';
import 'Spin/Luck.dart';

class Coupon_Lists extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State{

  List<Coupon_Categepry_Model>categeory=[];
  List<Coupon_Categepry_Model>brand=[];

  List<Coupon_Categepry_Model>my_coupons=[];
  List<Campaign_Model>campaign=[];







  String wallet_balance="";
  POints? wallet_data_model;

  List<String>banner=[];
  int selected=0;
  bool update=false;

  @override
  void initState() {
    super.initState();
    get_campaign();

  }

  bool loading=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Scaffold(
      appBar: AppUtils.appBarcolor(context, "", ColorFile.dark_blue),
      body:Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),) else if(categeory.length==0&&brand.length==0&&campaign.length==0)No_Data_Placeholder("No Data Found..!!!")else SingleChildScrollView(child: new Column(
              children: [

                new Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                        items:AppUtils().createChildren(banner,context),
                        options: CarouselOptions(
                          height: 200,
                          onPageChanged: (index, reason) {
                            print(index.toString());
                            setState(() {
                             selected=index;
                            });
                          },


                          viewportFraction: 1,
                          initialPage: 1,
                          enableInfiniteScroll: true,
                          autoPlay: true,

                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )),
                    new Container(margin: EdgeInsets.only(bottom: 20),child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: banner.map((image) {
                        int ind =banner.indexOf(image);
                        print("int"+ind.toString());
                        print("selected"+selected.toString());

                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:ind==selected?ColorFile.black:ColorFile.hint_color
                          ),
                        );
                      },
                      ).toList(), // this was the part the I had to add
                    ),),


                  ],
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Wallet_Transaction(true)));

                  },
                  child: new Container(
                  margin: EdgeInsets.all(10),
                  decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.lightgray)),
                  height: 100,
                  child: new Row(
                    children: [
                      Expanded(child:Container(
                        padding: EdgeInsets.all(7),
                        child: new Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [
                            Expanded(child: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(wallet_data_model!.earn_points.toString(),style: Styles().styles_bold(20, Colors.black),),

                                ],
                              ),
                            )),
                            new SizedBox(height: 5,),
                            new Container(
                              child:
                              new Text("Point Earned",
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    fontSize: 13),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,),

                            ),
                            new SizedBox(height: 5,),

                          ],
                        ),

                      )),
                      Expanded(child:Container(
                        padding: EdgeInsets.all(7),
                        child: new Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [
                            Expanded(child: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(wallet_data_model!.redeem_points.toString(),style: Styles().styles_bold(20, Colors.black),),

                                ],
                              ),
                            )),
                            new SizedBox(height: 5,),
                            new Container(
                              child:
                              new Text("Point Redeemed",
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    fontSize: 13),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,),

                            ),
                            new SizedBox(height: 5,),

                          ],
                        ),

                      )),
                      Expanded(child:     Container(
                        padding: EdgeInsets.all(7),


                        child: new Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [
                            Expanded(child: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(wallet_data_model!.balance_points.toString(),style: Styles().styles_bold(20, Colors.black),),

                                ],
                              ),
                            )),
                            new SizedBox(height: 5,),
                            new Container(
                              child:
                              new Text("Balanced Point",
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    fontSize: 13),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,),

                            ),
                            new SizedBox(height: 5,),

                          ],
                        ),

                      )),

                    ],
                  ),),),



                new Container(
                  margin: EdgeInsets.all(10), padding: EdgeInsets.all(10),child:new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [





                    new Text("My Gift Cards & Coupons",style: Styles().styles_bold(15, ColorFile.black),),
                    new SizedBox(height: 20,),
                    GridView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: my_coupons.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        height: 90.0,),
                      itemBuilder: (BuildContext context, int index) {
                        return new InkWell(onTap: (){
                          if(index==0){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Gift_Tab()));
                          } if(index==1){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => My_Coupon()));

                          }
                        },child:Container(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new Container(alignment: Alignment.center,child:Image.asset(my_coupons[index].img_path,height: 55,width: 55,)),
                            new SizedBox(height: 10,),
                            new Container(alignment: Alignment.topCenter,child: new Text(my_coupons[index].cat_name,style: Styles().semi(12, ColorFile.black),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),)


                          ],
                        ),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.lightgray)),)
                        );
                      },
                    ),
                  ],
                ),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.lightgray)),),


                Padding(
                  padding: EdgeInsets.all(10),child: new Column(
                  children: [
                    new SizedBox(height: 20,),



                    if(categeory.length>0) new Container(padding: EdgeInsets.all(10),child:  new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text("Gift cards by Category",style: Styles().styles_bold(15, ColorFile.black),),
                        new SizedBox(height: 20,),
                        GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: categeory.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 4,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            height: 100.0,),
                            itemBuilder: (BuildContext context, int index) {
                            return new
                            InkWell(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Container(alignment: Alignment.center,child:

                                FadeInImage.assetNetwork(
                              placeholder: 'assets/loading.png',
                              image:categeory[index].img_path,
                              width:55,
                              height: 55,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset("assets/placeholder.png",
                                    width: 40,
                                    fit: BoxFit.cover,
                                    height: 40);//do something
                              },
                            )





                                ),
                                new SizedBox(height: 10,),
                                Expanded(child: new Container(alignment: Alignment.topCenter,child: new Text(categeory[index].cat_name+"\n",style: Styles().styles_medium(12, ColorFile.black),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                              ],
                            ),
                            onTap: (){

                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => All_Brands(categeory[index].id,brand)));


                            },
                            );
                          },
                        ),
                      ],
                    ),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.lightgray)),),


                        ListView.builder(
                        padding: EdgeInsets.only(top: 15),
                        itemCount: campaign.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(child:
                          new Container(
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10)),
                            height: 150,
                            child:ClipRRect(borderRadius:new BorderRadius.circular(10) ,child:  CachedNetworkImage(imageUrl:campaign[index].banner.toString(),fit: BoxFit.fill,),),
                          ),onTap: () async {
                            var nav=await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ReferAndEarn(campaign[index])));

                          },);
                        }),


                   if(brand.length>0) new Container(margin: EdgeInsets.only(top: 20),padding: EdgeInsets.all(10),child:  new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text("Gift cards by Brands",style: Styles().styles_bold(15, ColorFile.black),),
                        new SizedBox(height: 20,),
                        GridView.builder(
                          padding: EdgeInsets.all(10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: brand.length>8?8:brand.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 4,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            height: 100.0,),
                            itemBuilder: (BuildContext context, int index) {
                            return index!=7? InkWell(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Container(alignment: Alignment.center,child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.png',
                                  image:brand[index].img_path,
                                  width:45,
                                  height: 45,

                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Image.asset("assets/placeholder.png",
                                        width: 40,
                                        fit: BoxFit.cover,
                                        height: 40);//do something
                                  },
                                )),
                                new SizedBox(height: 10,),
                                Expanded(child: new Container(alignment: Alignment.topCenter,child: new Text(brand[index].cat_name+"\n",style: Styles().styles_medium(12, ColorFile.black),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                              ],
                            ),onTap: (){

                              get(brand[index].id);

                            },):InkWell(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new Container(alignment: Alignment.center,child: Image.asset("assets/viewallarrow.png",height: 50,width: 50,),),
                                  new SizedBox(height: 10,),
                                  Expanded(child: new Container(alignment: Alignment.topCenter,child: new Text("View All",style: Styles().styles_medium(12, ColorFile.black),textAlign: TextAlign.center,),)),

                                ],
                              ),onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => All_Brands("",brand)));

                            },);
                          },
                        ),
                      ],
                    ),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.lightgray)),),

                  ],
                ),)




              ],
            ),)
          ,if(update)Center(child: new CircularProgressIndicator(),)
        ],
      ),
    );
  }

  get_campaign() async {

    my_coupons.add(new Coupon_Categepry_Model(id: '0',cat_name: "Gift Cards",img_path: "assets/menu/giftbox.png",parent: ""));
    my_coupons.add(new Coupon_Categepry_Model(id: '2',cat_name: "Coupon",img_path: "assets/menu/discount.png",parent: ""));
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['user_id'] =sharedPreferences.getString("user_id").toString();
    print(map.toString());
    FormData formData = new FormData.fromMap(map);
    setState(() {
      loading=true;
    });
    var response=await Global_connection().post_method(formData,context, API.getCategory);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["list"]!=null){
      if(response.data["list"]["category"]!=null){
        var notify = response.data["list"]["category"] as List;
        categeory = notify.map<Coupon_Categepry_Model>((json) => Coupon_Categepry_Model.fromJson(json)).toList();
        categeory.forEach((element) {
          element.banner_multiple.forEach((element) {
            banner.add(element.toString());
          });

        });


      } if(response.data["list"]["brand"]!=null){
        var notify = response.data["list"]["brand"] as List;
        brand = notify.map<Coupon_Categepry_Model>((json) => Coupon_Categepry_Model.fromJson(json)).toList();
      }
      if(response.data["list"]["campaigns"]!=null){
        var notify = response.data["list"]["campaigns"] as List;
        campaign = notify.map<Campaign_Model>((json) => Campaign_Model.fromJson(json)).toList();

      }
      var builder_details = response.data["list"]["user_points"];
      wallet_data_model = POints.fromJson(builder_details);



    }
    setState(() {
      loading=false;
    });


  }

  get(String id) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['category_id'] =id;



    FormData formData = new FormData.fromMap(map);
    setState(() {
      update=true;
    });
    var response=await Global_connection().post_method(formData,context, API.getLevelsOffers);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["list"]!=null){
      if(response.data["list"]["gift_cards"]!=null){
        var notify = response.data["list"]["gift_cards"] as List;
        List<Gift_Card> gift_cards = notify.map<Gift_Card>((json) => Gift_Card.fromJson(json)).toList();
        if(gift_cards.length>0){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => My_Gift_Card_Details(gift_cards[0],false)));

        }else{
          AppUtils.toAst("No Gift Card Available..!!", context);

        }

      }






    }


    setState(() {
      update=false;
    });


  }

}