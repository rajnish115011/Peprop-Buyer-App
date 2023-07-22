


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Apartments_Model.dart';
import 'package:peprop_consumer_app/Properties/View_Property_Model.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shimmer/shimmer.dart';

import '../loan/Apply_Loan.dart';

class Bank_loan_view extends StatelessWidget{
  List<Bank_loan> bank_loan=[];
  View_Property_Model? view_property_model;
  Bank_loan_view(List<Bank_loan> bank_loan, View_Property_Model? view_property_model){
    this.bank_loan=bank_loan;
    this.view_property_model=view_property_model;


    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(bank_loan.length>0) return
    Container(margin: EdgeInsets.only(top: 30),child: Stack(
      children: [
             Container(
          height: 80,
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.blue_200),
        child:
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/loan_screen.png",height: 50,width: 50,),
            new SizedBox(width: 10,),
            Expanded(child: new Container(child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new SizedBox(height: 15,),
                new Text("Approved By",style: Styles().styles_bold(20, ColorFile.black),),


              ],
            ),))
          ],
        ),),
             new Container(
             height: 100,
              margin: EdgeInsets.only(top: 60),
              child:ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics:AlwaysScrollableScrollPhysics(),
              itemCount: bank_loan.length,
              itemBuilder: (context, index) {
                return new Card(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Container(
                        width: 200,
                        padding: EdgeInsets.all(10),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(100),
                            color: ColorFile.white
                        ),
                        child:
                        ClipRRect(child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.png',
                          image:bank_loan[index].bank_image,
                          width:70,
                          height: 30,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset("assets/placeholder.png",
                                width: 70,
                                fit: BoxFit.cover,
                                height: 30);//do something
                          },
                        ),  borderRadius: new BorderRadius.circular(100),),
                      ),

                      new Container(child: new Text(bank_loan[index].bank_name,style: Styles().styles_medium(15, ColorFile.black),),),
                      new SizedBox(height: 10,),




                    ],
                  ),

                );
              }),
        )



      ],
    ),
    
    );else return new Container();
  }

  
}