import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';

class yourlocatiocard extends StatelessWidget {
  const yourlocatiocard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        'map',
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Container(
          width: screenWidth,
          decoration: const BoxDecoration(
            color: KPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Container(
                  height: screenHeight * 0.18,
                  width: screenWidth * 0.25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/locations/location-map-2956.png'))),
                ),
              ),
              Text(
                'your location now',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
