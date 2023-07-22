

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home_Search extends StatelessWidget{
  Function (String)on_selected;
  Home_Search({required this.on_selected});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFe2d7f5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: TextField(
                onTap: (){
                  on_selected("");
                },
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff7645c7),
                  ),
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                      color: Color(0xff7645c7),
                      fontFamily: "regular",
                      fontSize: 12

                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   width: 50,
          //   alignment: Alignment.center,
          //   child: Stack(
          //     children: <Widget>[
          //       Icon(
          //         Icons.notifications_none,
          //         size: 35,
          //         color: Color(0xff7645c7),
          //       ),
          //       Positioned(
          //         top: -1,
          //         right: 2,
          //         child: Container(
          //           padding: const EdgeInsets.all(4),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Color(0xfffd8c00),
          //           ),
          //           child: Text(
          //             '2',
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 10,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }


}