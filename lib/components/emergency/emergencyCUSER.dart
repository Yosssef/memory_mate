// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';

import 'emergencyC.dart';

class number {
  final String numberr;
  final String name;
  number(this.numberr, this.name);
  factory number.fromjson(Map<String, dynamic> jsondata) {
    return number(jsondata['res number'], jsondata['resname']);
  }
}

class EmergabcyCUSER extends StatelessWidget {
  EmergabcyCUSER({super.key, required this.user});
  number? user;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenHeight = screenSize.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          makePhoneCall(
            user!.numberr,
          );
        },
        child: Container(
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.blue.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenHeight * 0.1,
                width: screenHeight * 0.1,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/user.png'),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      user!.name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: KSecondaryColor.withOpacity(0.3)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      user!.numberr,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: KSecondaryColor.withOpacity(0.3)),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
