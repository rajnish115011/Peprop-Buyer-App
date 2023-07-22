



import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';

import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Models/MileStone_Payment_Model.dart';
import '../../Utils/ServiceConfig.dart';
import '../../wish_list/Styles.dart';
import 'MileStone_Payment_Options.dart';

class View_Payment_Details extends StatefulWidget{
  MileStone_Payment_Model? mile_stone;
  View_Payment_Details(MileStone_Payment_Model? mile_stone){
    this.mile_stone=mile_stone;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }

}
class Build_State extends State<View_Payment_Details>{
  bool loading =false;
  MileStone_Payment_Model? payment;

  @override
  void initState() {
    super.initState();


    get_data();


  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, widget.mile_stone!.stage.toString()),
      body: new SingleChildScrollView(
        child: new Column(
          children: [
            if(loading)Center(child: new CircularProgressIndicator(),)else if(payment!=null)
            new Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.all(5),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: payment!.payment.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorFile.green, width: 0.5),
                        color: ColorFile.green,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)), color: ColorFile.white),
                                padding: EdgeInsets.only(top: 0),
                                child: new Column(
                                  children: [
                                    new Container(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10,top: 10),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          Image.asset(
                                            "assets/clock.png",
                                            width: 12,
                                            height: 12,
                                            fit: BoxFit.cover,
                                          ),
                                          new SizedBox(
                                            width: 10,
                                          ),
                                          new Text(
                                            AppUtils().yyyy_mm_dd_to_dd_mm_yyyy(payment!.payment[index].payment_date.toString()),
                                            style: new TextStyle(
                                                fontFamily: "regular",
                                                fontSize: 13,
                                                color: ColorFile.black),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    new SizedBox(
                                      height: 15,
                                    ),
                                    new SizedBox(
                                      height: 2,
                                    ),


                                    if(payment!.payment[index].mode_type!.toLowerCase().contains("cash"))Container(
                                      child: Table(border: TableBorder.all(borderRadius:BorderRadius.only(bottomRight: Radius.circular(10)), color: ColorFile.green, width: 0.3),
                                        children: [
                                          TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Milestone Stage",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(widget.mile_stone!.stage.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),
                                          TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Payment Mode",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].mode_type.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),

                                         if(payment!.payment[index].receipt_number.toString()!="N/A") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Reciept Number",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].receipt_number.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),
                                          TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Amount Paid",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+payment!.payment[index].payment_made.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),

                                          TableRow(
                                              decoration: new BoxDecoration(borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                                              children: [
                                                Container(
                                                    decoration: new BoxDecoration( color: Colors.black12,borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10))),
                                                    padding: EdgeInsets.all(8.0),child: Text("Payment Status",style: Styles().styles_medium(15, ColorFile.black),)),
                                                Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].payment_status.toString()=="0"?"Pending":payment!.payment[index].payment_status.toString()=="1"?"Approved":"Declined",style: Styles().styles_regular(15, payment!.payment[index].payment_status.toString()=="0"?ColorFile.app_color:payment!.payment[index].payment_status.toString()=="1"?ColorFile.greens:ColorFile.red_900))),),
                                              ]),

                                          if(payment!.payment[index].approved_by.toString()!="null") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Approved By",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].approved_by.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),
                                          if(payment!.payment[index].approved_on.toString()!="null") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Approved On",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(AppUtils.server_utc_date_parse(payment!.payment[index].approved_on.toString()),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),


                                        ],
                                      ),
                                    ),

                                    if(payment!.payment[index].mode_type!.toLowerCase().contains("cheque")||payment!.payment[index].mode_type!.toLowerCase().contains("demand draft"))Container(
                                      child: Table(border: TableBorder.all(borderRadius:BorderRadius.only(bottomRight: Radius.circular(10)), color: ColorFile.green, width: 0.3),
                                        children: [
                                          TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Milestone Stage",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(widget.mile_stone!.stage.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),
                                          TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Payment Mode",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].mode_type.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),

                                          if(payment!.payment[index].cheque_number.toString()!="N/A") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text(payment!.payment[index].mode_type!.toLowerCase().contains("demand draft")?"DD Number":"Cheque Number",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].cheque_number.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),

                                          if(payment!.payment[index].bank_name.toString()!="N/A") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Bank Name",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].bank_name.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),
                                          if(payment!.payment[index].account_number.toString()!="N/A") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Account Number",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].account_number.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),

                                          if(payment!.payment[index].bank_holder_name.toString()!="N/A") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Account Holder Name",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].bank_holder_name.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),

                                          TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Amount Paid",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+payment!.payment[index].payment_made.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),

                                          TableRow(
                                              decoration: new BoxDecoration(borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),

                                              children: [
                                                Container(
                                                    decoration: new BoxDecoration( color: Colors.black12,borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10))),
                                                    padding: EdgeInsets.all(8.0),child: Text("Payment Status",style: Styles().styles_medium(15, ColorFile.black),)),
                                                Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].payment_status.toString()=="0"?"Pending":payment!.payment[index].payment_status.toString()=="1"?"Approved":"Declined",style: Styles().styles_regular(15, payment!.payment[index].payment_status.toString()=="0"?ColorFile.app_color:payment!.payment[index].payment_status.toString()=="1"?ColorFile.greens:ColorFile.red_900))),),
                                              ]),
                                          if(payment!.payment[index].approved_by.toString()!="null") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Approved By",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].approved_by.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),
                                          if(payment!.payment[index].approved_on.toString()!="null") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Approved On",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(AppUtils.server_utc_date_parse(payment!.payment[index].approved_on.toString()),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),




                                        ],
                                      ),
                                    ),


                                    if(payment!.payment[index].mode_type!.toLowerCase().contains("online"))Container(
                                      child: Table(border: TableBorder.all(borderRadius:BorderRadius.only(bottomRight: Radius.circular(10)), color: ColorFile.green, width: 0.3),
                                        children: [
                                          TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Milestone Stage",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(widget.mile_stone!.stage.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),
                                          TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Payment Mode",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].mode_type.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),



                                          if(payment!.payment[index].bank_name.toString()!="N/A") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Bank Name",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].bank_name.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),


                                          if(payment!.payment[index].utr_no.toString()!="N/A") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("UTR Number",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].utr_no.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),

                                          TableRow(children: [
                                            Container(

                                                color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Amount Paid",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+payment!.payment[index].payment_made.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),

                                          TableRow(
                                              decoration: new BoxDecoration(borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),

                                              children: [
                                                Container(
                                                    decoration: new BoxDecoration( color: Colors.black12,borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10))),
                                                    padding: EdgeInsets.all(8.0),child: Text("Payment Status",style: Styles().styles_medium(15, ColorFile.black),)),
                                                Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].payment_status.toString()=="0"?"Pending":payment!.payment[index].payment_status.toString()=="1"?"Approved":"Declined",style: Styles().styles_regular(15, payment!.payment[index].payment_status.toString()=="0"?ColorFile.app_color:payment!.payment[index].payment_status.toString()=="1"?ColorFile.greens:ColorFile.red_900))),),
                                              ]),

                                          if(payment!.payment[index].approved_by.toString()!="null") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Approved By",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(payment!.payment[index].approved_by.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),
                                          if(payment!.payment[index].approved_on.toString()!="null") TableRow(children: [
                                            Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Approved On",style: Styles().styles_medium(15, ColorFile.black),)),
                                            Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(AppUtils.server_utc_date_parse(payment!.payment[index].approved_on.toString()),style: Styles().styles_regular(15, ColorFile.black))),),
                                          ]),


                                        ],
                                      ),
                                    ),





                                  ],
                                ),
                              ))
                        ],
                      ),
                    );



                  },
                ),
                ListView.builder(
                  padding: EdgeInsets.all(5),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: payment!.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorFile.green, width: 0.5),
                        color: ColorFile.green,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10)), color: ColorFile.white),
                                padding: EdgeInsets.only(top: 0),
                                child: new Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Table(
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        border: TableBorder.all(borderRadius:BorderRadius.all(Radius.circular(10)), color: ColorFile.green, width: 0.3),
                                        children: [
                                          TableRow(children: [
                                            Container(alignment: Alignment.center,padding: EdgeInsets.all(8.0),child: Text(payment!.documents[index].toString().replaceAll(API.document, ""),style: Styles().styles_medium(15, ColorFile.blue_400),)),
                                            InkWell(child:Container(alignment: Alignment.center,padding: EdgeInsets.all(8.0),child: Center(child: Text("Download",style: Styles().styles_regular(15, ColorFile.red_900))),),onTap: (){
                                              AppUtils().open_url(payment!.documents[index], context);

                                            },)

                                          ]),





                                        ],
                                      ),
                                    ),




                                  ],
                                ),
                              ))
                        ],
                      ),
                    );



                  },
                ),

              ],
            )else new No_Data_Placeholder("No details Found..!!")

          ],
        ),
      ),
    );
  }

  Future<void> get_data() async {
    setState(() {
      loading = true;
    });
    var map = <String, String>{};
    map['id'] = widget.mile_stone!.id.toString();
    print(map);
    FormData mobile = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.milestoneDetails, mobile, context).then((value) {
      Response response = value;
      var notify = response.data["data"];
      payment =MileStone_Payment_Model.fromJson(notify);
      setState(() {
        loading=false;

      });
    }).catchError((onError){
      setState(() {
        loading=false;
      });
    });
  }

}