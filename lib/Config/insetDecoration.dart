import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import '../Config/Color.dart';

class dec {
  BoxDecoration insetdeco({radius, color, basecolor}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
        boxShadow: [
          BoxShadow(
              blurRadius: 5.0,
              offset: -Offset(9, 9),
              color: basecolor == mycolor().lightBlack
                  ? Color.fromRGBO(56, 56, 56, 0.68)
                  : Color.fromRGBO(255, 255, 255, 0.68),
              inset: true),
          BoxShadow(
              blurRadius: 5.0,
              offset: Offset(9, 9),
              color: Color.fromRGBO(0, 0, 0, 0.35),
              inset: true),
          BoxShadow(
              blurRadius: 5.0,
              offset: -Offset(9, 9),
              color: basecolor == mycolor().lightBlack
                  ? Color.fromRGBO(56, 56, 56, 0.68)
                  : Color.fromRGBO(255, 255, 255, 0.68),
              inset: true),
        ]);
  }
}
