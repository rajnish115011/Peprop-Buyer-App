import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:open_file_safe/open_file_safe.dart';




import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Book_Now_Model.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Online_Booking.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Properties/Details_Units_Sheet.dart';
import 'package:peprop_consumer_app/Terms_and_Conditions/Rewards_List.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/Brochure_%20Button_Widget.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readmore/readmore.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../Book_Now/Booking/Form_Booking.dart';
import '../Book_Now/Form_Property_Model.dart';
import '../Book_SIte_Visit/Book_Site_Visit.dart';
import '../Models/Aminities_Model.dart';
import '../Models/Apartments_Model.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../Utils/FireBase_Logs.dart';
import '../widgets/Bank_loan_view.dart';
import '../widgets/Widget_Detail_Page_Image_Logo.dart';
import '../widgets/Widget_Offers_List.dart';
import '../widgets/key_feature_widget.dart';
import 'Bottom_sheet_For_Unit_Type.dart';
import 'Show_units.dart';
import 'View_Property_Model.dart';
import 'details_widgets/Detail_Aminity.dart';
import 'details_widgets/Detail_Gallery.dart';




class Properties_Detail extends StatefulWidget{
  String id="";
  String is_click="";
  Properties_Detail(String id, String is_click)
  {
    this.id=id;
    this.is_click=is_click;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Details();
  }

}



class Details extends State<Properties_Detail>{
  bool loading=false;
  bool synch=false;

  var PropertDescription="";
  String FeatureImageUrl="";

  String RequestButton="";

  String website="";
  String Rera="";
  String furnishing_name="";
  String PossessionDate="";

  String SquareArea="";
  String Neighborhood="";
  String brochure="";
  String invoice_insurance="";
  String BuilderId="";


  String logo="";
  String fullname="";
  String Area="";

  String booking_option="";
  String booking_max_amount="";
  String booking_min_amount="";




  List<Offers>offer_list=[];
  var response;




  int selected_price=-1;
  List<dynamic>gallery_list=[];

  List<TC_Model>towerList=[];
  final Dio _dio = Dio();
  var isSuccess;
  int size=10;
  late YoutubePlayerController _ytbPlayerController;

List<Aminities_Model>aminities_list=[];

  String Video_embedded="";
  String is_added="1";
  String push_response="";
  String information_only_status="";
  String kyc_status="";
  String dis="";
  String userId = "";

  View_Property_Model? view_property_model;



  var model;



  @override
  void initState() {
    super.initState();


    get_properties();
    // get_similar();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(top:false,child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBar(context, "title"),
      body:loading==false?new Stack(
        children: [
          if(view_property_model!=null) new SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child:  new Container(
              margin: EdgeInsets.all(10),
              child:  new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Widget_Detail_Page_Image_Logo(FeatureImageUrl,Rera,gallery_list,logo,invoice_insurance,view_property_model),
                     key_feature_widget(view_property_model),
                     if(information_only_status=="1")new Container(
                       decoration: new BoxDecoration(border: new Border.all(color: ColorFile.black,width: 1)),
                       margin: EdgeInsets.only(top: 20),
                       padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                       child:new Row(children: [

                        new Text("The project details are for Information only.",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,)

                      ],) ),

                      //offers
                      if(offer_list.length>0)Widget_Offers_List(offer_list),


                      if(view_property_model!.price_of_list.length>0)new Container(
                      margin: EdgeInsets.only(top: 40),
                      child:
                      new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(child:new Text("Unit Type & Pricing",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),),
                        Container(
                          margin: EdgeInsets.only(right: 10,top: 30),
                          height: 35,
                          child:
                          new Row(
                            children: [
                              Expanded(
                                child:
                                ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:view_property_model!.price_of_list.length,
                                    itemBuilder: (BuildContext context, int index) =>
                                        InkWell(child:
                                        selected_price!=index?Container(alignment: Alignment.center,margin: EdgeInsets.only(right: 15),child:new Row(children: [ new Text(view_property_model!.PropertyType!.toString()=="1"?view_property_model!.price_of_list[index].name+" "+view_property_model!.PropertyTypeName.toString():view_property_model!.price_of_list[index].name,style: Styles().styles_regular(12, ColorFile.black),),new SizedBox(width: 5,),Icon(Icons.keyboard_arrow_down_rounded)],),padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),border: new Border.all(width: 1,color: ColorFile.lightgray)),):Container(alignment: Alignment.center,margin: EdgeInsets.only(right: 15),child:new Row(children: [ new Text(view_property_model!.PropertyType!.toString().toString()=="1"?view_property_model!.price_of_list[index].name+" "+view_property_model!.PropertyTypeName.toString():view_property_model!.price_of_list[index].name,style: Styles().styles_regular(12, ColorFile.black),),new SizedBox(width: 5,),Icon(Icons.keyboard_arrow_down_sharp)],),padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),color: ColorFile.app_color_gradient)),
                                        onTap: (){
                                          setState(() {
                                            show_all_units(index);
                                            selected_price=index;
                                          });
                                        },


                                        )

                                ),
                              )
                            ],
                          ),
                        ),
                        new SizedBox(height: 30,),

                       if(model!=null) Show_units(model,widget.is_click,booking_option,view_property_model!.PropertyTitle!.toString(),view_property_model!.PropertyType!.toString(),view_property_model!.PropertyTypeName!.toString(),book_now: (){
                         book_now();
                       },),








                      ],
                    ),
                  ),







                       //floor plan


                     Bank_loan_view(view_property_model!.bank_loan,view_property_model),





                       if(gallery_list.length>0)Detail_gallery(gallery_list,"prop"),
                       if(aminities_list.length>0)Detail_Aminity(aminities_list,"prop"),
                        new Container(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 30),
                        child: new Container(
                          child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(
                              child:new Text("Explore Locality",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),
                            ),
                            new SizedBox(height: 10,),
                            InkWell(
                              onTap: (){
                                AppUtils().launchMap(view_property_model!.loc_name.toString()+" , "+view_property_model!.city_name.toString()+" - "+view_property_model!.state_name.toString()+" , "+view_property_model!.country_name.toString());
                              },
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Container(child:new Text(view_property_model!.PropertyTitle.toString()+", "+view_property_model!.loc_name.toString()+" , "+view_property_model!.city_name.toString()+" - "+view_property_model!.state_name.toString()+" , "+view_property_model!.country_name.toString(),style: new TextStyle(fontSize: 14,fontFamily: "regular",color: ColorFile.hint_color),),),
                                new SizedBox(height: 20,),
                                new Container(
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: new Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(child: Image.asset("assets/maps.jpg",height: 100,fit: BoxFit.cover,),borderRadius: new BorderRadius.circular(5),),
                                      new Container(child: new Text("View on Map"),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.white),padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),),
                                    ],
                                  ),
                                ),
                              ],
                            ),)




                          ],
                        ),
                      )

                  ),
                       new Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 30),

                      child: new Container(


                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(
                              child:new Text("More About Project",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),
                            ),

                            new SizedBox(height: 20,),
                            new Container(
                              child:new Column(
                                children: [



                                  new Container(

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Flexible(child: Html(data: PropertDescription,
                                            style: {
                                              "body": Style(
                                                  fontFamily: "regular",
                                                  fontSize: FontSize(14.0),
                                                  color: ColorFile.black

                                              ),
                                              'html': Style(textAlign: TextAlign.justify,color: ColorFile.black),
                                              "table": Style(
                                                  color: ColorFile.black,
                                                  fontFamily: "Medium"
                                              ),
                                              "tr": Style(
                                                fontFamily: "regular",
                                                color: ColorFile.black,
                                              ),
                                              "th": Style(
                                                fontFamily: "regular",
                                                color: ColorFile.black,
                                              ),
                                              "td": Style(
                                                fontFamily: "regular",
                                                color: ColorFile.black,

                                              ),
                                              "h1": Style(
                                                  fontFamily: "medium"
                                              ),
                                            },





                                          )),









                                        ],
                                      )),

                                ],
                              ),
                            )



                          ],
                        ),
                      )

                  ),


                    if(brochure.length>0)Brochure_Button_Widget(on_click: (){
                    download(API.property_brochures+brochure);
                    }),




                      if(Video_embedded.length>0) new Card(
                      margin: EdgeInsets.only(top: 10),
                      child: new Container(
                        padding:  EdgeInsets.all(10),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(child:new Text("Project Video",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),)),
                            new SizedBox(height: 20,),
                            _buildYtbView(),


                          ],
                        ),
                      )

                  ),

                  if(view_property_model!.booking_partner_name!="")new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        margin: EdgeInsets.only(top: 10),
                        child:     new Row(children: [
                        Expanded(child: new Container(child:new Text("Booking Partner Details",style: new TextStyle(fontFamily: "bold",color: ColorFile.black,fontSize: 18),textAlign: TextAlign.start,),)),


                      ],) ,),
                      new Container(
                          decoration: new BoxDecoration(border: new Border.all(color: ColorFile.black,width: 1)),
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child:new Column(
                            children: [


                              new Container(child:     new Row(children: [
                                new Container(child:new Text("Company Name : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                                Expanded(child: new Container(child:new Text(view_property_model!.comp_name.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                              ],) ,),
                              new SizedBox(height: 5,),
                              new Container(child:     new Row(children: [

                                new Container(child:new Text("Name : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                                Expanded(child: new Container(child:new Text(view_property_model!.booking_partner_name.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                              ],) ,),
                              new SizedBox(height: 5,),

                              new Container(child:     new Row(children: [

                                new Container(child:new Text("Mobile : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                                Expanded(child: new Container(child:new Text("+91"+view_property_model!.booking_partner_mobile.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                              ],) ,),

                              new SizedBox(height: 5,),

                              new Container(child:     new Row(children: [

                                new Container(child:new Text("Email : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                                Expanded(child: new Container(child:new Text(view_property_model!.booking_partner_email.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                              ],) ,),
                              new SizedBox(height: 5,),

                              new Container(child:     new Row(children: [
                                new Container(child:new Text("RERA : ",style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),),
                                Expanded(child: new Container(child:new Text(view_property_model!.booking_partner_rera.toString(),style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,),))


                              ],) ,),





                            ],
                          )




                      ),
                    ],
                  ),


                  if(dis.length>0)
                    new Container(
                    padding: const EdgeInsets.all(10),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new SizedBox(height: 30,),
                        new Container(child:new Text("Disclaimer",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),),
                        new SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: ReadMoreText(
                            dis.toString(),
                            trimLines: 2,
                            style: new TextStyle(color: ColorFile.black,fontSize: 13,fontFamily: "regular"),
                            colorClickableText: ColorFile.app_color,
                            trimMode: TrimMode.Line,
                            moreStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                            lessStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                            trimCollapsedText: '...Read More',
                            trimExpandedText: '..show less',
                          ),
                        ),


                      ],
                    ),
                  )




                   ,

                    new SizedBox(height: 100,),







                ],
              ),
            ),

          ),
          synch==true?Center(child: new CircularProgressIndicator(),):new Container(),

        ],
      ):Center(child: CircularProgressIndicator(),),
      bottomNavigationBar:widget.is_click!="false"?Container(
        child: Row(
          children: <Widget>[
           if(is_added=="0") Expanded(
              child:InkWell(child: Container(
                height: 56,
                alignment: Alignment.center,
                color: Colors.green,
                child: Text("Book Site Visit", style: Styles().styles_bold(12, ColorFile.white)),
              ),onTap: (){
                  showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context,StateSetter setModalState) =>
                            Wrap(children: [
                              Book_Site_Visit(widget.id, userId,onselected: (){
                                setState(() {
                                  is_added="1";
                                });

                              },)

                            ]));
                  },
                );
              },),
            ),
           if(booking_option=="1"||booking_option=="2"&&information_only_status!="1") Expanded(
              child: InkWell(child: Container(
                height: 56,
                alignment: Alignment.center,
                color: Colors.red,
                child: Text("Book Now", style: Styles().styles_bold(12, ColorFile.white)),
              ),onTap: () async {
                var data=await All_Bottom_Sheets().Confirmation_dialog("Booking", "Are you sure, you want to book now?", context);
                if(data!=null&&data==true){
                  book_now();
                }


              },),
            ),
          ],
        ),
      ):new Container(height: 0,),
      floatingActionButton:

      view_property_model!=null&&view_property_model!.property_rewards.length>0?
      FloatingActionButton.extended(
        backgroundColor: ColorFile.app_color,
        onPressed: (){
          var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Rewards_List(view_property_model!.property_rewards)));


        },
        icon: Icon(Icons.real_estate_agent),
        label: Text('REWARDS',style: Styles().styles_regular(12, Colors.white),),
      ):new Container(height: 0,),

    ));
  }

  Future<void> get_properties() async {

    await  FireBase_Logs().log_screen_view("View Property Details", "View Property Details");

    print("id"+widget.id);
    SharedPreferences sp=await SharedPreferences.getInstance();
    kyc_status=sp.getString("kyc_status").toString();
    userId=sp.getString("userId").toString();
    setState(() {loading=true;aminities_list.clear();});
    Map data={"property_id":widget.id,'user_id':sp.getString("user_id").toString()};
    ServiceConfig().postApiBodyAuthJson(API.gePropertyListByPropId,data, context).then((value){
      setState(() {loading=false;});
      Response response=value;
      if(response!=null&&response.statusCode==200){
        if(response.data["list"]!=null){
          var builder_details = response.data["list"];
          view_property_model = View_Property_Model.fromJson(builder_details);
        }
        PropertDescription=response.data["list"]["PropertDescription"].toString().toString().replaceAll("null", "");
        FeatureImageUrl=response.data["list"]["FeaturedImage"].toString().toString().replaceAll("null", "");
        website=response.data["list"]["website"].toString().toString().replaceAll("null", "");
        Rera=response.data["list"]["Rera"].toString();
        RequestButton=response.data["list"]["RequestButton"].toString().toString().replaceAll("null", "");
        furnishing_name=response.data["list"]["furnishing_name"].toString().toString().replaceAll("null", "");
        PossessionDate=response.data["list"]["PossessionDate"].toString().toString().replaceAll("null", "");
        SquareArea=response.data["list"]["SquareArea"].toString().toString().replaceAll("null", "");
        Area=response.data["list"]["Area"].toString().toString().replaceAll("null", "");
        is_added=response.data["list"]["property_save_later"].toString().toString().replaceAll("null", "");

        Neighborhood=response.data["list"]["Neighborhood"].toString().replaceAll("null", "");
        brochure=response.data["list"]["brochure"].toString().toString().replaceAll("null", "");
        booking_option=response.data["list"]["booking_option"].toString().toString().replaceAll("null", "");

        booking_max_amount=response.data["list"]["booking_max_amount"].toString().toString().replaceAll("null", "");
        booking_min_amount=response.data["list"]["booking_min_amount"].toString().toString().replaceAll("null", "");

        invoice_insurance=response.data["list"]["invoice_insurance"].toString().toString().replaceAll("null", "");
        BuilderId=response.data["list"]["BuilderId"].toString().toString().replaceAll("null", "");

        print("builder id"+BuilderId);

        information_only_status=response.data["list"]["information_only_status"].toString().toString().replaceAll("null", "");
        Video_embedded=response.data["list"]["Video_embedded"].toString().toString().replaceAll("null", "");

        if(Video_embedded.length>0){
         String videoId = YoutubePlayerController.convertUrlToId(Video_embedded).toString();
            _ytbPlayerController = YoutubePlayerController(
            initialVideoId: videoId,
            params: YoutubePlayerParams(
              showFullscreenButton: true,
            ),
          );
        }
        logo=response.data["list"]["builder_logo"].toString();
        fullname=response.data["list"]["fullname"].toString();

        var offer = response.data["list"]["Offers"] as List;
        offer_list = offer.map<Offers>((json) => Offers.fromJson(json)).toList();


        if(response.data["list"]["tower_map"]!=null){
          var tower = response.data["list"]["tower_map"] as List;
          towerList = tower.map<TC_Model>((json) => TC_Model.fromJson(json)).toList();
        }
        if(response.data["list"]["gallery"]!=null){
          gallery_list= response.data["list"]["gallery"];
        }
        var am_list = response.data["list"]["Amenities"] as List;
        aminities_list = am_list.map<Aminities_Model>((json) => Aminities_Model.fromJson(json)).toList();

      }

       if(response.data["list"]["disclaimer"]!=null&&response.data["list"]["disclaimer"]["message"]!=null){

          dis=response.data["list"]["disclaimer"]["message"].toString();

       }

    }).catchError((error, stackTrace) {
      AppUtils.toAst(error.toString(),context);
      setState(() {
        loading=false;
      });

    });
  }

  _buildYtbView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _ytbPlayerController != null
          ? YoutubePlayerIFrame(controller: _ytbPlayerController)
          : Center(child: CircularProgressIndicator()),
    );
  }




  Future<void> download(String url) async {
    print(url);

    // requests permission for downloading the file
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission)
      return;

    setState(() {
      synch=true;
    });
    var dir=await getApplicationDocumentsDirectory();
    Dio dio = Dio();
    await dio.download(url, "${dir!.path}/$brochure");
    setState(() {
      synch=false;
    });
    OpenFile.open("${dir!.path}/$brochure", type: 'application/pdf');
  }

  // requests storage permission
  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }




  void method_show() {
    showModalBottomSheet(
          shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
      ),
        context: context,
        builder: (context) {
          return new Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
            ),
            child:
            Bottom_sheet_For_Unit_Type(view_property_model!.priceList,view_property_model!.PropertyTypeName.toString(),selected_price,view_property_model!.PropertyType!.toString(),onSelectionChanged: (value){
              if(value!=null){
               setState(() {
                 selected_price=value;
               });

              }


            },),
          );
        });

  }

  error_dialog(BuildContext context, String message) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'Disclaimer',
              style: new TextStyle(fontFamily: "medium", fontSize: 15),
            ),
            content: Text(
              message.toString(),
              style: new TextStyle(fontFamily: "regular", fontSize: 12,),
              textAlign: TextAlign.justify,
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop("Discard");
                },
                child: Text(
                  'Close',
                  style: new TextStyle(fontFamily: "medium", fontSize: 15),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }


  void pop() {
    Navigator.pop(context,response);
  }

  void book_now() {
    if(booking_option=="2"||booking_option=="1"){
      Form_Property_Model model=Form_Property_Model();
      model.property_title=view_property_model!.PropertyTitle!.toString();
      model.image=FeatureImageUrl;
      model.logo=logo;
      model.rera=Rera;
      model.addess=view_property_model!.loc_name!.toString()+" , "+view_property_model!.city_name!.toString()+" - "+view_property_model!.state_name!.toString()+" , "+view_property_model!.country_name!.toString();
      model.booking_min_amount=booking_min_amount;
      model.booking_max_amount=booking_max_amount;
      model.booking_option=booking_option;
      model.property_id=widget.id;
      model.BuilderId=BuilderId;
      model.view_property_model=view_property_model;
      Book_Now_Model book_now_model=new Book_Now_Model();
      book_now_model.form_property_model=model;
      if(booking_option=="1"){
        var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Online_Booking(book_now_model,null)));

      }
      if(booking_option=="2"){
        var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Form_Booking(book_now_model)));

      }

    }


  }

  void show_all_units(int index) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        context: context,
        builder: (context) {
          return new Container(
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
              child:Details_Units_Sheet(view_property_model!.price_of_list[index].list,model,onSelectionChanged: (value){
                setState(() {
                  model=value;
                });

              },)

          );
        });





  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  final DateTime? x;
  final int? yValue;
}
class SalesData {
  SalesData(this.year, this.data, this.sales,);

  final String year;
  final String sales;
  final int data;
}
class ChartData{
  ChartData(this.x, this.y);
  final int x;
  final double y;
}