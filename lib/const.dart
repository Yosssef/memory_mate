// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const Color KPrimaryColor = Color.fromARGB(255, 33, 149, 243);
const Color KSecondaryColor = Color.fromARGB(255, 166, 76, 199);
const Knotes = 'nots_box';
const Coordinates = 'Coordinates';

// ignore: camel_case_types
class constnumbers {
  String? name;
  String? number;
  constnumbers({required this.name, required this.number});
}

class Apptittel extends StatelessWidget {
  const Apptittel({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Memory',
              style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Mate',
              style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: KSecondaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          'HERE TO HELP',
          style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.white,
              fontWeight: FontWeight.w800),
        )
      ],
    );
  }
}
