


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/BankListModel.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Utils/AppUtils.dart';

class Bank_Offers_Loan extends StatelessWidget{
  List<BankListModel> bank_offers=[];
  Bank_Offers_Loan(List<BankListModel> bank_offers){
    this.bank_offers=bank_offers;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Image.asset(
            'assets/loan_screen.png',
            scale: 3.5,
          ),
        ),

        new Container(
          color: ColorFile.white,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
            new Container(child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("Bank Offers",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'semi',
                    color: ColorFile.status_requested,
                  ),
                ),
              ],
            ),margin: EdgeInsets.only(top: 20),),
            ListView.builder(
                  itemCount: bank_offers.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(

                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                                  imageUrl: API.bankImageUrl+bank_offers[index].imageLink.toString(),
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        //colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => AppUtils.progressBar(true),
                                  errorWidget: (context, url, error) => Container(
                                    child: Center(
                                        child: Text(
                                          'Bank Name',
                                          style: const TextStyle(
                                              fontSize: 8,
                                              fontFamily: 'semi',
                                              color: ColorFile.red_900),
                                        )),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.0),
                                        color: ColorFile.lead_widget_color),
                                  ),
                                ),
                              ),
                              new Expanded(child: new Container(
                                child: new Column(
                                  children: [
                                    Text("ROI",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontFamily: 'regular',
                                          fontSize: 12
                                      ),),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text("${bank_offers[index].intrate!.toString()}%",
                                      style: TextStyle(
                                          color: ColorFile.status_requested,
                                          fontFamily: 'semi'
                                      ),),
                                  ],
                                ),
                              )),
                              new Expanded(child: new Container(
                                child: new Column(
                                  children: [
                                    Text("P. Fees",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontFamily: 'regular',
                                          fontSize: 12
                                      ),),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text("\u{20B9}${bank_offers[index].processingfee!.toString()}",
                                      style: TextStyle(
                                          color: ColorFile.status_requested,
                                          fontFamily: 'semi'
                                      ),),
                                  ],
                                ),
                              )),
                              new Expanded(child: new Container(
                                child: new Column(
                                  children: [
                                    Text("Tenure",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontFamily: 'regular',
                                          fontSize: 12
                                      ),),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text("3-20 Years",
                                      style: TextStyle(
                                          color: ColorFile.status_requested,
                                          fontFamily: 'semi'
                                      ),),
                                  ],
                                ),
                              )),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new SizedBox(width: 5,),
                              Container(
                                child:
                                Text(bank_offers[index].bankname.toString(),
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontFamily: 'regular',
                                      fontSize: 12
                                  ),),
                              ),
                              new SizedBox(width: 50,),
                              Container(

                                child:
                                Text(bank_offers[index].loantype.toString(),
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontFamily: 'regular',
                                      fontSize: 12
                                  ),),
                              ),

                            ],
                          ),


                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Divider(
                              indent: 14,
                              endIndent: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),


          ],
        ),)


      ],
    );
  }

}