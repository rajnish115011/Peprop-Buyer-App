


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Color/ColorFile.dart';

class Forgot_Components extends StatelessWidget{
  var contoller=TextEditingController();
  final Function(String) onSelectionChanged;
  late BuildContext context;
  Forgot_Components(TextEditingController contoller, BuildContext context,{required this.onSelectionChanged}){
    this.contoller=contoller;
    this.context=context;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new

    SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/ad.png',
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text('Forgot Password',style: Styles().styles_bold(16, Colors.black),),
            SizedBox(
              height: 10,
            ),
            Text("Enter your registered mobile number to send OTP", style:Styles().styles_medium(14, ColorFile.hint_color)),
            SizedBox(
              height: 28,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: contoller,
                    keyboardType: TextInputType.number,
                    style: Styles().styles_regular(12, Colors.black),
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: InputDecoration(
                      hintText: "Mobile Number",
                      hintStyle: Styles().styles_regular(12, ColorFile.hint_color),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12), borderRadius: BorderRadius.circular(10)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12), borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        verify_aadhar();


                      },
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(ColorFile.app_color),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text('Verify', style: Styles().styles_bold(15, ColorFile.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  void verify_aadhar() {
    if(contoller.text.length<10){
      AppUtils.toAst("Please Enter Valid Mobile Number",context);

    }else{
      onSelectionChanged(contoller.text.toString());
    }


  }


}