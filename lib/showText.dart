import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'common.dart';
Widget showMarr(){
  return Marquee( text: Global.showText,
    style: TextStyle(fontWeight: FontWeight.bold,fontSize: Global.showTextSize,color: Global.textColor),
    scrollAxis: Axis.horizontal,
    velocity: Global.playSpeed,
    blankSpace: 25,
  );
}
Widget showTextlin(context,type){
  double hee = MediaQuery.of(context).padding.top;
  double ri = 3.w;
  if(type == 1){
    ri = 3.w+hee;
  }
  return Padding(padding: EdgeInsets.fromLTRB(ri, 0, 3.w, 0),child: SingleChildScrollView(
    child: Text(Global.showText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: Global.showTextSize,color: Global.textColor),),
  ),);
}