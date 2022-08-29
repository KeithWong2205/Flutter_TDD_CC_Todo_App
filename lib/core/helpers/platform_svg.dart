import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlatformSvg {
  static Widget asset(
    String assetName, {
    double width = 40.0,
    double height = 40.0,
    BoxFit fit = BoxFit.contain,
    Color? color,
    alignment = Alignment.center,
    String semanticsLabel = '',
  }) {
    return SvgPicture.asset(
      'assets/image/$assetName.svg',
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
    );
  }
}
