

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';

class Dashboard_floating extends StatelessWidget{
  late AnimationController _animationController;
  late Animation<double> animation;
  Function(String)onselected;
  Dashboard_floating(AnimationController _animationController, Animation<double> animation,{required this.onselected}){
    this._animationController=_animationController;
    this.animation=animation;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  FloatingActionBubble(
      // Menu items
      items: <Bubble>[
        Bubble(
          title:"Buy",
          iconColor :Colors.white,
          bubbleColor : ColorFile.app_color,
          icon:Icons.bubble_chart,
          titleStyle:TextStyle(fontSize: 14 , color: Colors.white,fontFamily: "medium"),
          onPress: () {
            onselected("1");
            _animationController.reverse();
          },
        ),
        // Floating action menu item
        Bubble(
          title:"Sell",
          iconColor :Colors.white,
          bubbleColor : ColorFile.app_color,
          icon:Icons.bubble_chart,
          titleStyle:TextStyle(fontSize: 14 , color: Colors.white,fontFamily: "medium"),
          onPress: () {
            onselected("2");
            _animationController.reverse();
          },
        ),
        //Floating action menu item

      ],

      // animation controller
      animation: animation,

      // On pressed change animation state
      onPress: () => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),

      // Floating Action button Icon color
      iconColor: Colors.white,

      iconData: Icons.add,
      backGroundColor: ColorFile.app_color,
    );
  }



}