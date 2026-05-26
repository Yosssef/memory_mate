// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

class Emergencycon {
  String image;
  String name;
  String number;
  Emergencycon({required this.image, required this.name, required this.number});
}

// ignore: must_be_immutable
class EmergencyC extends StatelessWidget {
  EmergencyC({super.key, required this.type});
  Emergencycon type;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          makePhoneCall(type.number);
        },
        child: Container(
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
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: screenHeight * 0.12,
                width: screenWidth * 0.26,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(type.image), fit: BoxFit.cover)),
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
                      type.name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: KSecondaryColor.withOpacity(0.3)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      type.number,
                      style: TextStyle(
                          fontSize: 24,
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
