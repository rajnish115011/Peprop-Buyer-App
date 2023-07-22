


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/bill_payment/model/Circle_Model.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

class Custom_Scorll_Bar extends StatelessWidget{
  String title="";
  var search_contoller=TextEditingController();
  Function(String)onchanged;
  Function(Opertaor_list)on_tap;


  List<Opertaor_list> op_list=[];
  Custom_Scorll_Bar(String title, List<Opertaor_list> op_list, TextEditingController search_contoller,{required this.onchanged,required this.on_tap}){
    this.title=title;
    this.op_list=op_list;
    this.search_contoller=search_contoller;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return

      NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            header(),
            search_bar()
          ];
        },
        body:ListView.builder(
            itemCount:op_list.length,
            itemBuilder: (context, index) {
              return InkWell(child: Card(
                  child: new Container(
                    padding: EdgeInsets.all(15),
                    child: new Row(
                      children: [
                        ClipRRect(child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.png',
                          image:API.banking_base+"/"+op_list[index].logo.toString(),
                          width:50,
                          height: 50, imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/placeholder.png",
                              width: 50,
                              fit: BoxFit.cover,
                              height: 50);//do something
                        },
                        ),),
                        new SizedBox(width: 10,),
                        Expanded(child: new Container(child:Text(op_list[index].name.toString(),style: Styles().styles_regular(14, ColorFile.black),)))

                      ],
                    ),
                  )


              ),onTap: (){
                on_tap(op_list[index]);
              },);

            }));
  }
  SliverAppBar header() {
    return
      SliverAppBar(
        backgroundColor: Colors.white,
        pinned: false,
        centerTitle: true,
        title:new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: new Container(alignment: Alignment.center,child:  Text(title.toLowerCase().contains("payment")?title:title+" Payment",style: Styles().styles_bold(18, ColorFile.black),),)),
            new SizedBox(width: 50,)
          ],
        )
    );
  }
  SliverAppBar search_bar() {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 100,
      elevation: 0,
      backgroundColor: ColorFile.white,
      leadingWidth: 0,
      leading: new Container(),
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 55,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(1.1, 1.1),
                blurRadius: 5.0),
          ],
        ),
        child: CupertinoTextField(
          controller: search_contoller,
          onChanged: (value){
            onchanged(value.toString());
          },
          keyboardType: TextInputType.text,
          placeholder: 'Search',
          style: new TextStyle(fontSize: 16,color: ColorFile.black),
          placeholderStyle: TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 12.0,
            fontFamily: 'regular',
          ),
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
            child: Icon(
              Icons.search,
              size: 18,
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}