import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Dashboard/GridModel.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

class GridItem1 extends StatelessWidget {
  GridModel gridModel;

  GridItem1(this.gridModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1 / 2),
      child: Container(

        decoration: new BoxDecoration(
          border: new Border.all(width: .025,color: ColorFile.hexblack),   color: Colors.white,
          image: DecorationImage(
            image: AssetImage(gridModel.bg),
            fit: BoxFit.cover,
          ),

        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                gridModel.imagePath,
                width: 30,
                height: 30,

              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  gridModel.title,
                  textAlign: TextAlign.center,
                  style: Styles().styles_regular(10, ColorFile.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
