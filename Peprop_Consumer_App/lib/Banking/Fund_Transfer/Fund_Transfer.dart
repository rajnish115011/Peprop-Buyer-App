import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Banking_OTP/Fund_Transfer_Inside_OTP.dart';
import '../../Banking_OTP/Fund_Transfer_OTP.dart';
import '../../Color/ColorFile.dart';
import '../../Models/BeneficiriesModel.dart';
import '../../Models/Transfer_Model.dart';

class Fund_Transfer extends StatefulWidget {
  String acc_no="";
  String holder_name="";
  late  BeneficiriesModel beneficiary_list;

  Fund_Transfer(String acc_no,String holder_name, BeneficiriesModel beneficiary_list){
    this.acc_no=acc_no;
    this.holder_name=holder_name;
    this.beneficiary_list=beneficiary_list;

  }



  @override
  _MyAccountProfileState createState() => _MyAccountProfileState();
}

class _MyAccountProfileState extends State<Fund_Transfer> {

  String mobile = "";
  bool _isLoading = false;
  final _amountController=TextEditingController();
  final remark=TextEditingController();
  int selected_index=1;


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: false,
      right: true,
      bottom: true,
      child: Scaffold(
        appBar:AppUtils.appBar(context, ""),
        body: new Stack(
          children: [
            (_isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    slivers: [
                     new SliverToBoxAdapter(child: new Column(
                       children: [
                         new Container(
                           margin: EdgeInsets.only(left: 20,right: 20,top: 30),
                           child: new Row(
                           children: [
                             Expanded(child: new Container(child: new Text("Name",style: new TextStyle(fontSize: 14,fontFamily: "bold",color: ColorFile.black),),)),
                             new Container(child: new Text(widget.holder_name.toUpperCase(),style: new TextStyle(fontSize: 14,fontFamily: "regular",color: ColorFile.black)),)
                           ],
                         ),),
                         new Container(
                           margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                           child: new Row(
                             children: [
                               Expanded(child: new Container(child: new Text("Account Number",style: new TextStyle(fontSize: 14,fontFamily: "bold",color: ColorFile.black),),)),
                               new Container(child: new Text(widget.acc_no,style: new TextStyle(fontSize: 14,fontFamily: "regular",color: ColorFile.black)),)
                             ],
                           ),),
                         new Container(
                           margin: EdgeInsets.only(left: 20,right: 20,top: 40),
                           child: new Row(
                             children: [
                               Expanded(child: new Container(child: new Text("Your Source Account Details",style: new TextStyle(fontSize: 14,fontFamily: "regular",color: ColorFile.black),),)),
                             ],
                           ),),
                         new Container(
                           margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                           child: new Row(
                             children: [
                               Expanded(child: new Container(child: new Text("Source Account Name",style: new TextStyle(fontSize: 12,fontFamily: "medium",color: ColorFile.black),),)),
                               new Container(child: new Text(widget.beneficiary_list.b_name,style: new TextStyle(fontSize: 10,fontFamily: "regular",color: ColorFile.black)),)
                             ],
                           ),),
                         new Container(
                           margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                           child: new Row(
                             children: [
                               Expanded(child: new Container(child: new Text("Source Account Number",style: new TextStyle(fontSize: 12,fontFamily: "medium",color: ColorFile.black),),)),
                               new Container(child: new Text(widget.beneficiary_list.b_account_no,style: new TextStyle(fontSize: 10,fontFamily: "regular",color: ColorFile.black)),)
                             ],
                           ),),
                         new Container(
                           margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                           child: new Row(
                             children: [
                               Expanded(child: new Container(child: new Text("Source IFSC Code",style: new TextStyle(fontSize: 12,fontFamily: "medium",color: ColorFile.black),),)),
                               new Container(child: new Text(widget.beneficiary_list.b_ifsc,style: new TextStyle(fontSize: 10,fontFamily: "regular",color: ColorFile.black)),)
                             ],
                           ),),
                         new Container(child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             const SizedBox(
                               width: 125,
                               child: Text(
                                 'Transfer Amount',
                                 style: TextStyle(
                                     fontSize: 13,
                                     color: Colors.black,
                                     fontFamily: 'semi'),
                               ),
                             ),
                             const SizedBox(
                               width: 5,
                             ),
                             Expanded(
                                 child: TextField(
                                   controller: _amountController,
                                   keyboardType: TextInputType.number,
                                   decoration: const InputDecoration(
                                     border: OutlineInputBorder(
                                       borderRadius:
                                       BorderRadius.all(Radius.circular(10.0)),
                                     ),
                                     labelText: 'Amount',
                                   ),
                                 ))
                           ],
                         ),margin: EdgeInsets.only(left: 20,right: 20,top: 30),),
                         new Container(child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             const SizedBox(
                               width: 125,
                               child: Text(
                                 'Remark',
                                 style: TextStyle(
                                     fontSize: 13,
                                     color: Colors.black,
                                     fontFamily: 'semi'),
                               ),
                             ),
                             const SizedBox(
                               width: 5,
                             ),
                             Expanded(
                                 child: TextField(
                                   controller: remark,
                                   decoration: const InputDecoration(
                                     border: OutlineInputBorder(
                                       borderRadius:
                                       BorderRadius.all(Radius.circular(10.0)),
                                     ),
                                     labelText: 'Remark',
                                   ),
                                 ))
                           ],
                         ),margin: EdgeInsets.only(left: 20,right: 20,top: 30),),
                         new Container(
                           margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                           child: new Row(
                             children: [
                               Expanded(child: new Container(
                                 child: new Row(
                                   children: [
                                     InkWell(onTap: (){
                                       setState(() {
                                         selected_index=1;
                                       });
                                     },child: selected_index==1?Icon(Icons.radio_button_checked,color: ColorFile.app_color,):Icon(Icons.radio_button_off)),
                                     new SizedBox(width: 10,),
                                     new Text("IMPS",style: new TextStyle(fontSize: 13,color: ColorFile.black,fontFamily: "medium"),)
                                   ],
                                 ),
                               )),
                               Expanded(child: new Container(
                                 child: new Row(
                                   children: [
                                     InkWell(onTap: (){
                                       setState(() {
                                         selected_index=2;
                                       });
                                     },child: selected_index==2?Icon(Icons.radio_button_checked,color: ColorFile.app_color,):Icon(Icons.radio_button_off)),
                                     new SizedBox(width: 10,),
                                     new Text("NEFT",style: new TextStyle(fontSize: 13,color: ColorFile.black,fontFamily: "medium"),)
                                   ],
                                 ),
                               )),
                               Expanded(child: new Container(
                                 child: new Row(
                                   children: [
                                     InkWell(onTap: (){
                                       setState(() {
                                         selected_index=3;
                                       });
                                     },child: selected_index==3?Icon(Icons.radio_button_checked,color: ColorFile.app_color,):Icon(Icons.radio_button_off)),
                                     new SizedBox(width: 10,),
                                     new Text("RTGS",style: new TextStyle(fontSize: 13,color: ColorFile.black,fontFamily: "medium"),)
                                   ],
                                 ),
                               )),

                             ],
                           ),
                         ),
                         InkWell(child: Container(
                           width: MediaQuery.of(context).size.width,
                           height: 40.0,
                           margin: EdgeInsets.only(left: 25,right: 25,top: 30),
                           decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),color: ColorFile.app_color),
                           child: new Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               new Text("Transfer",style: new TextStyle(fontFamily: "medium",fontSize: 12,color: ColorFile.white),)
                             ],
                           ),
                         ),onTap: () async {
                           if(validate()){
                             FocusScope.of(context).requestFocus(new FocusNode());
                             Transfer_Model transfer_Model=Transfer_Model();
                             transfer_Model.holder_name=widget.holder_name;
                             transfer_Model.acc_no=widget.acc_no;
                             transfer_Model.beneficiary_list=widget.beneficiary_list;
                             transfer_Model.transaction_type=selected_index.toString();
                             transfer_Model.amount=_amountController.text.toString();
                             transfer_Model.transaction_type=selected_index.toString();
                             transfer_Model.remark=remark.text.toString();
                             if(widget.beneficiary_list.b_user_id=="outside"){
                               var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Fund_Transfer_OTP(transfer_Model)));
                               if(response!=null){
                                 Navigator.pop(context,"response");
                               }
                             }else{
                               var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Fund_Transfer_Inside_OTP(transfer_Model,widget.beneficiary_list)));
                               if(response!=null){
                                 Navigator.pop(context,"response");
                               }
                             }


                           }
                         },)


                       ],
                     ),)
                    ],
                  ),
          ],
        ),
      ),
    );
  }





  bool validate() {
    if(_amountController.text.length==0){
      AppUtils.toAst("Please Enter Amount",context);
      return false;
    } if(remark.text.length==0){
      AppUtils.toAst("Please Enter Remark",context);
      return false;
    }


    return true;
  }
}