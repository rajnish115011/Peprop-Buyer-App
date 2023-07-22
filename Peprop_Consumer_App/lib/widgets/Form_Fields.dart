import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Color/ColorFile.dart';
import '../Utils/UpperCaseTextFormatter.dart';
import '../bill_payment/model/Circle_Model.dart';

class Form_Fields {
  Widget text_view_widget(String text) {
    return Container(

        decoration:  BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: ColorFile.lightgray),
          ),
        ),
        child:Text(text,style: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.black),)
    );
  }
  Widget editable_from(String hint, TextEditingController controller) {
    return
      Container(
        decoration:  BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: ColorFile.lightgray),
          ),
        ),
        height: 60,
        child: TextField(
          controller: controller,
          enabled: true,
          maxLength: 200,
          style:
          TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.black),
          decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5),
            hintStyle: TextStyle(
                fontSize: 12, fontFamily: "regular", color: Colors.grey),
            hintText: hint,
            border: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            enabledBorder:const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            disabledBorder:
            const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),

          ),
        ),
      );
  }

  Widget phone_register(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: 10,
                autofocus: false,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(
                      fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,

                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }


  Widget label_with_change_on_current(String hint, TextEditingController controller,bool is_read,BuildContext context) {
    return
      TextFormField(
        controller: controller,
        readOnly: is_read,
        style: TextStyle(fontSize: 14, fontFamily: "regular", color: Colors.black),
        decoration:Form_Fields.label_change1(hint,context,is_read),

      );
  }


  Widget label_with_change(String hint, TextEditingController controller,bool is_read,BuildContext context, Opertaor_list op_model) {
    return
      TextFormField(
      controller: controller,
        readOnly: is_read,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 14, fontFamily: "regular", color: Colors.black,),
        decoration:Form_Fields.label_change(hint,context,is_read,op_model),

      );
  }


  Widget locality(String hint, TextEditingController controller,bool is_read) {
    return
      Container(
        decoration: new BoxDecoration(border:new Border.all(width: 1,color: ColorFile.lightgray)),
        height: 50,
        child: TextField(
          controller: controller,
          readOnly: is_read,
          maxLength: 200,
          style:  TextStyle(fontSize:15,fontFamily: "regular",color: Colors.black),
          decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.only(left: 10,right: 10,top: 5),
              hintStyle:  TextStyle(fontSize:15,fontFamily: "regular",color: Colors.grey),
              hintText: hint,
              border:  InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder:InputBorder.none,
              disabledBorder:InputBorder.none
          ),
        ),
      );
  }

  Widget passwords(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                obscureText: true,
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }

  Widget fileds(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 14,color: ColorFile.hint_color),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }
  Widget double(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 14,color: ColorFile.hint_color),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                keyboardType:TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }
  Widget book_filed_capital(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }

  Widget book_filed(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }

  Widget book_address(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }

  Widget pins(String hint ,TextEditingController controller){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: 6,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                readOnly: false,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }



  Widget book_filed_Address(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 100,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }


  Widget mobile(String hint ,TextEditingController controller,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: 10,
                readOnly: read_only,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }


  Widget book_numric(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }



  Widget book_drop_down(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10,top: 15),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  suffixIcon: Align(widthFactor: 1.0, heightFactor: 1.0, child:Image.asset("assets/dropdown.png",height: 15,)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }
  static InputDecoration dec_drop(String hint){
    return InputDecoration(
      counterText: "",
      suffixIcon: new Container(child: new Icon(Icons.keyboard_arrow_down_sharp,size: 25,),),

      fillColor: ColorFile.bgs, filled: true,
      contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5),
      hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
      hintText: hint,
      border: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.app_color, width: 1.0),
      ),
      errorBorder:  const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),


    );

  }

  static InputDecoration label_change(String hint, BuildContext context, bool is_read, Opertaor_list op_model){
    return
      InputDecoration(
      counterText: "",
      labelText: hint,
      prefixIcon: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.png',
            image:API.banking_base+"/"+op_model.logo.toString(),
            width:20,
            height: 20, imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/placeholder.png",
                width: 20,
                fit: BoxFit.cover,
                height: 20);//do something
          },
          )),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      suffixIcon:is_read==true? Padding(child:InkWell(child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text("Change",style: Styles().styles_medium(12, ColorFile.app_color),)
        ],
      ),onTap: (){Navigator.pop(context);},),
      padding: EdgeInsets.only(left: 10,right: 10),):new Container(width: 1,),
      hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
      labelStyle: TextStyle(fontSize: 16, fontFamily: "medium", color: ColorFile.app_color),
      hintText: hint,
      border: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.app_color, width: 1.0),
      ),
      errorBorder:  const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),


    );

  }

  static InputDecoration label_change1(String hint, BuildContext context, bool is_read){
    return
      InputDecoration(
        counterText: "",
        labelText: hint,contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        suffixIcon:is_read==true?Padding(child:InkWell(child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text("Change",style: Styles().styles_medium(12, ColorFile.app_color),)
          ],
        ),onTap: (){
          Navigator.pop(context);
        },),

        padding: EdgeInsets.only(left: 10,right: 10),):new Container(width: 1,),
        hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
        labelStyle: TextStyle(fontSize: 16, fontFamily: "medium", color: ColorFile.app_color),
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.app_color, width: 1.0),
        ),
        errorBorder:  const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
        ),


      );

  }

  Widget pin(String hint, TextEditingController controller,bool _is_enabled){
    return new
    Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: 6,
                readOnly: false,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);


  }


  Widget phone(String hint, TextEditingController controller,bool _is_enabled) {
   return

     Container(

      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Mobile Number", style: TextStyle( fontSize: 15,fontFamily: "medium"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            enabled: _is_enabled,
            maxLength: 10,
            autofocus: false,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            style:  TextStyle(fontSize:14,fontFamily: "medium",color: Colors.black),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.only(left: 10,right: 10),
              hintStyle:  TextStyle(fontSize:14,fontFamily: "medium",color: ColorFile.hint_color),
              hintText: hint,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              border: InputBorder.none,
              focusedBorder:InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder:InputBorder.none,
              disabledBorder:InputBorder.none,
            ),
          )
        ],
      ),
    );
  }
  Widget password(String hint, TextEditingController controller,bool _is_enabled) {
    return Container(

      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Password", style: TextStyle( fontSize: 15,fontFamily: "medium"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            enabled: _is_enabled,
            maxLength: 20,
            autofocus: false,
            obscureText: true,
            style:  TextStyle(fontSize:14,fontFamily: "medium",color: Colors.black),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.only(left: 10,right: 10),
              hintStyle:  TextStyle(fontSize:14,fontFamily: "medium",color: ColorFile.hint_color),
              hintText: hint,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              border: InputBorder.none,
              focusedBorder:InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder:InputBorder.none,
              disabledBorder:InputBorder.none,
            ),
          )
        ],
      ),
    );
  }

  Widget non_editable_text(String hint, TextEditingController controller) {
    return
      Container(
        decoration: new BoxDecoration(border:new Border.all(width: 1,color: ColorFile.lightgray)),
        height: 50,
        child: TextField(
          controller: controller,
          enabled: false,
          maxLength: 200,
          style:  TextStyle(fontSize:15,fontFamily: "regular",color: Colors.black),
          decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.only(left: 10,right: 10,top: 5),
              hintStyle:  TextStyle(fontSize:15,fontFamily: "regular",color: Colors.grey),
              hintText: hint,
              border:  InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder:InputBorder.none,
              disabledBorder:InputBorder.none
          ),
        ),
      );
  }


}