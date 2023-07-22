


import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Banking_OTP/Register_OTP.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Dashboard/Dashboard.dart';
import 'package:peprop_consumer_app/Models/City_Model.dart';
import 'package:peprop_consumer_app/Search/Search_City.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/Form_Drop_Down.dart';
import 'package:peprop_consumer_app/widgets/Form_Fields.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Terms_and_Conditions/Tnc.dart';
import '../Utils/FireBase_Logs.dart';
import '../widgets/Generate_Hash_Map.dart';
import 'Register_phone_With_Country_Code.dart';

class Customer_Registration extends StatefulWidget {
  String mobile="";
  Customer_Registration(String mobile){
    this.mobile=mobile;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Customer_Registration>{
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pin = TextEditingController();
  String city_id="";
  String state_id="";
  String country_id="";
  bool loading=false;
  late String message = "Registration Completed";
  bool cheked=false;
  bool cheked_user_concern=false;
  String coutnry_Code="91";
  @override
  void initState() {
   mobileController.text=widget.mobile.toString();
   super.initState();
   create_log();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppUtils.appBarTitle(context, "Registration"),
      body: new Stack(children: [
        SingleChildScrollView(child: new Column(
          children: [
            new SizedBox(height: 20,),
            Form_Fields().book_filed("Full Name", nameController, 50, false, false),
            Register_phone_With_Country_Code("Mobile Number", mobileController, 50, false, false,"+"+coutnry_Code,pick_country_code: (){
              show_country_picker();

            },),


            Form_Fields().book_filed("Email Address", emailController, 100, false, false),
            Form_Drop_Down("City", city, 50, false, true,on_slected: () async {
              var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_City()));
              if (pageResult != null) {
                setState(() {
                  City_Model model = pageResult;
                  city.text=model.city_name;
                  city_id=model.city_id;
                  state_id=model.state_id;
                  country_id=model.country_id;


                });
              }
            }),
            Form_Fields().book_filed("Correspondence Address", address, 100, false, false),


            Form_Fields().pin("Pin Code", pin, true),


            Form_Fields().passwords("Password", passwordController, 50, false, false),
            InkWell(
              onTap: () async {
                var res=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tnc(cheked,1)));
                if(res!=null){
                  setState(() {
                    cheked=res;
                  });
                }

              },

              child: new Container(margin:EdgeInsets.only(left: 5,right: 5),child: new Row(
              children: [
                cheked==true?Icon(Icons.check_box,color: ColorFile.app_color,): Icon(Icons.check_box_outline_blank),
                new SizedBox(width: 10,),
                Expanded(child:new Container(child: new Text("I accept PeProp.Money Terms & Conditions",style: Styles().styles_medium(14, ColorFile.app_color),),)

                )
              ],
            ),),),


            new SizedBox(height: 20,),
            InkWell(child: new Container(margin:EdgeInsets.only(left: 5,right: 5),child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(cheked_user_concern)Icon(Icons.check_box,color: ColorFile.app_color,)else Icon(Icons.check_box_outline_blank),
                new SizedBox(width: 10,),
                Expanded(child: new Container(child: new Text("I hereby appoint PeProp.Money as my authorized representative to receive my credit information from Cibil / Equifax / Experian / CRIF Highmark (bureau).",style: Styles().styles_medium(14, ColorFile.app_color),),))
              ],
            ),),onTap: (){
              setState(() {
                cheked_user_concern=!cheked_user_concern;
              });
            },),
            _submitButton(),




          ],

        )),
        if(loading)Center(child: new CircularProgressIndicator())
      ],),
    );
  }
  Widget _submitButton() {
    return  InkWell(child: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5,spreadRadius: 2)], gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,colors: [Color(0xfffbb448), Color(0xfff7892b)])),child: Text('Submit',style: Styles().styles_regular(16, ColorFile.white),
      ),
      ),onTap: (){
        if(nameController.text.length==0){
          AppUtils.toAst("Please Enter Full Name.!!",context);
        } else if(emailController.text.length==0){
          AppUtils.toAst("Please Enter Valid Email Address.!!",context);
        }else if(AppUtils.isEmail(emailController.text.toString())==false){
          AppUtils.toAst("Please Enter Valid Email Address.!!",context);
        }

        else  if(mobileController.text.length<10){
          AppUtils.toAst("Please Enter Valid 10 digit Mobile Number.!!",context);
        }

        else if(city.text.length==0){
          AppUtils.toAst("Please Select City.!!",context);
        } else  if(address.text.length==0){
          AppUtils.toAst("Please Enter Address.!!",context);
        } else  if(pin.text.length<6){
          AppUtils.toAst("Please Enter 6 Digit Pin.!!",context);
        }

        else if(passwordController.text.length<6){
          AppUtils.toAst("Password Should be atleast 6 digit long.!!",context);
        } else if(cheked==false){
          AppUtils.toAst("Please Select Terms & Conditions..!!",context);
        }else{
          register();
        }
      },);
  }

  Future<void> register() async {
    setState(() {
      loading=true;
    });
    String? token = await FirebaseMessaging.instance.getToken();
     var map;
     map=await Generate_Hash_Map().register(nameController.text.toString(),mobileController.text,emailController.text,passwordController.text, city_id,state_id,country_id,coutnry_Code,token.toString(),address.text.toString(),"","",cheked_user_concern,pin.text.toString());
     FormData formData = FormData.fromMap(map);
     Response response =await  ServiceConfig().postApiBodyAuthJson(API.postCustomerRegistration, formData, context);
    if (response != null && response.statusCode == 200) {
      var status = response.data["status"] as bool;
      if (status) {
        AppUtils.toAst(response.data["message"],context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register_OTP(map,response.data["data"].toString())));
      } else {
        AppUtils.toAst('Data not exist',context);
        setState(() {
          loading = false;
        });
      }
    }
    setState(() {
      loading=false;
    });




  }

  show_country_picker() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: TextStyle(
              fontSize: 16, fontFamily: "medium", color: Colors.blueGrey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          inputDecoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Start typing to search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2))))),
      onSelect: (Country country) {
        setState(() {
          coutnry_Code = "" + country.phoneCode;
        });
      },
    );
  }

  Future<void> create_log() async {
    await  FireBase_Logs().log_screen_view("Consumer Registration", "Consumer Registration");


  }


}
