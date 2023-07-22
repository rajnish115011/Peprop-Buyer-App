

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Dashboard/GridModel.dart';
import 'package:peprop_consumer_app/Models/BlogModel/BlogModel.dart';
import 'package:peprop_consumer_app/Models/Blog_Tab_Model.dart';
import 'package:peprop_consumer_app/widgets/Dynamic_Blog_Tab.dart';

import '../Models/Dashboard_grid_model.dart';
import 'Dynamic_legal.dart';

class Generate_Grid{
  List<GridModel> getGridItemList() {
    List<GridModel> list =[];
    list.add(new GridModel( imagePath: 'assets/bill/electricity.png',title: "Electricity bill" ,bg: "assets/bg.png"));
    list.add(new GridModel( imagePath: 'assets/bill/water.png',title: "Water Bill",bg: "assets/bg1.png" ));
    list.add(new GridModel( imagePath: 'assets/bill/gas.png',title: "Gas Pipe line" ,bg: "assets/bg2.png"));
    list.add(new GridModel( imagePath: 'assets/bill/loan_repay.png',title: "Loan Re-Payment",bg: "assets/bg.png" ));
    list.add(new GridModel( imagePath: 'assets/bill/broadband.png',title: "Broadband" ,bg: "assets/bg1.png"));
    list.add(new GridModel( imagePath: 'assets/bill/postpaid.png',title: "Postpaid" ,bg: "assets/bg2.png"));
    list.add(new GridModel( imagePath: 'assets/bill/insurance.png',title: "Insurance" ,bg: "assets/bg.png"));
    list.add(new GridModel( imagePath: 'assets/bill/muncipal.png',title: "Muncipal Corporation",bg: "assets/bg1.png" ));
    return list;
  }

  List<String> generate_loan() {
    List<String> list =[];
    list.add("6-12 Months");
    list.add("1-3 Years");
    list.add("3-5 Years");
    list.add("5-10 Years");
    list.add("10+ Years");
    return list;
  }
  List<Dashboard_grid_model> generate_resedential() {
    List<Dashboard_grid_model> list =[];

    list.add(new Dashboard_grid_model("Search", "assets/dashboard/dash_search.png", "assets/bg.png"));
    list.add(new Dashboard_grid_model("New Projects", "assets/dashboard/dash_property.png", "assets/bg1.png"));
    list.add(new Dashboard_grid_model("My Projects", "assets/dashboard/dash_wish.png", "assets/bg2.png"));
    list.add(new Dashboard_grid_model("Book Now", "assets/dashboard/book_now.png", "assets/bg2.png"));
    list.add(new Dashboard_grid_model("My Booking", "assets/dashboard/my_booking.png", "assets/bg2.png"));


    return list;
  }
  List<Dashboard_grid_model> generate_banking() {
    List<Dashboard_grid_model> payments =[];
    payments.add(new Dashboard_grid_model("Banking", "assets/dashboard/dash_bank.png", "assets/bg.png"));
    payments.add(new Dashboard_grid_model("Apply Loan","assets/dashboard/dash_apply.png", "assets/bg1.png"));
    payments.add(new Dashboard_grid_model("My Loan", "assets/dashboard/dash_my_loan.png", "assets/bg2.png"));


    return payments;
  }

  List<Tab> generate_tabs(List<Blog_Tab_Model> blog_list) {
    List<Tab> payments =[];
        blog_list.forEach((element) {
          print(element.name);
        payments.add(Tab(text: element.name));

      });
   return payments;
  }


  List<Dynamic_Blog_Tab> generate_tabs_View(List<Blog_Tab_Model> blog_list, List<AuthorModel> getAuthor, List<BImageModel> getBImage) {
    List<Dynamic_Blog_Tab> payments =[];
    blog_list.forEach((element) {
      payments.add(Dynamic_Blog_Tab(element,getAuthor,getBImage));
    });
    return payments;
  }




  List<String>generate_quanity() {
    List<String> payments =["0.5","1","1.5","2","2.5","3","3.5","4","4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10",
      "10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19","19.5","20",
      "21.5","22","22.5","23","23.5","24","24.5","25","24.5","25","25.5","26","26.5","27","27.5","28","28.5","29","29.5","30",
      "30.5","31","31.5","32","32.5","33","33.5","34","34.5","35","35.5","36","36.5","37","37.5","38","38.5","39","39.5","40",
      "40.5","41","41.5","42","42.5","43","43.5","44","44.5","45","45.5","46","46.5","47","47.5","48","48.5","49","49.5","50"];





    return payments;
  }

  List<String>generate_quanity_int() {
    List<String> payments =["1","2","3","4","5","6","7","8","9","10",
      "11","12","13","14","15","16","17","18","19","20",
      "21","22","23","24","25","26","27","28","29","30",
      "31","32","33","34","35","36","37","38","39","40",
      "41","42","43","44","45","46","47","48","49","50",];





    return payments;
  }

  List<DateTime>dates() {
   List<DateTime>date_list=[];

   for (int i = 2; i < 17; i++) {
     var date = DateTime.now().add(Duration(days: i));
     date_list.add(date);
   }


    return date_list;
  }

  List<Dashboard_grid_model> listing() {
    List<Dashboard_grid_model> payments =[];
    payments.add(new Dashboard_grid_model("Buy", "assets/dashboard/buy.png", "assets/bg.png"));
    payments.add(new Dashboard_grid_model("Sell","assets/dashboard/sell.png", "assets/bg1.png"));
    payments.add(new Dashboard_grid_model("Create Listing", "assets/dashboard/dash_my_loan.png", "assets/bg2.png"));
    return payments;
  }
  List<Dashboard_grid_model> enquiry() {
    List<Dashboard_grid_model> payments =[];
    payments.add(new Dashboard_grid_model("My Enquiry", "assets/dashboard/myenquiry.png", "assets/bg.png"));
    payments.add(new Dashboard_grid_model("My Site Visits","assets/dashboard/mysitevisit.png", "assets/bg1.png"));
    payments.add(new Dashboard_grid_model("Interested Projects", "assets/dashboard/intrestedprojects.png", "assets/bg2.png"));


    return payments;
  }
  List<Dashboard_grid_model> top_cities() {
    List<Dashboard_grid_model> _cityList =[];
    _cityList
        .add(new Dashboard_grid_model("Delhi", 'assets/city/Delhi.jpg', ""));

    _cityList
        .add(new Dashboard_grid_model("Noida", 'assets/city/NOIDA.jpg', ""));

    _cityList.add(
        new Dashboard_grid_model("Gurgaon", 'assets/city/gurgaon1.jpg', ""));

    _cityList
        .add(new Dashboard_grid_model("Mumbai", 'assets/city/MUMBAI.jpg', ""));
    _cityList.add(
        new Dashboard_grid_model("Bangaluru", 'assets/city/BANGLORE.jpg', ""));
    _cityList.add(new Dashboard_grid_model("Pune", 'assets/city/PUNE.jpg', ""));

    _cityList.add(
        new Dashboard_grid_model("Kolkata", 'assets/city/KOLKATA.jpg', ""));

    _cityList.add(
        new Dashboard_grid_model("Chennai", 'assets/city/CHENNAI.jpg', ""));

    _cityList.add(
        new Dashboard_grid_model("Ahmedabad", 'assets/city/Ahmedabad.jpg', ""));

    return _cityList;
  }



}