import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';

class HomeC extends StatefulWidget {
  HomeC({
    super.key,
    required this.contant,
    this.ontap,
    required this.icon,
    required this.nextw,
  });
  final String contant;
  final String icon;
  final VoidCallback? ontap;
  final String nextw;

  @override
  State<HomeC> createState() => _HomeCState();
}

class _HomeCState extends State<HomeC> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, widget.nextw);
        },
        child: Container(
          width: screenWidth * 0.38,
          height: screenHeight * 0.22,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * .01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenHeight * 0.125,
                  width: screenWidth * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.icon), fit: BoxFit.fill)),
                ),
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.001),
                child: Center(
                  child: Text(
                    widget.contant,
                    style: TextStyle(
                        color: KSecondaryColor.withOpacity(0.5),
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
