import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:marquee/marquee.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showbigtext/common.dart';
import 'package:showbigtext/showText.dart';

class inputPageView extends StatefulWidget {
  const inputPageView({super.key});

  @override
  State<inputPageView> createState() => _inputPageViewState();
}
ValueNotifier<String> _myString = ValueNotifier<String>('Yes');
// create some values
Color pickerColor = Colors.black;
Color pickerTextColor = Colors.white;
class _inputPageViewState extends State<inputPageView> {
  double textSizeShow=Global.showTextSize;

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
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 100.w,
            alignment: Alignment.center,
            child: Global.showPlay?showMarr():showTextlin(context,0),
          ),
          Container(
            width: 100.w,
            height: 10.h,
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 2.h),
              padding: EdgeInsets.fromLTRB(3.w, 1.h, 3.w, 1.h),
              width: 100.w,
              height: 8.h,
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Container(
                    width: 75.w,
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: "输入显示的文字",
                          labelText: "输入显示的文字",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      onChanged: (str){
                          setState(() {
                            if(str.isEmpty){
                              Global.showText = "输入显示的文字";
                              return;
                            }
                            Global.showText = str;
                          });
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: (){
                        showBarModalBottomSheet(context: context,
                            expand: false,
                            builder: (context){
                          return SettingPage();
                            }
                        );
                      },
                    )
                  )
                ],
              )
            ),
          )
        ],
      )
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController sizeCon = TextEditingController();
  TextEditingController speedCon = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sizeCon.text = Global.showTextSize.toStringAsFixed(0);
    speedCon.text = Global.playSpeed.toStringAsFixed(0);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
      width: 100.w,
      height: 43.h,
      color: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          ListTile(
            title: Text("字体大小"),
            leading: Icon(Icons.text_fields),
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Slider(
                  value: Global.showTextSize,
                  onChanged: (v){
                    print(v);
                    setState(() {
                      Global.saveTextSize(v);
                      sizeCon.text = Global.showTextSize.toStringAsFixed(0);
                      _myString.value = Global.showTextSize.toStringAsFixed(0);
                    });
                  },
                  min: 1,
                  max: 500,

                  label:  Global.showTextSize.toStringAsFixed(0),
                ),
                flex: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: sizeCon,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    enabled: false,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: Text("是否滚动"),
            leading: Icon(Icons.roller_skating),
            trailing: Switch(value: Global.showPlay, onChanged: (bool value) {setState(() {
              Global.showPlay = value;
              _myString.value =value.toString();
            }); },),
          ),
          Visibility(
            visible: Global.showPlay,
            child: ListTile(
              title: Text("滚动速度"),
            ),
          ),
          Visibility(
            visible: Global.showPlay,
            child:Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Slider(
                    value: Global.playSpeed,
                    onChanged: (v){
                      print(v);
                      setState(() {
                        Global.savePlaySpeed(v);
                        speedCon.text = Global.playSpeed.toStringAsFixed(0);
                        _myString.value = Global.playSpeed.toStringAsFixed(1);
                      });
                    },
                    min: 100,
                    max: 1000,
                    divisions: 899,
                    label:  Global.playSpeed.toStringAsFixed(0),
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: TextField(
                      controller: speedCon,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      enabled: false,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            title: Text("背景颜色"),
            leading: Icon(Icons.color_lens),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              showDialog(
                context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (v){
                          setState(() {
                            pickerColor = v;
                          });
                        },
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Got it'),
                        onPressed: () {
                          setState((){
                            Global.backColor = pickerColor;
                            _myString.value =pickerColor.toString();
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
              },

              );
            },
          ),
          ListTile(
            title: Text("文本颜色"),
            leading: Icon(Icons.format_color_text),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              showDialog(
                context: context, builder: (BuildContext context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: pickerTextColor,
                      onColorChanged: (v){
                        setState(() {
                          pickerTextColor = v;
                        });
                      },
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        setState((){
                          Global.textColor= pickerTextColor;
                          _myString.value =pickerTextColor.toString();
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },

              );
            },
          ),
        ],
      ),
    );
  }
}

