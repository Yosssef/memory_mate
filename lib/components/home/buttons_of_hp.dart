import 'package:flutter/material.dart';

import 'homeC.dart';

class Rowbutton extends StatelessWidget {
  Rowbutton({
    super.key,
    required this.contant1,
    required this.contant2,
    required this.nextW1,
    required this.nextW2,
    required this.icon1,
    required this.icon2,
  });
  String nextW1;
  String nextW2;
  String contant1;
  String contant2;
  String icon1;
  String icon2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HomeC(
          nextw: nextW1,
          icon: icon1,
          contant: contant1,
        ),
        HomeC(
          nextw: nextW2,
          contant: contant2,
          icon: icon2,
        )
      ],
    );
  }
}
