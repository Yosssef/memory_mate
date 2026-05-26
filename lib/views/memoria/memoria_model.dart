import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:memory_mate/components/memoria/userask.dart';
import 'package:memory_mate/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/common/appbar.dart';

class Modelchatviwe extends StatefulWidget {
  const Modelchatviwe({super.key});

  @override
  State<Modelchatviwe> createState() => _ModelchatviweState();
}

class _ModelchatviweState extends State<Modelchatviwe> {
  TextEditingController controller = TextEditingController();
  String? messagetoupload;
  String? idofdoc;
  GlobalKey<FormState> formkey = GlobalKey();
  String? keyy;
  bool loaded = false;
  bool isKeydel = false;
  bool isChang = false;
  bool idexiestandloaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getkey();
  }

  Future<void> getkey() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    keyy = prefss.getString('key');
    if (keyy != null) {
      idexiestandloaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Myappbar(),
          toolbarHeight: screenHeight * 0.1,
        ),
        body: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                idexiestandloaded
                    ? StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('massegewithmemmorai')
                            .doc(keyy)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            Map<String, dynamic> data = snapshot.data!.data()!;
                            List<messegasandansers> messagesanrespons = [];
                            data.forEach((key, value) {
                              if (data['flage'] == 'false') {
                                if (key.startsWith('mes')) {
                                  String messageId = key.substring(3);
                                  int index = int.parse(messageId);
                                  String responseKey = 'res$messageId';
                                  messegasandansers qaa = messegasandansers(
                                      index: index,
                                      mes: value,
                                      res: data[responseKey]);
                                  messagesanrespons.add(qaa);
                                }
                              }
                            });
                            messagesanrespons
                                .sort((a, b) => b.index.compareTo(a.index));

                            return Expanded(
                              child: ListView(
                                reverse: true,
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    reverse: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: messagesanrespons.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Userask(
                                              mes:
                                                  messagesanrespons[index].mes),
                                          Memoriaanswer(
                                            res: messagesanrespons[index].res,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                  Memoriaanswer(
                                      res:
                                          'There are many services that can help you for example,\n if you want to read the news, click on the News icon... \nIf you want to know your location or other sites, click on the Maps icon... \nIf you want to record daily notes, click on the notes icon... \nIf you want to remember or register the people you have connected with, click on your people icon.... \nIf you want to call the emergency department, click on the emergency icon...\nand for me, I am here if you want to ask any general questions or start any conversation. I am here and designed to answer all your questions, and I hope I can do that well.'),
                                  Memoriaanswer(
                                      res:
                                          'Hello, i\'m memoria and this is memorymate app We try to be with you constantly. The application provides many services, including me i will tell you about the services'),
                                ],
                              ),
                            );
                          } else {
                            return Memoriaanswer(
                                res: 'sorry memoria not available now');
                          }
                        },
                      )
                    : Expanded(
                        child: ListView(
                          reverse: true,
                          children: [
                            Memoriaanswer(
                                res:
                                    'There are many services that can help you for example, if you want to read the news, click on the News icon... If you want to know your location or other sites, click on the Maps icon... If you want to record daily notes, click on the notes icon...\n  If you want to remember or register the people you have connected with, click on your people icon....\n If you want to call the emergency department, click on the emergency icon...\nand for me, I am here if you want to ask any general questions or start any conversation. I am here and designed to answer all your questions, and I hope I can do that well.'),
                            Memoriaanswer(
                                res:
                                    'Hello, i\'m memoria and this is memorymate app We try to be with you constantly. The application provides many services, including me i will tell you about the services'),
                          ],
                        ),
                      ),
                Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenHeight * 0.015),
                        child: TextFormField(
                          controller: controller,
                          validator: (data) {
                            if (data?.isEmpty ?? true) {
                              return 'Please ask your question';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            messagetoupload = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'ask',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.03),
                            prefixIcon: Icon(
                              Icons.chat,
                              color: KPrimaryColor,
                              size: screenHeight * 0.04,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                width: 5,
                                color: KPrimaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: KPrimaryColor,
                              ),
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.03),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              try {
                                controller.clear();
                                bool idexiest = await chickingidkey();
                                idexiest
                                    ? updateDocument(idofdoc!, messagetoupload!)
                                    : uploaddatatofriebase(
                                        message: messagetoupload!);
                              } catch (e) {
                                scaffolmessenger(context, 'error');
                              }
                            }
                          },
                          icon: Icon(
                            Icons.send_outlined,
                            size: screenHeight * 0.045,
                            color: KPrimaryColor,
                          ))
                    ],
                  ),
                ),
              ],
            )));
  }

  Future<void> uploaddatatofriebase({
    required String message,
  }) async {
    String key;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences prefss = await SharedPreferences.getInstance();
    SharedPreferences counter = await SharedPreferences.getInstance();
    String? email = prefss.getString('email');
    CollectionReference users =
        FirebaseFirestore.instance.collection('massegewithmemmorai');

    return users.add({
      'flage': 'true',
      'mes1': message,
      'email': email,
    }).then((DocumentReference document) async {
      key = document.id;
      await prefs.setString('key', key);
      await counter.setInt('counter', 1);
    });
  }

  Future<void> creatingnewdoc() async {
    String key;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences prefss = await SharedPreferences.getInstance();
    String? email = prefss.getString('email');
    CollectionReference users =
        FirebaseFirestore.instance.collection('massegewithmemmorai');
    return users.add({
      'flage': 'flase',
      'email': email,
    }).then((DocumentReference document) async {
      key = document.id;
      await prefs.setString('key', key);
    });
  }

  Future<bool> chickingidkey() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    if (prefss.getString('key') == null) {
      return false;
    } else {
      idofdoc = prefss.getString('key');
      return true;
    }
  }

  Future<void> updateDocument(String documentId, String message) async {
    SharedPreferences counter = await SharedPreferences.getInstance();
    int countervalue = counter.getInt('counter')! + 1;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('massegewithmemmorai')
        .doc(documentId);

    await documentReference
        .update({'flage': 'true', 'mes$countervalue': messagetoupload});
    await counter.setInt('counter', countervalue);
  }

  void scaffolmessenger(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
    ));
  }

  Future<void> deletedoc() async {}

  /* @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    deletedoc();
  }*/
}

class messegasandansers {
  messegasandansers(
      {required this.index, required this.mes, required this.res});
  String mes;
  String res;
  int index;
}
