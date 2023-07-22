import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Filters/Bottom_sheet_For_Area.dart';
import 'package:peprop_consumer_app/Kyc/Pan_Verification.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/User_Profile_Mode.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Kyc/Aadhar_Verification.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.title,
    required this.value,

  }) : super(key: key);

  final String title, value;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: ColorFile.light_bc,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:ColorFile.bgs,
        ),
        onPressed: (){},
        child: Container(
          child:      new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: Styles().styles_bold(14, ColorFile.hint_color),),
              new SizedBox(height: 5,),
              new Container(child: new Row(children: [
                Expanded(child: new Container(child: Text(value,style: Styles().styles_regular(12, ColorFile.black),),))
              ],),)
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu_verify extends StatelessWidget {
  ProfileMenu_verify(String title,String value,User_Profile_Model? profile_model){
    this.title=title;
    this.value=value;
    this.profile_model=profile_model;

  }

   String title="", value="";
  User_Profile_Model? profile_model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: ColorFile.light_bc,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:ColorFile.bgs,
        ),
        onPressed: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Expanded(child: new Container(child: new Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(title,style: Styles().styles_bold(14, ColorFile.hint_color),),
               new SizedBox(height: 5,),
               Text(value,style: Styles().styles_regular(12, ColorFile.black),),
             ],
           ),)),
            
           if(profile_model!.kyc_status=="1")new Container(child: Image.asset("assets/verified.png",height: 30,width: 30,),)else InkWell(child: new Container(child: new Text("Verify KYC",style: Styles().styles_medium(12, ColorFile.app_color),),),onTap: () async {
             var res=await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pan_Verification()));
             Navigator.pop(context);

           },)


          ],
        ),
      ),
    );
  }
}
class ProfileMenu_RERaverify extends StatelessWidget {
  ProfileMenu_RERaverify(String title,String value,String verify){
    this.title=title;
    this.value=value;
    this.verify=verify;

  }

  String title="", value="";
  String verify="";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: ColorFile.light_bc,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:ColorFile.bgs,
        ),
        onPressed: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: new Container(child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: Styles().styles_bold(14, ColorFile.hint_color),),
                new SizedBox(height: 5,),
                Text(value,style: Styles().styles_regular(12, ColorFile.black),),
              ],
            ),)),

            if(verify=="1")new Container(child: Image.asset("assets/verified.png",height: 30,width: 30,),)else InkWell(child: new Container(child: new Text("Verify KYC",style: Styles().styles_medium(12, ColorFile.app_color),),),onTap: () async {
              var res=await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pan_Verification()));
              Navigator.pop(context);

            },)


          ],
        ),
      ),
    );
  }
}




class ProfileMenu_User extends StatelessWidget {
  Function () on_click;
  ProfileMenu_User(String heading,String subheading,String icon,{required this.on_click}){
    this.heading=heading;
    this.subheading=subheading;
    this.icon=icon;
  }
   String heading="", subheading="";
  String icon="";

  @override
  Widget build(BuildContext context) {
    return
      InkWell(child: new Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(icon,height: 30,width: 30,),
              new SizedBox(width: 20,),
              Expanded(child: Container(child:  new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(heading,style: Styles().semi(14, ColorFile.black),),
                  new SizedBox(height: 5,),
                  Text(subheading,style: Styles().styles_regular(12, ColorFile.hint_color),),
                  new SizedBox(height: 20,),
                  new Container(child: new Row(),height: .2,color: ColorFile.hint_color,)

                ],
              ),))

            ],
          ),
        ),),onTap: (){
        on_click();
      },);
  }
}


class ProfileMenu_Call extends StatelessWidget {
  const ProfileMenu_Call({
    Key? key,
    required this.title,
    required this.value,

  }) : super(key: key);

  final String title, value;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: ColorFile.light_bc,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:ColorFile.bgs,
        ),
        onPressed: (){

        AppUtils().open_dialer(value);


        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: new Container(child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title.toString(),style: Styles().styles_bold(14, ColorFile.hint_color),),
                new SizedBox(height: 5,),
                Text(value.toString(),style: Styles().styles_regular(12, ColorFile.black),),
              ],
            ),)),
            new Container(padding: EdgeInsets.all(10),child: new Icon(Icons.call,color: ColorFile.white,),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.yellowdark),)

          ],
        ),
      ),
    );
  }
}