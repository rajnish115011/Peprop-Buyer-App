import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Color/ColorFile.dart';
import '../Utils/AppUtils.dart';

class Broker_RM_Chat extends StatefulWidget{
    String rm_name="";
    String rm_mobile="";
    String user_mobile="";
    Broker_RM_Chat(String rm_name, String rm_mobile, String user_mobile){
    this.rm_name=rm_name;
    this.rm_mobile=rm_mobile;
    this.user_mobile=user_mobile;

  }








  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }
  
}

class BuildState extends State<Broker_RM_Chat>{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
   ScrollController scrollController = ScrollController();
   String userName="";
   List<Widget>list=[];
   String user_mobile="";
   @override
   void initState() {

     WidgetsBinding.instance!.addPostFrameCallback((_) {
       get_user_id();


     });

     super.initState();
   }

   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SafeArea(top:false,child: new Scaffold(
      backgroundColor: ColorFile.lead_widget_color,
      appBar:new AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        backgroundColor: ColorFile.white,
        elevation: 0,
        leadingWidth: 1,
        leading: new Container(width: 1,),
        title:new Container(child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(onTap: (){
                Navigator.pop(context);
              },child: new Row(children: [
                Icon(Icons.arrow_back,color: ColorFile.black,),
                new SizedBox(width: 10,),
              ],),),

              new Container(
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(100),
                    color: ColorFile.drawer

                ),
                height: 40,
                width: 40,
                child: new Text(widget.rm_name.toString().substring(0,1).toUpperCase(),style: new TextStyle(fontFamily: "bold",color: ColorFile.white,fontSize: 22),),
              ),
              new SizedBox(width: 10,),
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(widget.rm_name.toString(),style: new TextStyle(fontFamily: "bold",fontSize: 13,color: ColorFile.black),),

                ],
              ),
            ],
          ))
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 5),
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection("RMBased_Chat").doc(widget.user_mobile.toString()).collection(widget.user_mobile.toString()).orderBy("timestamp").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null&&snapshot!=null) {
                      List<DocumentSnapshot> docs = snapshot.data!.docs;
                      method();

                      return ListView.builder(
                        controller:scrollController,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          String date="";



                          if(docs[index].get("sentto")==widget.user_mobile){
                            docs[index].reference.update(<String, dynamic>{
                              "unread": 0
                            });
                          }

                          try{
                            Timestamp t = docs[index].get("timestamp");
                            DateTime d = t.toDate();
                            date=AppUtils().firebase_date_time(d.toString());
                          }catch(e){

                          }
                          return
                            widget.user_mobile==docs[index].get("sentby")&&widget.rm_mobile==docs[index].get("sentto")||
                                widget.user_mobile==docs[index].get("sentto")&&widget.rm_mobile==docs[index].get("sentby")?
                           new Container(
                             padding: EdgeInsets.all(10),
                             child: new Column(
                             children: [docs[index].get("sentby")==widget.user_mobile?
                                 Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                   Column(crossAxisAlignment: CrossAxisAlignment.end,
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: <Widget>[
                                   Container(
                                   constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
                                   padding: const EdgeInsets.all(15.0),
                                   decoration: BoxDecoration(
                                     color:ColorFile.green,
                                     borderRadius: BorderRadius.only(
                                       topLeft: Radius.circular(25),
                                       topRight: Radius.circular(25),
                                       bottomLeft: Radius.circular(25),
                                     ),
                                   ),
                                     child: Text(docs[index].get("text"),style: new TextStyle(fontFamily: "regular",color:ColorFile.white,fontSize: 14),),
                                 ),
                                     new SizedBox(height: 5,),
                                     new Text(date,textAlign: TextAlign.right,style: new TextStyle(fontFamily: "regular",color:ColorFile.hint_color,fontSize: 12),)



                                   ])])
                                 :
                                 //reciver
                                 Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: <Widget>[
                                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.start,

                                       children: <Widget>[
                                         Container(
                                           constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
                                           padding: const EdgeInsets.all(15.0),
                                           decoration: BoxDecoration(
                                             color:ColorFile.white,
                                             borderRadius: BorderRadius.only(
                                               bottomRight: Radius.circular(25),
                                               topRight: Radius.circular(25),
                                               bottomLeft: Radius.circular(25),
                                             ),
                                           ),
                                           child: Text(docs[index].get("text"),style: new TextStyle(fontFamily: "regular",color:ColorFile.black,fontSize: 14),),
                                         ),
                                         new SizedBox(height: 5,),
                                         new Text(date,textAlign: TextAlign.start,style: new TextStyle(fontFamily: "regular",color:ColorFile.hint_color,fontSize: 12),)


                                       ])])
                               ],
                             ),



                         ):new Container();
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
            child: new Row(
              children: [
                Expanded(child: new Container(child: Card(
                  color: ColorFile.white,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50)
                  ),
                  child:Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 10,top: 5,bottom: 5),
                          child: TextField(
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                            onSubmitted: (value) => sendChat(),
                            controller: messageController,
                            decoration: InputDecoration(

                              hintText: "Type a message",

                              hintStyle:
                              TextStyle(fontFamily: 'Montserrat', fontSize: 12),
                                border:  InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder:InputBorder.none,
                                disabledBorder:InputBorder.none
                            ),
                          ),
                        ),
                      ),

                      new Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Icon(Icons.attach_file),
                      )


                    ],
                  ),



                ),),),

                new GestureDetector(
                  onTap: (){
                    sendChat();
                  },
                  child: new Card(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100)
                    ),
                    elevation: 3,
                    color: ColorFile.yellow_700,
                    child: new Container(
                      padding: EdgeInsets.all(15),
                      height: 60,
                      width: 60,
                      child: new Image.asset("assets/chats.png"),
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),



    ));

  }
  Future<void> sendChat() async {
    if (messageController.text.length > 0) {
      await _firestore.collection("RMBased_Chat").doc(widget.user_mobile).collection(widget.user_mobile).add({
          'text': messageController.text,
          'type': "text",
          'timestamp': FieldValue.serverTimestamp(),
          'sentby': widget.user_mobile.toString(),
          'sentto': widget.rm_mobile.toString(),
          'unread': 1,
      });
      setState(() {
        messageController.clear();
      });
      scrollController.animateTo(scrollController.position.maxScrollExtent,duration: Duration(milliseconds: 1), curve: Curves.easeOut);


    }
  }
     method(){
     try{
      scrollController.animateTo(scrollController.position.maxScrollExtent,duration: Duration(milliseconds: 50), curve: Curves.easeOut);
    }catch(e){

    }
  }

  Future<void> get_user_id() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user_mobile=sharedPreferences.getString("mobile").toString();
  }

}