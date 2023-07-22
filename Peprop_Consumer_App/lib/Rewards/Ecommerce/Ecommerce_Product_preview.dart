import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peprop_consumer_app/Kyc/Pan_Verification.dart';
import 'package:peprop_consumer_app/Rewards/Coupon_types/Users_Coupon.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Model.dart';
import 'package:peprop_consumer_app/Rewards/Ecommerce/Ecommerce_Varient.dart';
import 'package:peprop_consumer_app/Rewards/ReferAndEarn.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Dashboard/Dashboard.dart';
import '../../Global_connection/Global_connection.dart';
import '../../Kyc/Aadhar_Verification.dart';
import '../../Models/User_Model.dart';
import '../../Search/Search_View_Custom.dart';
import '../../Sheets/All_Bottom_Sheets.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/Form_Fields.dart';
import '../../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../../wish_list/Styles.dart';


class Ecommerce_Product_preview extends StatefulWidget{

late Product_Model product;

int walletBalance=0;
Ecommerce_Product_preview(Product_Model product, int walletBalance){
    this.product=product;
    this.walletBalance=walletBalance;

}





  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Ecommerce_Product_preview>{


  int selected=1;

  String color="";
  bool loading=false;
  int walletBalance=0;

  final name=TextEditingController();
  final mobile=TextEditingController();
  final email=TextEditingController();
  final address=TextEditingController();
  final city=TextEditingController();
  final state=TextEditingController();
  final country=TextEditingController();
  final pin=TextEditingController();


  bool is_cheked=false;


  @override
  void initState() {
    super.initState();

  get_points();


  }

  bool update=false;
  User_Model? user_model;

  @override
  Widget build(BuildContext context) {
    return new
    Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBar_points(context, "Confirm Order",widget.walletBalance.toString()),
      body:Stack(
        children: [
         if(loading)Center(child: new CircularProgressIndicator(),)else new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                new SizedBox(height: 10,),
                new Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: new Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: CachedNetworkImage(

                        placeholder: (context, url) =>Image.asset("assets/loading.png"),
                        imageUrl:widget.product.image[0],
                        height: 150,



                        errorWidget: (context, url, error) =>Image.asset(
                          "assets/placeholder.png",
                          height: 220,

                        ),
                      ),
                    ),
                    new SizedBox(width: 10,),
                    Expanded(flex: 2,child: new Container(child:
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(child:new Text((widget.product.title.toString()+" "+widget.product.sub_title.toString())+(widget.product.category.toString().length>0?" by "+widget.product.category.toString():""),style: Styles().styles_regular(15, ColorFile.black),) ),
                        new Container(margin: EdgeInsets.only(top: 5),child:new Text("Seller : "+widget.product.seller_name.toString(),style: Styles().styles_regular(15, ColorFile.hint_color),) ),
                        new SizedBox(height: 10,),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(widget.product.discount_price.length>0)new Container(alignment: Alignment.centerLeft,child: new Text("₹"+widget.product.discount_price,style: Styles().styles_medium(16, ColorFile.black),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),
                            new Container(margin: EdgeInsets.only(left: 5),alignment: Alignment.centerLeft,child: new Text("₹"+widget.product.price,style: Styles().price(16,widget.product.discount_price.length>0? ColorFile.hint_color:ColorFile.black, widget.product.discount_price.length>0?TextDecoration.lineThrough:TextDecoration.none),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),),new SizedBox(width: 5,),

                          ],
                        ),
                        new SizedBox(height: 20,),

                      ],
                    ))),
                    new SizedBox(width: 10,),

                  ],
                ),),
                new Container(
                  decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(11)),border: new Border.all(width: 1,color:ColorFile.hint_color)),

                  margin: EdgeInsets.all(10),
                  child: new Column(
                  children: [
                      new Container(
                        decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.greens),
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 1,child: new Container(alignment: Alignment.center,child: new Text("Delivery Details",style: Styles().styles_medium(17, Colors.white),),)),
                        ],
                      ),),

                    new Container(
                      padding: EdgeInsets.all(10),
                      child: new Column(
                        children: [
                          new Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),

                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: new Container(child: new Text("Total  ",style: Styles().styles_medium(15, Colors.black),),)),
                                Expanded(flex: 2,child: new Container(child: new Text("₹"+(widget.product.discount_price.length>0?widget.product.discount_price:widget.product.price),style: Styles().styles_medium(15, ColorFile.hint_color),),))
                              ],
                            ),),
                          new Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),

                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: new Container(child: new Text("Name  ",style: Styles().styles_medium(15, Colors.black),),)),
                                Expanded(flex: 2,child: new Container(child: new Text(name.text.toString(),style: Styles().styles_medium(15, ColorFile.hint_color),),))
                              ],
                            ),),
                          new Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: new Container(child: new Text("Mobile  ",style: Styles().styles_medium(15, Colors.black),),)),
                                Expanded(flex: 2,child: new Container(child: new Text("+91"+mobile.text.toString(),style: Styles().styles_medium(15, ColorFile.hint_color),),))
                              ],
                            ),),
                          new Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: new Container(child: new Text("Email  ",style: Styles().styles_medium(15, Colors.black),),)),
                                Expanded(flex: 2,child: new Container(child: new Text(email.text.toString(),style: Styles().styles_medium(15, ColorFile.hint_color),),))
                              ],
                            ),),
                          new Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: new Container(child: new Text("Address  ",style: Styles().styles_medium(15, Colors.black),),)),
                                Expanded(flex: 2,child: new Container(child: new Text(address.text.toString(),style: Styles().styles_medium(15, ColorFile.hint_color),),))
                              ],
                            ),),
                          new Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: new Container(child: new Text("City  ",style: Styles().styles_medium(15, Colors.black),),)),
                                Expanded(flex: 2,child: new Container(child: new Text(city.text.toString(),style: Styles().styles_medium(15, ColorFile.hint_color),),))
                              ],
                            ),),
                          new Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: new Container(child: new Text("State  ",style: Styles().styles_medium(15, Colors.black),),)),
                                Expanded(flex: 2,child: new Container(child: new Text(state.text.toString(),style: Styles().styles_medium(15, ColorFile.hint_color),),))
                              ],
                            ),),
                          new Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: new Container(child: new Text("Country  ",style: Styles().styles_medium(15, Colors.black),),)),
                                Expanded(flex: 2,child: new Container(child: new Text(country.text.toString(),style: Styles().styles_medium(15, ColorFile.hint_color),),))
                              ],
                            ),),
                          new Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: new Container(child: new Text("Pin  ",style: Styles().styles_medium(15, Colors.black),),)),
                                Expanded(flex: 2,child: new Container(child: new Text(pin.text.toString(),style: Styles().styles_medium(15, ColorFile.hint_color),),))
                              ],
                            ),),

                          InkWell(
                            onTap: () async {
                              var value=await All_Bottom_Sheets().show_user_details(user_model, context);
                              if(value!=null){
                                user_model=value;
                                set_date();
                                setState(() {

                                });
                              }

                            },
                            child: new Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,

                              children: [
                                new Text("Change Address",style: Styles().styles_bold(17, ColorFile.app_color),)
                              ],
                            ),),)



                        ],
                      ),
                    )







                  ],
                ),),





                new Container(
                  padding: EdgeInsets.all(10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    InkWell(child: is_cheked?Icon(Icons.check_box,color: ColorFile.app_color,):Icon(Icons.check_box_outline_blank),onTap: (){
                      setState(() {
                        is_cheked=!is_cheked;
                      });

                    },),
                    new SizedBox(width: 10,),


                    Expanded(child: new Container(child: new Text("By placing your order, you agree to Peprop.Money privacy notice and terms and conditions.\n\nWhen your order is placed, we will send you an e-mail message acknowledging receipt of your order. It will take maximum 48 hours to take to confirm your order.For more information please read Peprop.Money terms & Conditions and return policy.",style: Styles().styles_regular(14, Colors.black),),))
                  ],
                ),)














                


              ],
            ),
          ),
          if(update)Center(child: new CircularProgressIndicator(),)





        ],
      ),
      bottomNavigationBar: Cofirm_Button("Confirm Order",onclick: (value) async {
        int price=0;

        if(widget.product.discount_price.length>0){
          price =int.parse(widget.product.discount_price);
        }else{
          price =int.parse(widget.product.price);
        }


       if(address.text.length==0) {
         AppUtils.toAst("Please Enter Delivery Address", context);
       }
       else  if(city.text.length==0) {
          AppUtils.toAst("Delivery city can't be empty..!!", context);
        }else  if(pin.text.length<6) {
         AppUtils.toAst("Delivery Pin code Should be 6 digit long..!!", context);
       }
        else if(is_cheked==false){
           AppUtils.toAst("Please accept terms & conditions and refund policy.", context);
         }
       else if(widget.walletBalance>=price){

         check_kyc();


       }else{
         var data=await All_Bottom_Sheets().error("Your Peprop.Money point are insufficient to make this purchase. Please fund your Peprop.Money point.", context);


       }








      },) ,
    );
  }







  Future<void> get_points() async {
    setState(() {
      loading=true;
    });
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();

    map['user_id'] =sharedPreferences.getString("user_id").toString();
    FormData formData = new FormData.fromMap(map);
    var response=await Global_connection().post_method(formData,context, API.userdetails);
    print(response.data.toString());

    if(response!=null&&response.data!=null&&response.statusCode==200 &&response.data["data"]!=null){
      var builder_details = response.data["data"];
       user_model = User_Model.fromJson(builder_details);

       set_date();




    }
    setState(() {
      loading=false;
    });



  }


  check_kyc() async {

    var response=await AppUtils().check_kyc(context);
    if(response==true){
      var data=await All_Bottom_Sheets().Confirmation_dialog("Please Confirm", "Are you sure, You want to purchase this product?", context);
      if(data!=null&&data==true){
        purchase();

      }
    }else{
      var data=await All_Bottom_Sheets().Confirmation_dialog("KYC Verification", "You need to Complete KYC verification First..!!!", context);
      if(data!=null&&data==true){
        var get_res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pan_Verification()));
      }
    }

  }


  Future<void> purchase() async {
    setState(() {
      update=true;

    });



    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();

    int price=0;

    if(widget.product.discount_price.length>0){
      price =int.parse(widget.product.discount_price);
    }else{
      price =int.parse(widget.product.price);
    }
    map['price'] =price;
    map['ship_address'] =address.text.toString();
    map['city_name'] =user_model!.city_name.toString();
    map['state_name'] =user_model!.state_name.toString();
    map['country_name'] =user_model!.country_name.toString();
    map['pin_code'] =user_model!.pin_code.toString();
    map['product_id'] =widget.product.id.toString();
    map['user_id'] =sharedPreferences.getString("user_id").toString();
    print(map.toString());
    FormData formData = new FormData.fromMap(map);
    var response=await Global_connection().post_method(formData,context, API.add_order);
    setState(() {
      update=false;
    });
    print(response);
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["success"]==true){
      var data=await All_Bottom_Sheets().Success_dialog(response.data["message"].toString(), context);
      if(data!=null&&data==true){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Dashboard()),(Route<dynamic> route) => false);

      }

    }else{

      AppUtils().show_error(context,response.data["data"] );
    }




  }

  void set_date() {
    name.text=user_model!.name.toString();
    mobile.text=user_model!.mobile.toString();
    email.text=user_model!.email.toString();
    address.text=user_model!.address.toString();
    city.text=user_model!.city_name.toString();
    state.text=user_model!.state_name.toString();
    country.text=user_model!.country_name.toString();
    pin.text=user_model!.pin_code.toString();


  }


}