import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Cost_Sheet/model/Builder_Detail_Model.dart';
import '../Global_connection/Global_connection.dart';

import '../Search/Search_View_Custom.dart';
import '../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import '../wish_list/Styles.dart';
import 'My_Gift_Card/My_Gift_Card_Details.dart';
import 'Spin/Luck.dart';

class All_Brands extends StatefulWidget{

  String parent="";
  List<Coupon_Categepry_Model> brand=[];


  List<Coupon_Categepry_Model>basebrand=[];

  List<Coupon_Categepry_Model>all_brand=[];
  All_Brands(String parent, List<Coupon_Categepry_Model> brand){
    this.parent=parent;
    if(parent.toString()!=""){
      basebrand.addAll((brand.where((i) => i.parent == parent.toString()).toList()));
      all_brand.addAll((brand.where((i) => i.parent == parent.toString()).toList()));
    }else{
      this.basebrand.addAll(brand);
      all_brand.addAll(brand);


    }





  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<All_Brands>{






  @override
  void initState() {
    super.initState();


  }

  bool loading=false;
  bool update=false;

  final search_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Scaffold(
      appBar: AppUtils.appBarcolor(context, "All Brands", ColorFile.dark_blue),
      body:Stack(
        children: [
          if(loading)Center(child: new CircularProgressIndicator(),)
          else   new Column(
            children: [
              Search_Brand(search_controller,on_search: (value){
                onchanged(value.toString());

              }),
              new SizedBox(height: 20,),
              Expanded(child: GridView.builder(
                padding: EdgeInsets.all(10),
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.basebrand.length,
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
                        new Container(alignment: Alignment.center,child: Image.network(widget.basebrand[index].img_path,height: 55,width: 55),),
                        new SizedBox(height: 10,),
                        Expanded(child: new Container(alignment: Alignment.topCenter,child: new Text(widget.basebrand[index].cat_name+"\n",style: Styles().styles_medium(12, ColorFile.black),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                      ],
                    ),onTap: (){
                      get_campaign(widget.basebrand[index].id.toString());


                  },);
                },
              ))




            ],
          ),
          if(update)Center(child: new CircularProgressIndicator(),)

        ],
      ),
    );
  }

  get_campaign(String id) async {
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

  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        widget.basebrand.clear();
        widget.basebrand.addAll(widget.all_brand);
      });
    }else{
      widget.basebrand.clear();
      widget.all_brand.forEach((element) {
        if(element.cat_name.toString().toLowerCase().contains(value.toString().toLowerCase())){
          widget.basebrand.add(element);
        }
      });
      setState(() {
      });
    }
  }

}
