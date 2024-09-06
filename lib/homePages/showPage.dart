import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:marquee/marquee.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showbigtext/common.dart';

import '../showText.dart';

class showPageView extends StatefulWidget {
  const showPageView({super.key});

  @override
  State<showPageView> createState() => _inputPageViewState();
}
ValueNotifier<String> _myString = ValueNotifier<String>('Yes');
// create some values
Color pickerColor = Colors.black;
Color pickerTextColor = Colors.white;
class _inputPageViewState extends State<showPageView> {
  double textSizeShow=Global.showTextSize;
  int showType=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myString.addListener((){
      setState(() {
        Global.showTextSize = Global.showTextSize;
        Global.playSpeed = Global.playSpeed;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Global.backColor,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          RotatedBox(
            quarterTurns: showType,
            child: Container(
              alignment: Alignment.center,
              child: Global.showPlay?showMarr():showTextlin(context,showType),

            ),),
          IconButton(onPressed: (){
            setState(() {
              print("111");
              showType=showType==0?1:0;
            });
          }, icon: Icon(Icons.screen_rotation)),
        ],
      ),
    );
  }
}


