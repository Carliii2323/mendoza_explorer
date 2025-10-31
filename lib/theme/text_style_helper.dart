import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline24SemiBoldPoppins => TextStyle(
    fontSize: 24.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: appTheme.black_900,
  );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
    fontSize: 20.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
  );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body13SemiBoldPoppins => TextStyle(
    fontSize: 13.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
  );

  // Label Styles
  // Small text styles for labels, captions, and hints

  TextStyle get label10SemiBoldPoppins => TextStyle(
    fontSize: 10.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: appTheme.black_900,
  );

  TextStyle get label10RegularPoppins => TextStyle(
    fontSize: 10.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: appTheme.black_900,
  );

  TextStyle get label10MediumPoppins => TextStyle(
    fontSize: 10.fSize,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: appTheme.gray_600,
  );
}
