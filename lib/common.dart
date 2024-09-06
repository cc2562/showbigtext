

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Global{
  static String showText ="输入显示的文字";
  static double playSpeed = 100;
  static double showTextSize = 18.sp;
  static Color backColor = Colors.black;
  static Color textColor = Colors.white;
  static bool showPlay =true;

  static saveText(String text){
    showText = text;
  }

  static savePlaySpeed(double speed){
    playSpeed = speed;
  }

  static saveTextSize(double size){
    showTextSize = size;
  }

}