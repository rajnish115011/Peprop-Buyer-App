


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Color/ColorFile.dart';

class Aadhar_Components extends StatelessWidget{
  var contoller=TextEditingController();
  final Function(String) onSelectionChanged;
  late BuildContext context;
  Aadhar_Components(TextEditingController contoller, BuildContext context,{required this.onSelectionChanged}){
    this.contoller=contoller;
    this.context=context;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new

    SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
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
            Text('Aadhaar Verification',style: Styles().styles_bold(16, Colors.black),),
            SizedBox(
              height: 10,
            ),
            Text(
              "Enter Your Aadhaar number to verify KYC",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              padding: EdgeInsets.all(28),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                    decoration: InputDecoration(
                      hintText: "Aadhaar Number",
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
                            borderRadius: BorderRadius.circular(24.0),
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

   verify_aadhar() {
    if(contoller.text.length<12){
      AppUtils.toAst("Please Enter Valid Aadhaar Number",context);

    }else{
      onSelectionChanged(contoller.text.toString());
    }


  }


}