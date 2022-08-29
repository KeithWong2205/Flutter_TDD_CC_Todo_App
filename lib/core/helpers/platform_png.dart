import 'package:flutter/material.dart';

class PlatformPng {
  static Widget asset(
    String assetName, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    alignment = Alignment.center,
    String? semanticsLabel,
  }) {
    var assetsImage = AssetImage('assets/image/$assetName.png');
    return Image(
      filterQuality: FilterQuality.high,
      image: assetsImage,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      semanticLabel: semanticsLabel,
    );
  }
}
