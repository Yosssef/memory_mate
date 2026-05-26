// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';

class Userask extends StatelessWidget {
  Userask({super.key, required this.mes});
  String mes;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(
            left: screenHeight * 0.04,
            right: screenHeight * 0.04,
            top: screenHeight * 0.02,
            bottom: screenHeight * 0.02),
        margin: EdgeInsets.all(screenHeight * 0.01),
        decoration: BoxDecoration(
            color: KPrimaryColor.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        child: Text(
          mes,
          style: TextStyle(
              fontSize: screenHeight * 0.025,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}

class Memoriaanswer extends StatelessWidget {
  Memoriaanswer({super.key, required this.res});
  String res;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: EdgeInsets.only(
            left: screenHeight * 0.04,
            right: screenHeight * 0.04,
            top: screenHeight * 0.02,
            bottom: screenHeight * 0.02),
        margin: EdgeInsets.all(screenHeight * 0.02),
        decoration: BoxDecoration(
            color: KSecondaryColor.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16))),
        child: Text(
          res,
          style: TextStyle(
              fontSize: screenHeight * 0.025,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
