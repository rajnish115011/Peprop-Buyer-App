


import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/Camera_Gallery_Class.dart';
import 'package:peprop_consumer_app/widgets/ImagePickerDialog.dart';
import 'package:peprop_consumer_app/widgets/User_Profile_Mode.dart';
import 'dart:convert' show json, utf8;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Color/ColorFile.dart';
import '../Models/City_Model.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../Search/Search_City.dart';
import '../Utils/FireBase_Logs.dart';
import '../widgets/Bottom_Button.dart';
import '../widgets/Form_Drop_Down.dart';
import '../widgets/Form_Fields.dart';
import '../wish_list/Styles.dart';
import 'package:async/async.dart';

class Edit_Profile extends StatefulWidget{
  User_Profile_Model? profile_model;
  Edit_Profile(User_Profile_Model? profile_model){
    this.profile_model=profile_model;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Edit_Profile>{
  XFile? file;
  final city=TextEditingController();
  final address=TextEditingController();



  final pan=TextEditingController();
  final aadhar=TextEditingController();




  @override
  void initState() {
    super.initState();
    set_data();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Edit Profile"),
      body: new SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            new SizedBox(height: 20,),
            InkWell(child:
            new Container(

              alignment: Alignment.center,
              width:100,
              height: 100,

              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(100),
                  color: ColorFile.bgs
              ),
              child:ClipRRect(child:file==null?
              FadeInImage.assetNetwork(
                placeholder: 'assets/loading.png',
                image:API.profile_path+widget.profile_model!.photo.toString(),
                width:100,
                height: 100,
                imageErrorBuilder: (context, error, stackTrace) {
                  return new Container(child: Image.asset("assets/editphoto.png"),height: 100,width: 100);//do something
                },
              ):Image.file(File(file!.path,),height: 100,width: 100,),  borderRadius: new BorderRadius.circular(100),),
            ),onTap: (){
              showAlertDialog();


            },),
            new SizedBox(height: 30,),

            Form_Drop_Down("City", city, 50, false, true,on_slected: () async {
              var pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_City()));
              if (pageResult != null) {
                setState(() {
                  City_Model model = pageResult;
                  city.text=model.city_name;
                  widget.profile_model!.city_id=model.city_id;
                  widget.profile_model!.state_id =model.state_id;
                  widget.profile_model!.country_id=model.country_id;


                });
              }
            }),
            Form_Fields().book_filed("Correspondence Address", address, 100, false, false),
            if(widget.profile_model!.kyc_status!="1")Form_Fields().book_filed("Pan Number", pan, 10, false, false),
            if(widget.profile_model!.kyc_status!="1")Form_Fields().book_numric("Aadhaar Number", aadhar, 12, true, false),
          ],
        ),

      ),
      bottomNavigationBar:Bottom_Button("Update",onclick: (value){
        update();



        },)

    );
  }
   showAlertDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child:  Text('Camera',style:Styles().styles_regular(12, ColorFile.black)),
            onPressed: () async {
              Navigator.pop(context, 'One');
              file=await Camera_Gallery_Class().open_camera();
              setState(() {

              });

            },
          ),
          CupertinoActionSheetAction(
            child:  Text('Gallery',style:Styles().styles_regular(12, ColorFile.black)),
            onPressed: () async {
              Navigator.pop(context, 'Two');
              file=await Camera_Gallery_Class().open_gallery();
              setState(() {

              });

            },
          ),
         ],
          cancelButton: CupertinoActionSheetAction(
            child:  Text('Cancel',style:Styles().styles_regular(12, ColorFile.red_900)),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          ),
      ),
    );
  }

  Future<void> set_data() async {

    await  FireBase_Logs().log_screen_view("Edit Profile Form", "Edit Profile Form");

    address.text=widget.profile_model!.c_address.toString();
    city.text=widget.profile_model!.city_name.toString();
    aadhar.text=widget.profile_model!.aadhar.toString();
    pan.text=widget.profile_model!.pan.toString();
    setState(() {

    });


  }

  void update()async {

    var uri = Uri.parse(API.editCustommerDetails);
    var request = new http.MultipartRequest("POST", uri);
    if (file != null) {

      String fileName = file!.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(file!.openRead()));
      var length = await file!.length(); //imageFile is your image file
      var multipartFileSign = new http.MultipartFile('img_name', stream, length, filename: fileName);
      request.files.add(multipartFileSign);

    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {"Accept": "application/json", "Authorization": sharedPreferences.getString("token").toString()}; // ignore this headers if there is no authentication

    request.headers.addAll(headers);
    request.fields['pan'] =pan.text.toString();
    request.fields['aadhar'] =aadhar.text.toString();
    request.fields['c_address'] =address.text.toString();
    request.fields['city_id'] =widget.profile_model!.city_id.toString();
    request.fields['state_id'] = widget.profile_model!.state_id.toString();
    request.fields['country_id'] = widget.profile_model!.country_id.toString();
    print(request.fields.toString());
    AppUtils().showProgressDialog(context);
    var response = await request.send();
    Navigator.of(context, rootNavigator: true).pop("Discard");
    response.stream.transform(utf8.decoder).listen((value) {
      print("response"+value.toString());

    });
    if (response.statusCode == 200) {
      var data=await All_Bottom_Sheets().Success_dialog("You have successfully updated your profile.", context);
      if(data!=null&&data==true){
        Navigator.pop(context,"response");
      }

    } else{
      AppUtils.toAst("Something Went Wrong. Please Try again later..!",context);
    }


  }





}