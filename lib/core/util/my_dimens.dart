import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:flutter/material.dart';

class MyDimens {
  static const cmDivider = Divider(color: MyColor.inActiveColor, thickness: .5);
  
  static const loginGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [MyColor.logGradient1Color, MyColor.logGradient2Color],
  );
}
