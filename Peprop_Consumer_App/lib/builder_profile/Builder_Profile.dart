import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/Builder_Models.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Color/ColorFile.dart';
import '../Utils/FireBase_Logs.dart';
import '../widgets/Form_Title.dart';

class Builder_profile extends StatefulWidget{
  String id="";
  Builder_profile(String id){
    this.id=id;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}


class Build_State extends State<Builder_profile>{
  bool loading=false;
  Builder_Models?builder_detail_model;

  @override
  void initState() {
    super.initState();
    get_data();
    create_log();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
        Scaffold(appBar: AppUtils.appBar(context, ""),
        body:Stack(
          children: [
            loading==true?Center(child: new CircularProgressIndicator(),):builder_detail_model==null?Center(child:No_Data_Placeholder("Profile Not Found")):
            Padding(padding: EdgeInsets.all(10),child: SingleChildScrollView(child: Column(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            image:  DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(API.builde_logo.toString()+"/"+builder_detail_model!.builder_banner_name.toString()),
                            ),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                new Container(

                                  padding: EdgeInsets.all(10),
                                  decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.circular(100),
                                      color: ColorFile.white,
                                      border: new Border.all(width: 1,color: ColorFile.app_color)
                                  ),
                                  child:
                                  ClipRRect(child:

                                  FadeInImage.assetNetwork(
                                    placeholder: 'assets/loading.png',
                                    image:API.builde_logo+"/"+builder_detail_model!.logo_name.toString(),
                                    width:90,
                                    height: 90,
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return Image.asset("assets/placeholder.png",
                                          width: 90,
                                          fit: BoxFit.cover,
                                          height: 90);//do something
                                    },
                                  ),  borderRadius: new BorderRadius.circular(100),),
                                ),

                              ],
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                new SizedBox(height: 20,),

                new Container(child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Text(builder_detail_model!.fullname.toString(),style: Styles().styles_bold(22, ColorFile.black),)
                  ],
                ),),

                new SizedBox(height: 20,),


                new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                  children: [
                    new Container(
                      height: 50,
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.app_color),
                      child:
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text("Contact Details",style: Styles().styles_bold(16, ColorFile.white),)
                        ],),),
                    new Container(
                      padding: EdgeInsets.all(10),
                      child: new Column(
                        children: [
                          Form_Title("Mobile","Email"),
                          new SizedBox(height: 5,),
                          Form_Title_content(builder_detail_model!.mobile.toString(),builder_detail_model!.email.toString()),
                          new SizedBox(height: 10,),

                          Form_Title("City","State"),
                          new SizedBox(height: 5,),
                          Form_Title_content(builder_detail_model!.city_name.toString(),builder_detail_model!.state_name.toString()),
                          new SizedBox(height: 10,),



                        ],
                      ),),



                  ],
                ),),


                //company details
                new SizedBox(height: 20,),
                new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                  children: [
                    new Container(
                      height: 50,
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.app_color),
                      child:
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text("Company Details",style: Styles().styles_bold(16, ColorFile.white),)
                        ],),),
                    new Container(
                      padding: EdgeInsets.all(10),
                      child: new Column(
                        children: [
                          Form_Title("Company Name","Contact Name"),
                          new SizedBox(height: 5,),
                          Form_Title_content(builder_detail_model!.comp_name.toString(),builder_detail_model!.comp_contact_person.toString()),
                          new SizedBox(height: 10,),

                          Form_Title("Mobile","Email"),
                          new SizedBox(height: 5,),
                          Form_Title_content(builder_detail_model!.comp_contact_person_mobile.toString(),builder_detail_model!.comp_contact_person_email.toString()),
                          new SizedBox(height: 10,),

                          Form_Title("Company Address","Builder Address"),
                          new SizedBox(height: 5,),
                          Form_Title_content(builder_detail_model!.comp_address.toString(),builder_detail_model!.builder_address.toString()),
                          new SizedBox(height: 10,),



                        ],
                      ),),



                  ],
                ),),


                //descriptions
                new SizedBox(height: 20,),
                if(builder_detail_model!.BuilderDescription.toString().length>0)new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                  children: [
                    new Container(
                      height: 50,
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.app_color),
                      child:
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text("Description",style: Styles().styles_bold(16, ColorFile.white),)
                        ],),),
                    new Container(
                      padding: EdgeInsets.all(10),
                      child: new Column(
                        children: [


                          new SizedBox(height: 5,),
                          Form_Title2_content( Styles.stripHtmlIfNeeded(builder_detail_model!.BuilderDescription.toString())),
                          new SizedBox(height: 10,),

                        ],
                      ),),




                  ],
                ),),
                new SizedBox(height: 20,),

              ],
            ),)

            ),

          ],
        )

      ),
    );
  }
  Future<void> get_data() async {

    var _map = <String, String>{};
    _map['builder_id'] = widget.id.toString();

    setState(() {
      loading = true;
    });
    FormData mobile = new FormData.fromMap(_map);
    Response response=await ServiceConfig().postApiBodyAuthJson(API.builderDetails, mobile, context);
    if(response.data!=null&&response.statusCode==200&&response.data["list"]!=null&&response.data["list"]!=false){
      var builder_details = response.data["list"];
      builder_detail_model = Builder_Models.fromJson(builder_details);

    }
    setState(() {
      loading = false;
    });
  }
  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View Builder Profile", "View Builder Profile");

  }


}