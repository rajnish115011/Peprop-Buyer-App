import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';
import '../Models/Dashboard_grid_model.dart';
import '../wish_list/Styles.dart';

class GridItem extends StatelessWidget {
  Dashboard_grid_model gridModel;

  GridItem(this.gridModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1 / 2),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                gridModel.path,
                width: 30,
                height: 30,

              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  gridModel.name,
                  textAlign: TextAlign.center,
                  style:Styles().styles_regular(13, ColorFile.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
