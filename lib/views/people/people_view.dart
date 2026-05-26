import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/common/appbar.dart';
import '../../components/people/PeopleCard.dart';
import '../../components/people/peoplelist.dart';

class Peopelview extends StatefulWidget {
  const Peopelview({super.key});

  @override
  State<Peopelview> createState() => _PeopelviewState();
}

class _PeopelviewState extends State<Peopelview> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: KPrimaryColor,
          foregroundColor: KSecondaryColor,
          hoverColor: KSecondaryColor,
          onPressed: () {
            Navigator.pushNamed(context, 'addpeople');
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.1,
          automaticallyImplyLeading: false,
          title: Myappbar(),
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: screenWidth * 0.1),
          child: FutureBuilder(
            future: getdatausewhere(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                List<dynamic> peoples = snapshot.data!;
                List<People> peopleslist = [];
                for (var people in peoples) {
                  People userpeople = People.fromjson(people);
                  peopleslist.add(userpeople);
                }
                return Peplolistviwe(
                  peoplelist: peopleslist,
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text('error to get data'));
              }
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('there is no data'),
                );
              } else {
                return const Center(
                  child: Text('there error try agin later'),
                );
              }
            },
          ),
        ));
  }

  Future<List<dynamic>> getdatausewhere() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    String? email = prefss.getString('email');

    List<Map<String, dynamic>> userDataMap = [];
    if (email != null) {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('User\'s-relatives');
      await collectionReference
          .where('email', isEqualTo: email)
          .orderBy('datecreated', descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          userDataMap.add(element.data() as Map<String, dynamic>);
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
