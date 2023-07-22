



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/loan/Capaign_Model.dart';

import '../Color/ColorFile.dart';
import '../widgets/numberToWords.dart';

class Create_dynamic_widget_Campaign extends StatelessWidget{

  Capaign_Model? fields_list;
  int position=0;
  Function()on_edit;
  late TextEditingController controller;

  Function(int)loan_type;
  Function(int)loan_tenure;


  Create_dynamic_widget_Campaign(Capaign_Model fields_list, int position, TextEditingController controller,{required this.on_edit,required this.loan_type,required this.loan_tenure}){
    this.fields_list=fields_list;
    this.position=position;
    this.controller=controller;

  }

  @override
  Widget build(BuildContext context) {
    controller.text= fields_list!.enter_value.toString();
    return new Column(
      children: [
       Container(
          height: 55,
          margin: EdgeInsets.only(top: 10,left: 10,right: 10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 5.0),
                child: Text(
                  fields_list!.field_name.toString(),
                  style: TextStyle(
                      fontFamily: 'regular',
                      color: Colors.grey,
                      fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 6.0, bottom: 7.0),
                child: TextFormField(
                  controller: controller,
                  onTap:fields_list!.field_type.toString()=="loan type"||fields_list!.field_type.toString()=="loan tenure"?(){
                    if(fields_list!.field_type.toString()=="loan type"){
                      loan_type(position);
                    } if(fields_list!.field_type.toString()=="loan tenure"){
                      loan_tenure(position);
                    }
                  }:null,

                  onChanged: (t){
                    fields_list!.enter_value=t.toString();


                  },
                  style: TextStyle(
                      fontFamily: 'semi',
                      fontSize: 14,
                      color: Colors.black54),
                  maxLength: fields_list!.field_type.toString()=="mobile"?10:100,
                  readOnly: fields_list!.field_type.toString()=="loan type"?true:fields_list!.field_type.toString()=="loan tenure"?true:false,
                  keyboardType:fields_list!.field_type.toString()=="mobile"||fields_list!.field_type.toString()=="loan amount"? TextInputType.phone:TextInputType.text,
                  maxLines: 1,
                  inputFormatters: <TextInputFormatter>[

                    if(fields_list!.field_type.toString()=="mobile"||fields_list!.field_type.toString()=="loan amount")
                    FilteringTextInputFormatter.digitsOnly


                  ],
                  autofocus: false,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    isDense: true,
                    border: InputBorder.none,
                    counterText: "",

                    suffixIconConstraints:
                    BoxConstraints(
                        minWidth: 0, minHeight: 0),
                    hintText:((fields_list!.field_type.toString()=="loan type"|| fields_list!.field_type.toString()=="loan tenure"?" Select ":" Enter "))+fields_list!.field_name.toString(),
                    hintStyle: TextStyle(
                        fontSize: 14
                    ),
                    prefixIcon: Padding(
                      padding:  EdgeInsets.only(
                          left: fields_list!.field_type.toString()=="loan amount"?5.0:0, right: 4.0),
                      child:fields_list!.field_type.toString()=="loan amount"?
                      Text(
                        '₹',
                        style: TextStyle(
                            fontFamily: 'semi',
                            fontSize: 14,
                            color: Colors.black54),
                      ):
                      Text(
                        ' ',
                        style: TextStyle(
                            fontFamily: 'semi',
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                    ),
                    prefixIconConstraints:
                    BoxConstraints(
                        minWidth: 0, minHeight: 0),
                  ),
                ),
              ),
            ],
          ),
        ),
        if(fields_list!.field_type=="loan amount"&&fields_list!.enter_value.toString().length>0)   Padding(
          padding: const EdgeInsets.only(
            top: 5.0,left: 20,right: 20),
          child:
          Text(
            //'Loan amount',
            numberToWords(int.parse(fields_list!.enter_value.toString())),
            style: TextStyle(
                fontFamily: 'regular',
                color: Colors.orange,
                fontSize: 12),
          ),
        ),






      ],
    );
  }

}