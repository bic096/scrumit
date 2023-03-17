import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  debugPrint('Size = ${MediaQuery.of(context).size}');
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ${MediaQuery.of(context).size.height}');
  return MediaQuery.of(context).size.height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ${MediaQuery.of(context).size.width}');
  return MediaQuery.of(context).size.width;
}

double displayPixlRatio(BuildContext context) {
  debugPrint('devicePixelRatio = ${MediaQuery.of(context).devicePixelRatio}');
  return MediaQuery.of(context).devicePixelRatio;
}

double displayWidthPixlsNum(BuildContext context) {
  debugPrint('devicePixelRatio = ${MediaQuery.of(context).devicePixelRatio}');
  return MediaQuery.of(context).size.width *
      MediaQuery.of(context).devicePixelRatio;
}

double displayHeightPixlsNum(BuildContext context) {
  debugPrint('devicePixelRatio = ${MediaQuery.of(context).devicePixelRatio}');
  return MediaQuery.of(context).size.height *
      MediaQuery.of(context).devicePixelRatio;
}
