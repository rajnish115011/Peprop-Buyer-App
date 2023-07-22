


import 'package:flutter/cupertino.dart';

class Success_Dialog {
 late BuildContext context;
 Function ()onclick;
  Success_Dialog(BuildContext context,{required this.onclick}){
    this.context=context;

  }

  show_dialog(){
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              "Success",
              style: new TextStyle(fontFamily: "medium", fontSize: 15),
            ),
            content: Text(
              "Your Password Changed Successfully..!!",
              style: new TextStyle(fontFamily: "regular", fontSize: 12),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(ctx);
                  onclick();
                },
                child: Text(
                  'OK',
                  style: new TextStyle(fontFamily: "medium", fontSize: 15),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),

            ],
          );
        });

  }

}