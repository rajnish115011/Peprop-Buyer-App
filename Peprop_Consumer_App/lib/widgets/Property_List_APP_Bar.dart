


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Listing_Filter_Model.dart';

import '../wish_list/Styles.dart';
class Property_List_APP_Bar extends StatelessWidget implements PreferredSizeWidget {
    Color selected_color=Colors.blue;
  String type="";
  final Function onSelectionChanged;
  final Function(bool) grid_or_list;
   late Listing_Filter_Model model;
  bool filter_type=false;
    bool is_show=false;
    bool list=false;
    Property_List_APP_Bar(bool is_show,Color selected_color,String type,bool filter_type, bool list, Listing_Filter_Model model,{required this.onSelectionChanged,required this.grid_or_list}){
    this.selected_color=selected_color;
    this.type=type;
    this.filter_type=filter_type;
    this.list=list;
    this.model=model;
    this.is_show=is_show;



    }
  @override
  Widget build(BuildContext context) {
        return
      AppBar(
        titleSpacing: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:list==true?selected_color.withOpacity(.9):ColorFile.white,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
        toolbarHeight: 65,elevation: 0.0,centerTitle: false,backgroundColor:Colors.transparent,
         leading:new InkWell(
          onTap: (){
            Navigator.pop(context);
          },child:Icon(Icons.arrow_back_ios,color:list==true? ColorFile.white:ColorFile.black)),
          title: new InkWell(child:   new Row(

        children: [
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_rounded,color: list==true? ColorFile.white:ColorFile.black,size: 15,),
                  new Text(model.city.toString(),style: Styles().styles_regular(12,list==true? ColorFile.white:ColorFile.black),),

                ],
              ),onTap: (){
                onSelectionChanged();
              },)

            ],
          )



        ],
      ),onTap: () async {

      },),



      actions: [
        new InkWell(child:Stack(
          alignment: Alignment.topRight,
          children: [
            new Container(child:Icon(Icons.filter_alt_outlined,color: list==true? ColorFile.white:ColorFile.black,size: 35,),height: 75,),
            if(filter_type==true)new Container(margin: EdgeInsets.only(top: 10),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: list==true? ColorFile.white:ColorFile.black),child: new Icon(Icons.check,color: list==true? ColorFile.black:ColorFile.white,size: 14,),)
          ],),onTap:(){
          onSelectionChanged();
        }),
        new SizedBox(width: 10,),
        if(is_show)InkWell(child: new Container(child:Icon(list==true?Icons.list:Icons.grid_view,color:list==true? ColorFile.white:ColorFile.black,size: 35,),height: 75,),onTap: (){
          list=!list;
          grid_or_list(list);

        },),

          // () async {



        if(is_show)new SizedBox(width: 30,)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
// class Property_List_APP_Bar extends StatelessWidget {
//   Color selected_color=Colors.blue;
//   String type="";
//   final Function onSelectionChanged;
//   bool filter_type=false;
//
//
//   Property_List_APP_Bar(Color selected_color,String type,bool filter_type,{required this.onSelectionChanged}){
//     this.selected_color=selected_color;
//     this.type=type;
//     this.filter_type=filter_type;
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return
//       AppBar(
//
//       titleSpacing: 0,
//       systemOverlayStyle: SystemUiOverlayStyle(
//         statusBarColor:selected_color.withOpacity(.9),
//         statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
//         statusBarBrightness: Brightness.light, // For iOS (dark icons)
//       ),
//       toolbarHeight: 65,elevation: 0.0,centerTitle: false,backgroundColor:Colors.transparent,
//       leading:new InkWell(
//           onTap: (){
//             Navigator.pop(context);
//           },child:Icon(Icons.arrow_back_ios,color: ColorFile.white,)),
//       title: new InkWell(child:   new Row(
//
//         children: [
//           if(type=="1")new Text("Residential Projects",style: new TextStyle(fontSize: 12,fontFamily: "medium"),),
//           if(type=="2")new Text("Commercial Projects",style: new TextStyle(fontSize: 12,fontFamily: "medium"),),
//
//
//         ],
//       ),onTap: () async {
//
//       },),
//
//
//
//       actions: [
//         new InkWell(child:Stack(
//           alignment: Alignment.topRight,
//           children: [
//             new Container(child:Icon(Icons.filter_alt_outlined,color: ColorFile.white,size: 35,),height: 75,),
//             if(filter_type==true)new Container(margin: EdgeInsets.only(top: 10),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),color: ColorFile.white),child: new Icon(Icons.check,color: ColorFile.black,size: 14,),)
//           ],),onTap:onSelectionChanged()),
//
//           // () async {
//           //   // var get_res=await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>All_Projects_Filter(widget.model)));
//           //   // if(get_res!=null){
//           //   //   setState(() {
//           //   //     widget.model=get_res;
//           //   //
//           //   //     synch=false;
//           //   //     loading=true;
//           //   //     Apartments.clear();
//           //   //     get_properties();
//           //   //   });
//           //
//           //   }
//
//
//
//         new SizedBox(width: 30,)
//       ],
//     );
//   }
//
//
// }