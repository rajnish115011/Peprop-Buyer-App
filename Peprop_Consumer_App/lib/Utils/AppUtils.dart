import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Banking_OTP/Bank_List_Sheet.dart';
import 'package:peprop_consumer_app/Models/Tower_Model.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/bill_payment/Error_Bottom_Sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Color/ColorFile.dart';
import '../Dashboard/Dashboard.dart';
import '../Local_database/DatabaseService.dart';
import '../Local_database/Rec_city.dart';
import '../Models/Apartments_Model.dart';
import '../Models/Bank_List_Model.dart';
import '../Models/BlogModel/BlogModel.dart';
import '../Models/Most_Cities_Model.dart';
import '../Registration/Customer_Registration.dart';
import '../dashboard_model/Home_Model.dart';
import '../wish_list/Styles.dart';
import 'Home_Page_Model.dart';

class AppUtils {



  String arrays(String code){
    String xx="";
    List<String>list=code.split("");

    for(int i=0;i<list.length;i++){
      xx=xx+"X";
    }
    return xx;

  }
  Future<String> is_login() async {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String data =await sharedPreferences.getString("token").toString();
    return data;

  }




  String calculate_bsp(mandatory,bsp){
    double total=0;

    final numberFormatter = NumberFormat(
      "##,##,###",
      "en_US",     // local US
    );


    try{
      total=double.parse(mandatory)*double.parse(bsp);
    }catch(e){}


    return numberFormatter.format(total).toString();
  }
  String price(amount){
    try{
      final numberFormatter = NumberFormat(
        "##,##,###",
        "en_US",     // local US
      );
      return numberFormatter.format(double.parse(amount)).toString();
    }catch(e){
      return amount.toString();
    }
  }

  String total(mandatory,bsp){
    double total=0;

    final numberFormatter = NumberFormat(
      "##,##,###",
      "en_US",     // local US
    );


    try{
      total=double.parse(mandatory)+double.parse(bsp);
    }catch(e){}
     total=double.parse(mandatory)+double.parse(bsp);

    return numberFormatter.format(total).toString();
  }


  String total_discount(start,end){
    double total=0;

    double a=0;
    double b=0;

    final numberFormatter = NumberFormat(
      "##,##,###",
      "en_US",     // local US
    );
    try{
      a=double.parse(start);
    }catch(e){

    }    try{
      b=double.parse(end);
    }catch(e){

    }
    try{
      total=a+b;
    }catch(e){}
    return numberFormatter.format(total).toString();
  }




  String total_saving(start,end,cash){
    double total=0;

    double a=0;
    double b=0;
    double c=0;

    final numberFormatter = NumberFormat(
      "##,##,###",
      "en_US",     // local US
    );
    try{
      a=double.parse(start);
    }catch(e){

    }    try{
      b=double.parse(end);
    }catch(e){

    } try{
      c=double.parse(cash);
    }catch(e){

    }
    try{
      total=a+b+c;
    }catch(e){}
    return numberFormatter.format(total).toString();
  }



  String net_pay(start,end,cash,tot, Book_Now_all_Tower_Model? unit_no_list){
    double total=0;

    double a=0;
    double b=0;
    double c=0;
    double d=0;

   double  sum=0;
     unit_no_list!.extra_charges_details.forEach((element) {
      try{

        sum=sum+(double.parse(element.edit_qty)*double.parse(element.charge_amount));
      }catch(e){

      }

    });


    final numberFormatter = NumberFormat(
      "##,##,###",
      "en_US",     // local US
    );
    try{
      a=double.parse(start);
    }catch(e){

    }    try{
      b=double.parse(end);
    }catch(e){

    } try{
      c=double.parse(cash);
    }catch(e){

    }
    try{
      d=double.parse(tot);
    }catch(e){

    }
    try{
      total=(sum+d)-(a+b+c);
    }catch(e){}
    return numberFormatter.format(total).toString();
  }
  String net_pay1(start,end,cash,tot, Book_Now_all_Tower_Model? unit_no_list){
    double total=0;

    double a=0;
    double b=0;
    double c=0;
    double d=0;

    double  sum=0;
    unit_no_list!.extra_charges_details.forEach((element) {
      try{

        sum=sum+(double.parse(element.edit_qty)*double.parse(element.charge_amount));
      }catch(e){

      }

    });



    try{
      a=double.parse(start);
    }catch(e){

    }    try{
      b=double.parse(end);
    }catch(e){

    } try{
      c=double.parse(cash);
    }catch(e){

    }
    try{
      d=double.parse(tot);
    }catch(e){

    }
    try{
      total=(sum+d)-(a+b+c);
    }catch(e){}
    return total.toString();
  }


  String total_amt(start, Book_Now_all_Tower_Model? unit_no_list){
    double total=0;

    double a=0;
    double b=0;
    double c=0;
    double d=0;

    double  sum=0;
    unit_no_list!.extra_charges_details.forEach((element) {
      try{

        sum=sum+(double.parse(element.edit_qty)*double.parse(element.charge_amount));
      }catch(e){

      }

    });


    final numberFormatter = NumberFormat(
      "##,##,###",
      "en_US",     // local US
    );
    try{
      a=double.parse(start);
    }catch(e) {


    }
    try{
      total=(sum+a);
    }catch(e){}
    return numberFormatter.format(total).toString();
  }





  String firebase_date_time(String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(date, false);
    var dateLocal = dateTime.toLocal();
    var notification_Date =
    DateFormat("dd MMM hh:mm aa").format(dateLocal);
    return notification_Date;
  }
  static bool printLog = false;

  Future<Home_Page_Model>  sets(Map map){

   Home_Page_Model constant_model=Home_Page_Model();

   constant_model.notificationNewCount=map["notificationNewCount"].toString();
   Map mapValue =map["dashboard"];
   print(mapValue);
   List<Home_Model>home_list=[];
   List<Apartments_Model>buy_now_list=[];
   List<BlogModel>_blogModel=[];
   List<BImageModel>_getBImage=[];
   List<Apartments_Model>_propertiesList=[];
   List<Most_Cities_Model>most_cities=[];
   List<AuthorModel>_getAuthor=[];

    mapValue.forEach((key, value) {
      String heading=key.toString();
      String type=value["type"];
      String section_id=value["section_id"].toString();
      int no_of_column=int.parse(value["no_of_column"]);
      Home_Model model=new Home_Model();
      var data = value["list"] as List;
      List<Home_List_Model>l = data.map<Home_List_Model>((json) => Home_List_Model.fromJson(json)).toList();
      model.title=heading;
      model.type=type;
      model.section_id=section_id;
      model.num_of_column=no_of_column;
      model.list=l;

      try{
        if(map["user_points"]!=false){

          String earn_points=map["user_points"]["earn_points"].toString();
          String redeem_points=map["user_points"]["redeem_points"].toString();
          String balance_points=map["user_points"]["balance_points"].toString();
          model.earn_points=earn_points;
          model.redeem_points=redeem_points;
          model.balance_points=balance_points;


        }

      }catch(e){

      }
      home_list.add(model);



    });







    var notify = map["list"] as List;
    buy_now_list=notify.map<Apartments_Model>((json) => Apartments_Model.fromJson(json)).toList();



    if(map["blog"]!=null){
      var data = map["blog"] as List;
      _blogModel = data.map<BlogModel>((json) => BlogModel.fromJson(json)).toList();

    }

    if(map["blogmedia"]!=null){
      var data1 = map["blogmedia"] as List;
      _getBImage = data1.map<BImageModel>((json) => BImageModel.fromJson(json)).toList();

    }
      if(map["bloguser"]!=null){
      var data2 = map["bloguser"] as List;
     _getAuthor = data2.map<AuthorModel>((json) => AuthorModel.fromJson(json)).toList();

   }






    var hots = map["hot_properties"] as List;
    _propertiesList = hots.map<Apartments_Model>((json) => Apartments_Model.fromJson(json)).toList();


   var event = map["event"] as List;
   List<Event_Model> ev = event.map<Event_Model>((json) => Event_Model.fromJson(json)).toList();

   var popular = map["popularCity"] as List;
    most_cities = popular.map<Most_Cities_Model>((json) => Most_Cities_Model.fromJson(json)).toList();

    constant_model.home_list=home_list;
    constant_model.buy_now_list=buy_now_list;
    constant_model.blogModel=_blogModel;
    constant_model.getBImage=_getBImage;
    constant_model.propertiesList=_propertiesList;
    constant_model.most_cities=most_cities;
    constant_model.getAuthor=_getAuthor;
    constant_model.ev=ev;

    return Future.value(constant_model);


 }



  void launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  open_dialer(String mobile)async{
    var url = "tel:" + mobile;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  open_url(String url, BuildContext context)async{
    var u = url;
    if (await canLaunch(u)) {
      await launch(u);
    } else {
      toAst("Redirect url is invalid.",context);
      throw 'Could not launch $url';
    }
  }
  static void showLog(String msg) {
    if (printLog) {
      print("TAG>> $msg");
    }
  }



  String task_Date(String date) {
    var dateTime = DateFormat("dd MMM yyyy hh:mm aa").parse(date);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("dd-MM-yyyy").format(dateLocal);
    return notification_Date;
  }
  String task_time(String date) {
    var dateTime = DateFormat("dd MMM yyyy hh:mm aa").parse(date);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("HH:mm").format(dateLocal);
    return notification_Date;
  }
  Future<List<Rec_city>> get_recent() async {
    return await DatabaseService().get_city();
  }
  static AppBar appBarTitle(BuildContext context, String title) {
    return
      AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:ColorFile.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        toolbarHeight: 65,
        elevation: 0.0,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: ColorFile.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              new SizedBox(
                width: 20,
              ),
              Icon(
                Icons.arrow_back_ios,
                color: ColorFile.black,
              ),
            ],
          ),
        ),
        title: Text(
          title,
          style: new TextStyle(
              fontSize: 17, fontFamily: "bold", color: ColorFile.black),
        ),
        actions: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 20,
                ),
                Image.asset("assets/logo.png",height: 30),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ],
      );
  }

  static AppBar appBarcolor(BuildContext context, String title, white,) {
    return
      AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        toolbarHeight: 65,
        elevation: 0.0,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              new SizedBox(
                width: 20,
              ),
              Icon(
                Icons.arrow_back_ios,
                color: ColorFile.white,
              ),
            ],
          ),
        ),
        title: Text(
          title,
          style: new TextStyle(
              fontSize: 17, fontFamily: "bold", color: ColorFile.white),
        ),
        actions: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 20,
                ),
                Image.asset("assets/logo.png",height: 30,color: ColorFile.white,),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ],
      );
  }

  static AppBar appBardashboard(BuildContext context, String title, String? id) {
    return
      AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:ColorFile.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        toolbarHeight: 65,
        elevation: 0.0,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: ColorFile.white,
        leading: InkWell(
          onTap: () {
            if(id==null){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Dashboard()),(Route<dynamic> route) => false);

            }else{
              Navigator.pop(context,"response");
            }

          },
          child: Row(
            children: [
              new SizedBox(
                width: 20,
              ),
              Icon(
                Icons.arrow_back_ios,
                color: ColorFile.black,
              ),
            ],
          ),
        ),
        title: Text(
          title,
          style: new TextStyle(
              fontSize: 17, fontFamily: "bold", color: ColorFile.black),
        ),
        actions: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 20,
                ),
                Image.asset("assets/logo.png",height: 30),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ],
      );
  }





  method_extract(Apartments_Model apartment, Color white) {
    String text = "";
    if (apartment.priceList.length > 0) {
      apartment.priceList.forEach((element) {
        if(!text.contains(element.unit_name))
        text = text + element.unit_name + ", ";
      });
      return new Wrap(
        children: [
          Text(
            text.substring(0, text.length - 2),
            style: new TextStyle(
                fontFamily: "medium", fontSize: 11, color: white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    } else {
      return new Container();
    }
  }

   show_error(BuildContext context,String message) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
            child:Error_Bottom_Sheet(message,onSelectionChanged: (){

            },),
          );
        });

  }


  String desclaimer(){
    String data="Please be aware that the availability of properties listed on the Peprop.Money app is subject to change without prior notice. While we make every effort to ensure that the information provided on our app is accurate and up-to-date, there may be instances where a property is no longer available at the time of booking acceptance by the builder.\n\nIn the event that a booked property becomes unavailable, Peprop.money will notify the user and provide details of a new, comparable unit as an alternative. However, Peprop.money cannot guarantee the availability of any specific property or unit and shall not be held liable for any losses or damages resulting from changes in availability or unavailability of properties.\n\nIt is the user's responsibility to verify the availability of a property with the seller or their authorized representative before completing any transactions. By using the Peprop.money app, users agree to indemnify and hold harmless Peprop.money, its affiliates, and partners from any claims, damages, or losses arising from changes in property availability or discrepancies in property listings.\n\nWe encourage users to perform their due diligence and consult with legal, financial, and real estate professionals before making any decisions or entering into any agreements related to property transactions on the Peprop.Money app.";

    return data;
  }


  static toAst(String message,BuildContext context) {
    return Fluttertoast.showToast(
        msg: message.toString(),
        backgroundColor: ColorFile.bgs,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM ,
        fontSize: 16,
        textColor: ColorFile.black);

  }

  static String convertCurrency(String amount) {
    String currency = "";
    try {
      currency = NumberFormat.compactCurrency(locale: 'en_IN', symbol: '₹ ', decimalDigits: 0).format(double.parse(amount)).toString();
    } catch (e) {}
    return currency;
  }

  String date_time(String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(date);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("hh:mm aa").format(dateLocal);
    return notification_Date;
  }

  static String inventory_time(String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, true);
    var dateLocal = dateTime.toLocal();
    var notification_Date =
    DateFormat("dd MMM yyyy hh:mm aa").format(dateLocal);
    return notification_Date;
  }

  String convert_date2 (String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, false);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("MMMM dd, yyyy").format(dateLocal);
    return notification_Date;
  }

  String yyyy_mm_dd_to_dd_mm_yyyy (String date) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(date, false);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("dd-MM-yyyy").format(dateLocal);
    return notification_Date;
  }
  String convert (String date) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(date, false);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("dd, MMMM yyyy").format(dateLocal);
    return notification_Date;
  }

  String convert_lead_detail_date(String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("dd MMM yyyy").format(dateLocal);
    return notification_Date;
  }
  String convert_lead_detail_time(String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("hh:mm aa").format(dateLocal);
    return notification_Date;
  }

  String convert_date3(String date) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(date, false);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("MMMM dd, yyyy").format(dateLocal);
    return notification_Date;
  }

  String convert_date_forexpiry(String date) {
    try{
      var dateTime = DateFormat("yyyy-MM-dd").parse(date, false);
      var dateLocal = dateTime.toLocal();
      var notification_Date = DateFormat("dd-MM-yyyy").format(dateLocal);
      return notification_Date;
    }catch(e){
      return date;
    }
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  static String visit_Time(String time) {
    var outputFormat = DateFormat('hh:mm').parse(time);
    var outputDate = DateFormat("hh:mm aa").format(outputFormat);
    return outputDate;
  }
  static String parseTimeNew(String time) {
    var outputFormat = DateFormat('hh:mm a').parse(time);
    var outputDate = DateFormat("HH:mm").format(outputFormat);
    return outputDate;
  }


  String parse_Date_time(String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parse(date, false);
    var dateLocal = dateTime.toLocal();
    var notification_Date =
    DateFormat("dd MMM yyyy hh:mm aa").format(dateLocal);
    return notification_Date;
  }

  String parseDataTimeSeconds(String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parse(date, false);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("dd-MM-yyyy").format(dateLocal);
    return notification_Date;
  }

  List<Widget> createChildren(List<String>list,BuildContext context) {
    return new List<Widget>.generate(list.length>5?5:list.length, (int index) {
      return InkWell(child:
      Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child:new Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:list[index].toString(),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>new Container(height: 0,),
                ),
              ),


            ],
          )

      ),onTap: () async {





      },);
    });
  }

  List<Widget> createproduct(List<String>list,String color,BuildContext context) {

    print("color"+color);
    return new List<Widget>.generate(list.length, (int index) {
      return InkWell(child:
      Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child:new Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                child: CachedNetworkImage(

                  placeholder: (context, url) =>Image.asset("assets/loading.png"),
                  imageUrl:list[index].toString(),
                  height: 200,



                  errorWidget: (context, url, error) =>Image.asset(
                    "assets/placeholder.png",
                    height: 220,

                  ),
                ),
              ),



            ],
          )

      ),onTap: () async {





      },);
    });
  }


  static String convert_date(String date) {

    String notification_Date="N/A";
    try{
      var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, false);
      var dateLocal = dateTime.toLocal();
       notification_Date = DateFormat("dd MMM,yyyy").format(dateLocal);
    }catch(e){

    }

    return notification_Date;
  }
  static String convert_yyyy_mm_dd(String date) {


  try{
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, true);
    var dateLocal = dateTime.toLocal();
    var notification_Date = DateFormat("dd MMM,yyyy").format(dateLocal);
    return notification_Date;
  }catch(e){
    return date;

  }

  }

  static String convert_date_time(String date) {
    String notification_Date="";

    if(date.toString()!="null"){
      var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, false);
      var dateLocal = dateTime.toLocal();
      notification_Date = DateFormat("hh:mm aa").format(dateLocal);

    }

    return notification_Date;
  }

  static String server_utc_date_parse(String date) {
    String dates = "N/A";
    try {
      var dateTime = DateFormat("yyyy-MM-dd HH:mm:SS").parse(date,false);
      var dateLocal = dateTime.toLocal();
      var dates = DateFormat("dd-MMM-yyyy hh:mm aa").format(dateLocal);
      return dates;
    } catch (e) {}
    return dates;
  }


  static String getDaysInBeteween(String start_date, String end_date) {
    String start = "N/A";

    String end = "N/A";
    String at = "N/A";


    try {
      var dateTime = DateFormat("yyyy-MM-dd HH:mm:SS").parse(start_date,false);
      var dateLocal = dateTime.toLocal();
      start = DateFormat("dd MMM").format(dateLocal);

      var dateTime1 = DateFormat("yyyy-MM-dd HH:mm:SS").parse(end_date,false);
      var dateLocal1 = dateTime1.toLocal();
      end = DateFormat("dd MMM").format(dateLocal1);

      at = DateFormat("hh:mm aa").format(dateLocal);


      return start+" - "+end+" AT "+at;




    } catch (e) {

    }
    return start+" - "+end+" AT "+at;
  }


  static String server_dd_mm_yyyy(String date) {
    String dates = "N/A";
    try {
      var dateTime = DateFormat("yyyy-MM-dd HH:mm:SS").parse(date,false);
      var dateLocal = dateTime.toLocal();
      var dates = DateFormat("dd-MM-yyyy").format(dateLocal);
      return dates;
    } catch (e) {}
    return dates;
  }
  void launchEmailSubmission(email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  static String utc(String date) {
    String dates = "N/A";
    try {
      var dateTime = DateFormat("dd-MM-yyyy hh:mm:ss aa").parse(date,false);
      var dateLocal = dateTime.toLocal();
      var dates = DateFormat("dd-MMM-yyyy hh:mm aa").format(dateLocal);
      return dates;
    } catch (e) {}
    return dates;
  }

  static String change_date_format(String date) {
    String dates = "";
    try {
      var dateTime = DateFormat("yyyy-MM-dd").parse(date,false);
      var dateLocal = dateTime.toLocal();
      var dates = DateFormat("dd-MM-yyyy").format(dateLocal);
      return dates;
    } catch (e) {}
    return dates;
  }

  static DateTime dates(String date) {
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:SS").parse(date,false);
    return dateTime.toLocal();


  }



  static String utc_dd_mmm_yy(String date) {
    String dates = "N/A";
    try {
      var dateTime = DateFormat("yyyy-MM-dd HH:mm:SS").parse(date,false);
      var dateLocal = dateTime.toLocal();
      var dates = DateFormat("MMM,dd yyyy hh:mm aa").format(dateLocal);
      return dates;
    } catch (e) {}
    return dates;
  }

  static String slot_time(String date) {
    String dates = "N/A";
    try {
      var dateTime = DateFormat("yyyy-MM-dd").parse(date,false);
      var dateLocal = dateTime.toLocal();
      var dates = DateFormat("EEEE").format(dateLocal);
      return dates;
    } catch (e) {}
    return dates;
  }
  static String slot_date(String date) {
    String dates = "N/A";
    try {
      var dateTime = DateFormat("yyyy-MM-dd").parse(date,false);
      var dateLocal = dateTime.toLocal();
      var dates = DateFormat("MMM,dd yyyy").format(dateLocal);
      return dates;
    } catch (e) {}
    return dates;
  }

  static InputDecoration dec(String hint){
    return InputDecoration(
      counterText: "",


      fillColor: ColorFile.bgs, filled: true,
      contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5),
      hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
      hintText: hint,

      border: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.app_color, width: 1.0),
      ),
      errorBorder:  const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),


    );

  }
  static InputDecoration dec_drop(String hint){
    return InputDecoration(
      counterText: "",
      suffixIcon: new Container(child: new Icon(Icons.keyboard_arrow_down_sharp,size: 25,),),

      fillColor: ColorFile.bgs, filled: true,
      contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5),
      hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
      hintText: hint,
      border: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.app_color, width: 1.0),
      ),
      errorBorder:  const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),


    );

  }
  static InputDecoration dec_calender(String hint){
    return InputDecoration(
      counterText: "",
      suffixIcon: new Container(child: new Icon(Icons.calendar_today,size: 25,),),

      fillColor: ColorFile.bgs, filled: true,
      contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5),
      hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
      hintText: hint,
      border: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.app_color, width: 1.0),
      ),
      errorBorder:  const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
      ),


    );

  }
  showProgressDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
              title: Text(
                'Please wait...',
                style: new TextStyle(fontFamily: "medium", fontSize: 15),
              ),
              content: const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: SizedBox(
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )),
                ),
              ));
        });
  }

  static AppBar appBar_points(BuildContext context, String title, String walletBalance) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:ColorFile.white,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      toolbarHeight: 65,
      elevation: 0.0,
      centerTitle: false,
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            new SizedBox(
              width: 20,
            ),
            Icon(
              Icons.arrow_back_ios,
              color: ColorFile.black,
            ),
          ],
        ),
      ),
      title: Text(
        title,
        style: new TextStyle(
            fontSize: 17, fontFamily: "bold", color: ColorFile.black),
      ),
      actions: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new Container(alignment: Alignment.center,height: 30,padding: EdgeInsets.only(left: 25,right: 25),child:new Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.star,color: ColorFile.yellowdark,size: 15,),new SizedBox(width: 5,), new Text(walletBalance.toString(),style: Styles().styles_bold(13, ColorFile.white,),),new SizedBox(width: 5,)],),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),color: ColorFile.app_color),),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  static AppBar appBar(BuildContext context, String title) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:ColorFile.white,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      toolbarHeight: 65,
      elevation: 0.0,
      centerTitle: false,
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            new SizedBox(
              width: 20,
            ),
            Icon(
              Icons.arrow_back_ios,
              color: ColorFile.black,
            ),
          ],
        ),
      ),
      title: Text(
        "Back",
        style: new TextStyle(
            fontSize: 17, fontFamily: "bold", color: ColorFile.black),
      ),
      actions: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 20,
              ),
              Image.asset(
                "assets/logo.png",
                height: 40,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
  Future<String>getDeviceDetails() async {
    String device_id="";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        device_id = build.androidId.toString();
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        device_id = data.identifierForVendor.toString(); //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    return device_id;
  }
  static AppBar webAppBar(BuildContext context, String link) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:ColorFile.white,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      toolbarHeight: 65,
      elevation: 0.0,
      centerTitle: false,
      backgroundColor: ColorFile.white,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            new SizedBox(
              width: 20,
            ),
            Icon(
              Icons.clear,
              color: ColorFile.black,
            ),
          ],
        ),
      ),
      title: Text(
        "peprop.money",
        style: new TextStyle(
            fontSize: 13, fontFamily: "regular", color: ColorFile.app_color),
      ),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                Share.share(link, subject: 'Share this Blog using ...');
              },
              child: Icon(Icons.share,
                color: Colors.black,
                size: 25,),
            ),
            SizedBox(
                width: 20
            ),
          ],
        )
      ],
    );
  }

  static Widget progressBar(bool isLoading) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(
        color: ColorFile.app_color,
        strokeWidth: 3,
      ),
    )
        : Container();
  }


  policy(BuildContext context, String message) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'Policy',
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


 Future<dynamic> check_kyc(BuildContext context) async {
    bool kyc=false;
    AppUtils().showProgressDialog(context);
    Response response=await  ServiceConfig().postApiBodyAuthJson(API.getKYCstatus,new Map(), context);
    Navigator.of(context, rootNavigator: true).pop("Discard");
    if(response!=null &&response.statusCode==200){
      kyc=response.data["kyc_status"];
    }
    return kyc;

  }


}
