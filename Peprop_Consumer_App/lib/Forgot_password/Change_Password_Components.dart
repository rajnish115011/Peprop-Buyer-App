


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Color/ColorFile.dart';

class Change_Password_Components extends StatelessWidget{
  var password=TextEditingController();
  var confirm_password=TextEditingController();
  late BuildContext context;



  final Function(String) onSelectionChanged;
  Change_Password_Components(TextEditingController password, TextEditingController confirm_password, BuildContext context,{required this.onSelectionChanged}){
    this.password=password;
    this.confirm_password=confirm_password;
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
            Text('Set New Password',style: Styles().styles_bold(16, Colors.black),),
            SizedBox(
              height: 10,
            ),
            Text("Please Set your new Password to proceed", style:Styles().styles_medium(14, ColorFile.hint_color)),
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
                    controller: password,
                    obscureText: true,
                    style: Styles().styles_regular(12, Colors.black),
                    maxLength: 20,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "New Password",
                      hintStyle: Styles().styles_regular(12, ColorFile.hint_color),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12), borderRadius: BorderRadius.circular(10)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12), borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),

                  TextFormField(
                    controller: confirm_password,
                    obscureText: true,
                    style: Styles().styles_regular(12, Colors.black),
                    maxLength: 20,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Confirm Password",
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
                        child: Text('Change', style: Styles().styles_bold(15, ColorFile.white),
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
    if(password.text.length==0){
      AppUtils.toAst("Please Enter New Password",context);

    }else if(confirm_password.text.length==0){
      AppUtils.toAst("Please Enter Confirm Password",context);

    }else if(password.text.toString()!=confirm_password.text.toString()){
      AppUtils.toAst("Confirm Password does't matched..!!",context);

    }else{
      onSelectionChanged(password.text.toString());
    }


  }


}