import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';
import 'package:memory_mate/models/locationmodel.dart';

import '../../views/maps/mpas_test.dart';

// ignore: must_be_immutable
class Youraddedlocatiocard extends StatefulWidget {
  Youraddedlocatiocard({super.key, required this.locationinfo});
  Locationsofuser locationinfo;

  @override
  State<Youraddedlocatiocard> createState() => _YouraddedlocatiocardState();
}

class _YouraddedlocatiocardState extends State<Youraddedlocatiocard> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Mapsforlocations(
                thislocation: widget.locationinfo,
              );
            }));
          },
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Container(
              width: screenWidth * 0.8,
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
                      width: screenWidth * 0.2,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/locations/office-building (1).png'))),
                    ),
                  ),
                  Text(
                    widget.locationinfo.nameoflocation,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              confirmdelet(context, widget.locationinfo);
            },
            icon: Icon(
              Icons.delete,
              size: screenWidth * 0.08,
              color: Colors.redAccent,
            ))
      ],
    );
  }

  void confirmdelet(BuildContext context, Locationsofuser loc) async {
    String name = loc.nameoflocation;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black.withOpacity(0.8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.7,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                    child: Text(
                      textAlign: TextAlign.center,
                      'are sure you want to delet $name from your locations ',
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: KSecondaryColor),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.02),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              loc.delete();
                              Navigator.pop(context, 'mapsask');
                              Navigator.pushReplacementNamed(
                                  context, 'mapsask');

                              scaffolmessenger(context, 'deleted scssful');
                            } catch (e) {
                              scaffolmessenger(
                                  context, 'error while delet try agin later');
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: Text(
                              'yes',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.06,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.015),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.12,
                            child: const VerticalDivider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'no',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void scaffolmessenger(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
    ));
  }
}
