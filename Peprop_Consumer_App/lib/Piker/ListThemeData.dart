import 'package:flutter/material.dart';

class ListThemeData {
  /// The country bottom sheet's background color.
  ///
  /// If null, [backgroundColor] defaults to [BottomSheetThemeData.backgroundColor].
  final Color? backgroundColor;

  ///The style to use for country name text.
  ///
  /// If null, the style will be set to [TextStyle(fontSize: 16)]
  final TextStyle? textStyle;

  ///The flag size.
  ///
  /// If null, set to 25
  final double? flagSize;

  ///The decoration used for the search field
  ///
  /// It defaults to a basic outline-bordered input decoration
  final InputDecoration? inputDecoration;

  ///The border radius of the bottom sheet
  ///
  /// It defaults to 40 for the top-left and top-right values.
  final BorderRadius? borderRadius;

  const ListThemeData({
    this.backgroundColor,
    this.textStyle,
    this.flagSize,
    this.inputDecoration,
    this.borderRadius,
  });
}
