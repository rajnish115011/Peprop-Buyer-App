import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peprop_consumer_app/Rewards/Coupon_types/Users_Coupon.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Model.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Product_Detail.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Varient.dart';
import 'package:peprop_consumer_app/Rewards/ReferAndEarn.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';
import '../../Search/Search_View_Custom.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../../wish_list/Styles.dart';


class Ecommerce_Product extends StatefulWidget{

 String id="";
  Ecommerce_Product(String id){
    this.id=id;
  }




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Ecommerce_Product>{
  List<Product_Model>product=[];
  List<Product_Model>all_product=[];



  @override
  void initState() {
    super.initState();
    get_campaign();



  }

  bool loading=false;
  final search_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new
    Scaffold(
      appBar: AppUtils.appBarTitle(context, "All Products"),
      body:Stack(
        children: [

          if(loading)Center(child: new CircularProgressIndicator(),)
          else if(all_product.length>0) new Column(
            children: [
              Search_Brand(search_controller,on_search: (value){
                onchanged(value.toString());
              }),
              Expanded(child:
              ListView.builder(
                padding: EdgeInsets.all(5),
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: product.length,
                itemBuilder: (BuildContext context, int index) {
                    return InkWell(child: Container(
                      color: ColorFile.white,
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1,child: new Container(
                            color:ColorFile.white ,
                            height: 120,width:120,padding: EdgeInsets.all(5),child: new Image.network(product[index].image[0].toString(),fit: BoxFit.fill,),),),
                          new SizedBox(width: 10,),
                          Expanded(flex: 2,child: new Container(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new SizedBox(height: 10,),
                                new Container(alignment: Alignment.centerLeft,child: new Text(product[index].title.trim(),style: Styles().styles_medium(15, ColorFile.black)),),
                                new SizedBox(height: 5,),
                                if(product[index].sub_title.length>0) new Container(alignment: Alignment.centerLeft,child: new Text(product[index].sub_title.trim(),style: Styles().styles_medium(13, ColorFile.hint_color),maxLines: 3,overflow: TextOverflow.ellipsis,),),
                                if(product[index].sub_title.length>0) new SizedBox(height: 5,),
                                new Padding(padding: EdgeInsets.only(left: 5,right: 5),child:new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if(product[index].discount_price.length>0)new Container(margin: EdgeInsets.only(right: 5),alignment: Alignment.centerLeft,child: new Text("₹"+product[index].discount_price,style: Styles().styles_medium(16, ColorFile.black),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),

                                    new Container(margin: EdgeInsets.only(),alignment: Alignment.centerLeft,child: new Text("₹"+product[index].price,style: Styles().price(product[index].discount_price.length>0?14:8,product[index].discount_price.length>0? ColorFile.hint_color:ColorFile.black, product[index].discount_price.length>0?TextDecoration.lineThrough:TextDecoration.none),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),



                                    if(product[index].discount.length>0)new Container(alignment: Alignment.centerLeft,child: new Text(" ("+product[index].discount+"% off)",style: Styles().styles_medium(12, ColorFile.hint_color),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),


                                    new SizedBox(width: 5,),



                                  ],)),
                                new SizedBox(height: 10,),

                              ],
                            ),))



                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Ecommerce_Product_Detail(product[index])));

                    },

                    );

                },
              ))




            ],
          )else No_Data_Placeholder("Product not Available..!!!")
        ],
      ),

    );
  }



  get_campaign() async {
    setState(() {
      loading=true;
    });
    print(widget.id);
    var response=await Global_connection().get_method(context, API.products+widget.id);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      var notify = response.data["data"] as List;
      product = notify.map<Product_Model>((json) => Product_Model.fromJson(json)).toList();
      all_product = notify.map<Product_Model>((json) => Product_Model.fromJson(json)).toList();
    }
    setState(() {
      loading=false;
    });


  }


  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        product.clear();
        product.addAll(all_product);
      });
    }else{
      product.clear();
      all_product.forEach((element) {
        if(element.title.toString().toLowerCase().contains(value.toString().toLowerCase())){
          product.add(element);
        }
      });
      setState(() {
      });
    }
  }

}