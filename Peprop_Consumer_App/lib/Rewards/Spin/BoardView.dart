

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Campaign_Model.dart';
import 'package:peprop_consumer_app/Rewards/Spin/Luck.dart';
import 'package:peprop_consumer_app/widgets/MyVerticalText.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import 'ArrowView.dart';



class BoardView extends StatefulWidget {
  final double angle;
  final double current;
  final String reward;

  final List<Partitions> items;

  const BoardView({Key? key, required this.angle, required this.current, required this.items, required this.reward})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BoardViewState();
  }
}

class _BoardViewState extends State<BoardView> {
  Size get size => Size(MediaQuery.of(context).size.width * 0.8,MediaQuery.of(context).size.width * 0.8);

  double _rotote(int index) => (index / widget.items.length) * 2 * pi;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,

      children: <Widget>[
        //shadow
        new Container(
          height: size.height+15,
          width: size.width+15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: new Border.all(width: 10,color: ColorFile.black),



          ),

          child: Container(
          height: size.height,
          width: size.width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(width: 5,color: ColorFile.yellowdark),
              boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black38)]),
        ),),
        Transform.rotate(
          angle: -(widget.current + widget.angle) * 2 * pi,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              for (var luck in widget.items) ...[_buildCard(luck)],
              for (var luck in widget.items) ...[_buildImage(luck)],




            ],
          ),
        ),
        Container(
          height: size.height,
          width: size.width,
          child: ArrowView(),
        ),
      ],
    );
  }

  _buildCard(Partitions luck) {
    
    var cor="0xFF"+luck.partition_bgcolor;
    var _rotate = _rotote(widget.items.indexOf(luck));
    var _angle = 2 * pi / widget.items.length;

    return Transform.rotate(
      angle: _rotate,
      child: ClipPath(
        clipper: _LuckPath(_angle),
        child:Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              border: new Border.all(width: 1,color: ColorFile.app_color),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(int.parse(cor)), Color(int.parse(cor)).withOpacity(0)])),


        ),

      ),
    );
  }

  _buildImage(Partitions luck) {
    var _rotate = _rotote(widget.items.indexOf(luck));


    return Transform.rotate(
      angle: _rotate,
      child:
      Container(
        padding: EdgeInsets.only(top: 10),
        height: size.height,
        width: size.width,
        alignment: Alignment.topCenter,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              new Container(child:ConstrainedBox(constraints:BoxConstraints.expand(height: size.height / 3, width: 44),child: new MyVerticalText(luck.partition_points.toString()+" "+widget.reward),), )
          ],
        )


      ),
    );
  }

  build_Run(Partitions luck) {
    var _rotate = _rotote(widget.items.indexOf(luck));
    var _angle = 2 * pi / widget.items.length;

    return Transform.rotate(
        angle: _rotate,child: new Text("data"),);


  }
}

class _LuckPath extends CustomClipper<Path> {
  final double angle;

  _LuckPath(this.angle);

  @override
  Path getClip(Size size) {
    Path _path = Path();
    Offset _center = size.center(Offset.zero);
    Rect _rect = Rect.fromCircle(center: _center, radius: size.width / 2);
    _path.moveTo(_center.dx, _center.dy);
    _path.arcTo(_rect, -pi / 2 - angle / 2, angle, false);
    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(_LuckPath oldClipper) {
    return angle != oldClipper.angle;
  }
}