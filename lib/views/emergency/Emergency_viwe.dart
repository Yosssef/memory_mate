// ignore_for_file: file_names, unused_local_variable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/common/appbar.dart';
import '../../components/emergency/emergencyC.dart';
import '../../components/emergency/emergencyCUSER.dart';

List<Emergencycon> emergency = [
  Emergencycon(
      image: 'assets/emergncy_icons/police.png', name: 'POLICE', number: '122'),
  Emergencycon(
      image: 'assets/emergncy_icons/ambulance.png',
      name: 'AMBULANCE',
      number: '123'),
  Emergencycon(
      image: 'assets/emergncy_icons/fire.png',
      name: 'Fire fighting',
      number: '180'),
];

class Emergencyviwe extends StatefulWidget {
  const Emergencyviwe({super.key});

  @override
  State<Emergencyviwe> createState() => _EmergencyviweState();
}

class _EmergencyviweState extends State<Emergencyviwe> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenHeight = screenSize.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.1,
          automaticallyImplyLeading: false,
          title: Myappbar(),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: ListView.builder(
                itemCount: emergency.length,
                itemBuilder: (context, index) {
                  return EmergencyC(type: emergency[index]);
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: FutureBuilder(
                future: getdatausewhere(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    number user = number.fromjson(snapshot.data!);
                    return EmergabcyCUSER(user: user);
                  } else {
                    return const Center(child: Text('error'));
                  }
                },
              ),
            ),
            SizedBox(
              height: screenHeight * 0.13,
            )
          ],
        ));
  }

  Future<Map<String, dynamic>> getdatausewhere() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    String? email = prefss.getString('email');
    print(email);
    Map<String, dynamic> userDataMap = {};
    if (email != null) {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('uesr-information');
      await collectionReference
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          userDataMap = element.data() as Map<String, dynamic>;
        });
      });
    } else {
      scaffolmessenger(context, "error");
    }

    return userDataMap;
  }

  void scaffolmessenger(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
    ));
  }
}
