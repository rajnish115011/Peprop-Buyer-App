


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../../Color/ColorFile.dart';

class Update_Password_Componenets extends StatelessWidget{
  var newpassword=TextEditingController();
  var old_password=TextEditingController();
  var confirm_password=TextEditingController();
  late BuildContext context;



  final Function(String,String) onSelectionChanged;
  Update_Password_Componenets(TextEditingController newpassword, TextEditingController old_password,TextEditingController confirm_password, BuildContext context,{required this.onSelectionChanged}){
    this.newpassword=newpassword;
    this.old_password=old_password;
    this.confirm_password=confirm_password;
    this.context=context;



  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new

    SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
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
            Text('Change Password',style: Styles().styles_bold(16, Colors.black),),
            SizedBox(
              height: 10,
            ),
            Text("Please set your new password to proceed", style:Styles().styles_medium(14, ColorFile.hint_color)),
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
                    controller: old_password,
                    obscureText: true,
                    style: Styles().styles_regular(12, Colors.black),
                    maxLength: 20,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Old Password",
                      hintStyle: Styles().styles_regular(12, ColorFile.hint_color),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12), borderRadius: BorderRadius.circular(10)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12), borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),

                  TextFormField(
                    controller: newpassword,
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
    if(old_password.text.length==0){
      AppUtils.toAst("Please Enter Old Password",context);

    }else if(newpassword.text.length==0){
      AppUtils.toAst("Please Enter New Password",context);

    }else if(confirm_password.text.length==0){
      AppUtils.toAst("Please Enter Confirm Password",context);

    }else if(newpassword.text.toString()!=confirm_password.text.toString()){
      AppUtils.toAst("Confirm Password does't matched..!!",context);

    }else{
      onSelectionChanged(old_password.text.toString(),newpassword.text.toString());
    }


  }


}