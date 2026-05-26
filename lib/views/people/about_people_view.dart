// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';
import '../../components/common/appbar.dart';
import '../../components/people/PeopleCard.dart';

class Personviwe extends StatelessWidget {
  Personviwe({super.key, required this.persontoshow});
  People persontoshow;
  bool noimage = true;

  @override
  Widget build(BuildContext context) {
    if (persontoshow.imageurl == 'null') {
      noimage = false;
    }
    final screenSize = MediaQuery.of(context).size;

    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Myappbar(),
        toolbarHeight: screenHeight * 0.1,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: noimage
                    ? Center(
                        child: GestureDetector(
                          onTap: () => imageviwer(
                              context: context,
                              imageurl: persontoshow.imageurl),
                          child: CircleAvatar(
                            radius: screenWidth * 0.16,
                            backgroundImage:
                                NetworkImage(persontoshow.imageurl),
                          ),
                        ),
                      )
                    : Center(
                        child: GestureDetector(
                          onTap: () => imageviwer(context: context),
                          child: CircleAvatar(
                            radius: screenWidth * 0.16,
                            backgroundColor: Colors.white,
                            foregroundImage:
                                const AssetImage('assets/user.png'),
                          ),
                        ),
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    persontoshow.name,
                    style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        color: KPrimaryColor.withOpacity(0.9),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    persontoshow.relation,
                    style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        color: KPrimaryColor.withOpacity(0.9),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    persontoshow.number,
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: KPrimaryColor.withOpacity(0.9),
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              textAlignVertical: const TextAlignVertical(y: 0.2),
              readOnly: true,
              maxLines: 9,
              enabled: true,
              controller: TextEditingController(text: persontoshow.about),
              decoration: InputDecoration(
                labelText: 'ABOUT HIM',
                labelStyle: const TextStyle(fontSize: 28),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: KSecondaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: KSecondaryColor,
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }

  void imageviwer({
    required BuildContext context,
    String? imageurl,
  }) {
    if (imageurl == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                image: DecorationImage(
                  image: AssetImage('assets/user.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                image: DecorationImage(
                  image: NetworkImage(imageurl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
