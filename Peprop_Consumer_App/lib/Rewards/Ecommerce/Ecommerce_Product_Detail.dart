import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peprop_consumer_app/Rewards/Coupon_types/Users_Coupon.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Model.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Product_preview.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Varient.dart';
import 'package:peprop_consumer_app/Rewards/ReferAndEarn.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';
import '../../Search/Search_View_Custom.dart';
import '../../Sheets/All_Bottom_Sheets.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../../wish_list/Styles.dart';


class Ecommerce_Product_Detail extends StatefulWidget{

late Product_Model product;

  Ecommerce_Product_Detail(Product_Model product){
    this.product=product;
  }





  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Ecommerce_Product_Detail>{


  int selected=1;

  String color="";
  bool loading=false;
  int walletBalance=0;
  @override
  void initState() {
    super.initState();

  get_points();
   create_log();

  }

  bool update=false;

  @override
  Widget build(BuildContext context) {
    return new
    Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBar_points(context, "",walletBalance.toString()),
      body:Stack(
        children: [
         if(loading)Center(child: new CircularProgressIndicator(),)else new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                        items:AppUtils().createproduct(widget.product.image,color,context),
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
                      children: widget.product.image.map((image) {
                        int index = widget.product.image.indexOf(image);
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

                new Container(
                  padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                  child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: ReadMoreText((widget.product.title.toString()+" "+widget.product.sub_title.toString())+(widget.product.category.toString().length>0?" by "+widget.product.category.toString():""),
                        trimLines: 2,
                        style: new TextStyle(color: ColorFile.black,fontSize: 15,fontFamily: "medium"),
                        colorClickableText: ColorFile.app_color,
                        trimMode: TrimMode.Line,
                        moreStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                        lessStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                        trimCollapsedText: '...Read More',
                        trimExpandedText: '..show less',
                      ),
                    ),
                    new SizedBox(height: 10,),

                    new Container(height: 25,child:new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Text("Special Price",style: Styles().styles_medium(12, Colors.white)),
                      ],
                    ),padding: EdgeInsets.only(left: 10,right: 10),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.lightgreens[300]),),


                    new SizedBox(height: 10,),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(margin: EdgeInsets.only(left: 5),alignment: Alignment.centerLeft,child: new Text(widget.product.discount+"% off",style: Styles().styles_medium(19,ColorFile.greens),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),new SizedBox(width: 5,),

                        new Container(margin: EdgeInsets.only(left: 5),alignment: Alignment.centerLeft,child: new Text("₹"+widget.product.price,style: Styles().price(19,widget.product.discount_price.length>0? ColorFile.hint_color:ColorFile.black, widget.product.discount_price.length>0?TextDecoration.lineThrough:TextDecoration.none),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),new SizedBox(width: 5,),
                        if(widget.product.discount_price.length>0)new Container(alignment: Alignment.centerLeft,child: new Text("₹"+widget.product.discount_price,style: Styles().styles_medium(19, ColorFile.black),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),

                      ],
                    ),
                    new SizedBox(height: 10,),
                    if(widget.product.seller_name!="null"&&widget.product.seller_name.length>0)
                    new Container(margin: EdgeInsets.only(bottom: 10),alignment: Alignment.centerLeft,child: new Text("Seller Name : "+widget.product.seller_name,style: Styles().styles_regular(14,ColorFile.hint_color),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),new SizedBox(width: 5,),
                    if(widget.product.colors!="null"&&widget.product.colors.length>0)new Container(padding: EdgeInsets.only(bottom: 10),


                      child:  new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [




                          new Container(


                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new SizedBox(height: 20,),
                                new Container(child: new Text("Colors Available",style: Styles().styles_medium(16, Colors.black),),),
                                new SizedBox(height: 20,),
                                new Container(child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:widget.product!.colors.length ,
                                  itemBuilder: (ctx,i){


                                    return new Container(margin: EdgeInsets.only(right: 10),height: 40,width: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: Color(int.parse("0xff"+widget.product.colors[i].toString()))));




                                  },
                                ),height: 40,),
                                new SizedBox(height: 20,),

                              ],
                            ),
                          ),






                        ],
                      ),),

                    new Column(
                      children: [

                        new SizedBox(height: 20,),


                        new Container(

                          child: new Row(
                            children: [
                              Expanded(child: new Container(child: new Column(


                                children: [
                                  new Container(padding: EdgeInsets.all(15),height: 55,width: 55,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100), color: ColorFile.bgs), child: new Image.asset("assets/gif1.png"),),
                                  new SizedBox(height: 10,),
                                  new Text(widget.product.warranty_text.toString(),style: Styles().styles_medium(12, ColorFile.black),textAlign: TextAlign.center,)


                                ],
                              ),)),
                              SizedBox(width: 10,),
                              Expanded(child: new Container(child: new Column(
                                children: [
                                  new Container(padding: EdgeInsets.all(15),height: 55,width: 55,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100), color: ColorFile.bgs),
                                    child: new Image.asset("assets/gif2.png"),

                                  ),
                                  new SizedBox(height: 10,),

                                  new Text(widget.product.cashback.toString(),style: Styles().styles_medium(12, ColorFile.black),textAlign: TextAlign.center,)


                                ],
                              ),)),
                              SizedBox(width: 10,),


                              Expanded(child: new Container(child: new Column(
                                children: [
                                  new Container(padding: EdgeInsets.all(15),height: 55,width: 55,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100), color: ColorFile.bgs),
                                    child: new Image.asset("assets/as.png"),

                                  ),
                                  new SizedBox(height: 10,),

                                  new Text("Peprop Money Assured",style: Styles().styles_medium(12, ColorFile.black),textAlign: TextAlign.center,)


                                ],
                              ),)),

                            ],
                          ),),
                        new SizedBox(height: 20,),
                        new Container(child: new Row(),height: 1,color: ColorFile.lightgray,)
                      ],
                    ),


                  ],
                ),),















                if(widget.product.available_model!="null")new Container(padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide( //                   <--- left side
                          color: ColorFile.lightgray,
                          width: 1.0,
                        ),
                      )),


                  child:  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new SizedBox(height: 20,),
                          new Container(child: new Text("Available Models",style: Styles().styles_medium(16, Colors.black),),),
                          new Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(child: Html(data:widget.product!.available_model.toString(),
                                    style: {
                                      "body": Style(
                                          fontFamily: "regular",
                                          fontSize: FontSize(14.0),
                                          color: ColorFile.black

                                      ),
                                      'html': Style(textAlign: TextAlign.justify,color: ColorFile.black),
                                      "table": Style(
                                          color: ColorFile.black,
                                          fontFamily: "Medium"
                                      ),
                                      "tr": Style(
                                        fontFamily: "regular",
                                        color: ColorFile.black,
                                      ),
                                      "th": Style(
                                        fontFamily: "regular",
                                        color: ColorFile.black,
                                      ),
                                      "td": Style(
                                        fontFamily: "regular",
                                        color: ColorFile.black,

                                      ),
                                      "h1": Style(
                                          fontFamily: "medium"
                                      ),
                                    },





                                  )),
                                ],
                              )),

                          new SizedBox(height: 20,),

                        ],
                      ),


                    ],
                  ),),







                if(widget.product.feature!="null")
                  new Container(padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide( //                   <--- left side
                          color: ColorFile.lightgray,
                          width: 1.0,
                        ),
                      )),


                  child:  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          new SizedBox(height: 20,),


                          new Container(child: new Text("Features",style: Styles().styles_medium(16, Colors.black),),),
                          new Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(child: Html(data:widget.product!.feature.toString(),
                                    style: {
                                      "body": Style(
                                          fontFamily: "regular",
                                          fontSize: FontSize(14.0),
                                          color: ColorFile.black

                                      ),
                                      'html': Style(textAlign: TextAlign.justify,color: ColorFile.black),
                                      "table": Style(
                                          color: ColorFile.black,
                                          fontFamily: "Medium"
                                      ),
                                      "tr": Style(
                                        fontFamily: "regular",
                                        color: ColorFile.black,
                                      ),
                                      "th": Style(
                                        fontFamily: "regular",
                                        color: ColorFile.black,
                                      ),
                                      "td": Style(
                                        fontFamily: "regular",
                                        color: ColorFile.black,

                                      ),
                                      "h1": Style(
                                          fontFamily: "medium"
                                      ),
                                    },





                                  )),
                                ],
                              )),

                          new SizedBox(height: 20,),


                        ],
                      ),



                    ],
                  ),),



                if(widget.product.specification!="null")  new Container(padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide( //                   <--- left side
                          color: ColorFile.lightgray,
                          width: 3.0,
                        ),
                      )),


                  child:  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [



                       new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          new SizedBox(height: 20,),


                          new Container(child: new Text("Specification",style: Styles().styles_medium(16, Colors.black),),),
                          new Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(child: Html(data:widget.product!.specification.toString(),
                                    style: {
                                      "body": Style(
                                          fontFamily: "regular",
                                          fontSize: FontSize(14.0),
                                          color: ColorFile.black

                                      ),
                                      'html': Style(textAlign: TextAlign.justify,color: ColorFile.black),
                                      "table": Style(
                                          color: ColorFile.black,
                                          fontFamily: "Medium"
                                      ),
                                      "tr": Style(
                                        fontFamily: "regular",
                                        color: ColorFile.black,
                                      ),
                                      "th": Style(
                                        fontFamily: "regular",
                                        color: ColorFile.black,
                                      ),
                                      "td": Style(
                                        fontFamily: "regular",
                                        color: ColorFile.black,

                                      ),
                                      "h1": Style(
                                          fontFamily: "medium"
                                      ),
                                    },





                                  )),
                                ],
                              )),

                          new SizedBox(height: 20,),

                        ],
                      ),




                    ],
                  ),),
















                


              ],
            ),
          ),
          if(update)Center(child: new CircularProgressIndicator(),)





        ],
      ),
      bottomNavigationBar: Cofirm_Button("Buy Now",onclick: (value) async {
        int price=0;

        if(widget.product.discount_price.length>0){
          price =int.parse(widget.product.discount_price);
        }else{
          price =int.parse(widget.product.price);
        }
       if(walletBalance>=price){
         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Ecommerce_Product_preview(widget.product,walletBalance)));



       }

       else{
         var data=await All_Bottom_Sheets().error("Your Peprop.Money points are insufficient to make this purchase. Please fund your Peprop.Money point.", context);


       }








      },) ,
    );
  }







  Future<void> get_points() async {
    setState(() {
      loading=true;
    });
    var response=await Global_connection().post_method(new Map(),context, API.walletBalance);
    print(response.data.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["walletBalance"]!=null&&response.data["walletBalance"]!=""){
      walletBalance=int.parse(response.data["walletBalance"].toString());
    }

    setState(() {
      loading=false;
    });


  }
  Future<void> create_log() async {

    var map = new Map<String, dynamic>();
    map['product_id'] =widget.product.id.toString();
    FormData formData = new FormData.fromMap(map);
    var response=await Global_connection().post_method(formData,context, API.logProductsView);



  }





}