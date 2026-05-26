import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../views/people/about_people_view.dart';

class People {
  final String name;
  final String imageurl;
  final String id;
  final String number;
  final String about;
  final String relation;
  People(
      {required this.about,
      required this.name,
      required this.number,
      required this.id,
      required this.imageurl,
      required this.relation});
  factory People.fromjson(Map<String, dynamic> jsondata) {
    return People(
        about: jsondata['about him'],
        name: jsondata['name'],
        number: jsondata['number'],
        id: jsondata['id'],
        imageurl: jsondata['imageurl'],
        relation: jsondata['relation']);
  }
}

// ignore: must_be_immutable
class Poeplecard extends StatefulWidget {
  Poeplecard({super.key, required this.person});
  People person;

  @override
  State<Poeplecard> createState() => _PoeplecardState();
}

class _PoeplecardState extends State<Poeplecard> {
  bool noimage = false;

  @override
  Widget build(BuildContext context) {
    if (widget.person.imageurl == 'null') {
      noimage = true;
    }
    final screenSize = MediaQuery.of(context).size;

    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.015, horizontal: screenHeight * 0.015),
      child: Row(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Personviwe(persontoshow: widget.person);
            })),
            child: Container(
              height: screenHeight * 0.2,
              width: screenWidth * 0.82,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: KPrimaryColor.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: noimage
                          ? CircleAvatar(
                              radius: screenWidth * 0.12,
                              backgroundColor: Colors.white,
                              foregroundImage:
                                  const AssetImage('assets/user.png'))
                          : CircleAvatar(
                              radius: screenWidth * 0.12,
                              backgroundColor: Colors.white,
                              foregroundImage:
                                  NetworkImage(widget.person.imageurl))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.person.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: KSecondaryColor.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        widget.person.relation,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          color: KSecondaryColor.withOpacity(0.5),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          SizedBox(
            height: screenHeight * 0.2,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
                    child: GestureDetector(
                      onTap: () {
                        makePhoneCall(widget.person.number);
                      },
                      child: Icon(
                        Icons.call,
                        size: screenWidth * 0.095,
                        color: KSecondaryColor.withOpacity(0.5),
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    confirmdelet(context, widget.person.name, widget.person.id);
                  },
                  child: Icon(
                    Icons.delete,
                    size: screenWidth * 0.095,
                    color: KSecondaryColor.withOpacity(0.5),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void confirmdelet(BuildContext context, String name, String id) async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    String? email = prefss.getString('email');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black.withOpacity(0.7),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                    child: Text(
                      textAlign: TextAlign.center,
                      'are sure you want to delet $name',
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: KSecondaryColor),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
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
                              await deletuser(id, email!);
                              Navigator.pop(context, 'people');
                              Navigator.pushReplacementNamed(context, 'people');

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
                                    MediaQuery.of(context).size.width * 0.07,
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
                              color: Colors.grey,
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

  Future<void> deletuser(String id, String email) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('User\'s-relatives');
    QuerySnapshot querySnapshot = await collectionReference
        .where('email', isEqualTo: email)
        .where('id', isEqualTo: id)
        .get();
    for (DocumentSnapshot doc in querySnapshot.docs) {
      await FirebaseFirestore.instance
          .collection('User\'s-relatives')
          .doc(doc.id)
          .delete();
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void scaffolmessenger(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
    ));
  }
}
