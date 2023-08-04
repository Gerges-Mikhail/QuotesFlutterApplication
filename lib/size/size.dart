import 'package:flutter/material.dart';
const systemID = 'xS2xTBgEjfW2hKPEn4XKCNncRg72';
double sizeFromHeight(BuildContext context, double fraction,
    {bool hasAppBar = false}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final calculateHeight = (hasAppBar
      ? (screenHeight -
      AppBar().preferredSize.height -
      MediaQuery.of(context).padding.top)
      : screenHeight) /
      fraction;
  return calculateHeight;
}

double sizeFromWidth(BuildContext context, double fraction) {
  final calculateWidth = MediaQuery.of(context).size.width / fraction;
  return calculateWidth;
}