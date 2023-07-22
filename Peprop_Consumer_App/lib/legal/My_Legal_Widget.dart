

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../Color/ColorFile.dart';
import '../Models/My_Legal_Enquiry_Model.dart';
import '../widgets/MyVerticalText.dart';
import '../wish_list/Styles.dart';

class My_Legal_Widget extends StatelessWidget{

  My_Legal_Enquiry_Model? model;
  Function () edit;


  My_Legal_Widget(My_Legal_Enquiry_Model? model,{required this.edit}){
    this.model=model;



  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 20,left: 10,right: 10),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.white),
      child: Container(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10),
            color:model!.status.toString()=="0"? ColorFile.greens: ColorFile.app_color
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 5,right: 5,top: 20,bottom: 20),child: new MyVerticalText(model!.status.toString()=="0"?"Active":"Closed"), decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),),
            Expanded(child: new Container(
              decoration: new BoxDecoration(borderRadius:new BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.white),

              child:
              new Column(
                children: [
                  new Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                    child: new Column(
                      children: [
                        new Container(child: new Row(children: [
                          Expanded(child: new Container(child: new Row(
                            children: [
                              Expanded(child: new Container(child:new Text("" + "Name : "+model!.full_name.toString(),style: new TextStyle(fontFamily: "semi", fontSize: 16, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),

                            ],
                          ),)),



                        ],),),

                        new SizedBox(height: 10,),
                        if(model!.type=="1")new Container(child: new Row(children: [
                          Expanded(child: new Container(child: new Row(
                            children: [
                              Expanded(child: new Container(child:new Text("Advice For : "+" Buy",style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                            ],
                          ),)),



                        ],),),
                        if(model!.type=="2")new Container(child: new Row(children: [
                          Expanded(child: new Container(child: new Row(
                            children: [
                              Expanded(child: new Container(child:new Text("Advice For : "+" Sale",style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                            ],
                          ),)),



                        ],),),
                        if(model!.type=="3")new Container(child: new Row(children: [
                          Expanded(child: new Container(child: new Row(
                            children: [
                              Expanded(child: new Container(child:new Text("Advice For : "+" Rent",style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                            ],
                          ),)),



                        ],),),
                        if(model!.type=="4")new Container(child: new Row(children: [
                          Expanded(child: new Container(child: new Row(
                            children: [
                              Expanded(child: new Container(child:new Text("Advice For : "+" Other",style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                            ],
                          ),)),



                        ],),),


                        new SizedBox(height: 10,),
                        new Container(child: new Row(children: [
                          Expanded(child: new Container(child: new Row(
                            children: [
                              Expanded(child: new Container(child:new Text("Mobile : "+model!.mobile.toString(),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                            ],
                          ),)),



                        ],),),

                        new SizedBox(height: 10,),
                        new Container(child: new Row(children: [
                          Expanded(child: new Container(child: new Row(
                            children: [
                              Expanded(child: new Container(child:new Text("Project : "+model!.property_name.toString(),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                            ],
                          ),)),



                        ],),),




                        new SizedBox(height: 10,),
                        new Container(child: new Row(children: [
                          Expanded(child: new Container(child: new Row(
                            children: [
                              Expanded(child: new Container(child:new Text("Reason : "+model!.reason.toString(),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                            ],
                          ),)),



                        ],),),





                        new SizedBox(height: 10,),
                        new Container(child: new Row(children: [
                          Expanded(child: new Container(child: new Row(
                            children: [
                              Expanded(child: new Container(child:new Text("Slot : "+model!.slot.toString(),style: new TextStyle(fontFamily: "medium", fontSize: 14, color: ColorFile.red_900),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                            ],
                          ),)),



                        ],),),

                        new SizedBox(height: 10,),
                        new Container(child: new Row(
                          children: [
                            Expanded(child:new Container(child: new Row(children: [
                              Icon(Icons.calendar_today,size: 15,),
                              new SizedBox(width: 10,),
                              new Container(child:new Text(AppUtils.slot_date(model!.date.toString()),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)
                            ],),)),
                            Expanded(child:new Container(child: new Row(children: [
                              Icon(Icons.watch_later_outlined,size: 15,),
                              new SizedBox(width: 10,),
                              new Container(child:new Text(AppUtils.slot_time(model!.date.toString()),style: new TextStyle(fontFamily: "regular", fontSize: 14, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)
                            ],),)),

                          ],
                        ),)

                      ],
                    ),
                  ),
                  new InkWell(child: new Container(height: 50,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(0),bottomRight: Radius.circular(10)),color: ColorFile.yellowdark),child:new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Icon(Icons.edit,color: ColorFile.white,),
                      new SizedBox(width: 10,),
                      new Text("Edit",style: Styles().styles_bold(16, ColorFile.white),)
                    ],),),onTap: (){
                     edit();

                    },)


                ],
              ),
            ))
          ],
        ),
      ),);
  }

}
