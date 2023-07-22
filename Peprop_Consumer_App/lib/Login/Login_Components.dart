

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Login/Login_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

class Login_Components extends StatelessWidget{
  final nameController =TextEditingController();
  final passwordController =TextEditingController();
  bool is_exist=false;
  final Function(Login_Model index) onSelectionChanged;

  Login_Components(bool is_exist, {required this.onSelectionChanged}){
    this.is_exist=is_exist;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Image.asset("assets/logo.png"),

            SizedBox(height: 20),
            new Container(child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: new Container(alignment: Alignment.centerLeft,child:Text(
                  'Login or Create a New Account',
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 18,fontFamily: "bold"),

                ),))
               
              ],
            ),),
            SizedBox(
              height: 10,
            ),
            _buildTextField(nameController, Icons.account_circle, 'Username'),
           if(is_exist) new Column(
              children: [
                SizedBox(height: 20),
                _buildpassword(passwordController, Icons.lock, 'Password'),
              ],
            ),

            SizedBox(height: 30),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: () {

                  if(is_exist==true){
                  if(nameController.text.length<10){
                    AppUtils.toAst("Please Enter 10 digit Mobile Number",context);

                  }if(passwordController.text.length==0){
                    AppUtils.toAst("Please Enter Valid Password",context);

                  }else{
                    Login_Model loginmodel=new Login_Model();
                    loginmodel.mobile=nameController.text;
                    loginmodel.password=passwordController.text;
                    onSelectionChanged(loginmodel);
                  }
                }else{
                  if(nameController.text.length<10){
                    AppUtils.toAst("Please Enter 10 digit Mobile Number",context);
                  }else{
                    Login_Model loginmodel=new Login_Model();
                    loginmodel.mobile=nameController.text;
                    loginmodel.password=passwordController.text;
                    onSelectionChanged(loginmodel);
                  }
                }



              },
              color: ColorFile.greens,
              child: Text('Proceed Securely',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              textColor: Colors.white,
            ),
            SizedBox(height: 20),


          ],
        ),
      ),
    );
  }

  _buildTextField(nameController, IconData account_circle, String s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: ColorFile.bgs,borderRadius: new BorderRadius.circular(10)),
      child: TextField(
        maxLength: 10,
        controller: nameController,
        style: TextStyle(color: Colors.black,fontFamily: "regular",fontSize: 14),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            hintText:  s,
            hintStyle: TextStyle(color: ColorFile.hint_color,fontFamily: "regular",fontSize: 14),
            icon: Icon(
              account_circle,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
  _buildpassword(nameController, IconData account_circle, String s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: ColorFile.bgs,borderRadius: new BorderRadius.circular(10)),
      child: TextField(
        controller: nameController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            hintText:  s,
            hintStyle: TextStyle(color: ColorFile.hint_color,fontFamily: "regular",fontSize: 14),
            icon: Icon(
              account_circle,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

}