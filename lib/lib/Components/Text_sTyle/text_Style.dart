import 'package:flutter/material.dart';
import 'package:music_app_2/lib/Components/Colors/Colors.dart';


const bold = 'bold';
const regular = 'regular';


ourStyle({family = 'regular',double? size = 20,color = whiteColor}) {

  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family
  );
}