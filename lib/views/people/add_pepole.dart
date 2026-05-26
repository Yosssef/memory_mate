import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_mate/const.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/common/appbar.dart';
import '../../components/common/textfield.dart';

class Addpeople extends StatefulWidget {
  const Addpeople({super.key});
  @override
  State<Addpeople> createState() => _AddpeopleState();
}

class _AddpeopleState extends State<Addpeople> {
  String? name;
  String? number;
  String? relation;
  String? about;
  String? imageurl;
  File? slectedimage;
  Uint8List? image;
  GlobalKey<FormState> formkey = GlobalKey();
  bool islodaing = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return ModalProgressHUD(
      inAsyncCall: islodaing,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.1,
          automaticallyImplyLeading: false,
          title: Myappbar(),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Container(
                height: screenHeight * 0.85,
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: KPrimaryColor.withOpacity(0.2),
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Stack(
                              children: [
                                image != null
                                    ? Center(
                                        child: GestureDetector(
                                          onTap: () => imageviwer(
                                              context: context, image: image),
                                          child: CircleAvatar(
                                            radius: screenWidth * 0.16,
                                            backgroundImage:
                                                MemoryImage(image!),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: GestureDetector(
                                          onTap: () =>
                                              imageviwer(context: context),
                                          child: CircleAvatar(
                                            radius: screenWidth * 0.16,
                                            backgroundColor: Colors.white,
                                            foregroundImage: const AssetImage(
                                                'assets/user.png'),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.33),
                              child: ElevatedButton(
                                onPressed: () {
                                  pickerimageformgallery();
                                },
                                child: const Icon(Icons.add_a_photo),
                              ),
                            ),
                            Mytextfield(
                              name: 'Name',
                              fieldicon: Icons.person,
                              onchanged: (data) {
                                name = data;
                              },
                            ),
                            Mytextfield(
                              name: 'Number',
                              fieldicon: Icons.phone_android,
                              onchanged: (data) {
                                number = data;
                              },
                            ),
                            Mytextfield(
                              name: 'His relationship with you',
                              fieldicon: Icons.people,
                              onchanged: (data) {
                                relation = data;
                              },
                            ),
                            Mytextfield(
                              maxliness: 3,
                              name: 'About him',
                              fieldicon: Icons.info_outline,
                              onchanged: (data) {
                                about = data;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.2),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      islodaing = true;
                                      setState(() {});
                                      try {
                                        String uniqe1 = DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString();
                                        String uniqe2 = DateTime.now()
                                            .microsecondsSinceEpoch
                                            .toString();
                                        DateTime time = DateTime.now();
                                        await uploadimage(uniqe1);
                                        if (imageurl != null) {
                                          await uploaddatatofriebase(
                                              name: name!,
                                              number: number!,
                                              about: about!,
                                              relation: relation!,
                                              imageurl: imageurl!,
                                              time: time,
                                              id: uniqe2);
                                        } else {
                                          await uploaddatatofriebase(
                                              name: name!,
                                              number: number!,
                                              about: about!,
                                              relation: relation!,
                                              time: time,
                                              id: uniqe2);
                                        }
                                        scaffolmessenger(context, "Added");
                                        Navigator.pop(context, 'people');
                                        Navigator.popAndPushNamed(
                                            context, 'people');
                                      } catch (e) {
                                        scaffolmessenger(context,
                                            "error to adding data try agin later");
                                      }
                                      islodaing = false;
                                      setState(() {});
                                    } else {
                                      scaffolmessenger(
                                          context, 'please add all data');
                                    }
                                  },
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.07),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  uploadimage(String uniquefilename) async {
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referencedirimages = referenceroot.child("images");
    Reference referenceimagetoupload = referencedirimages.child(uniquefilename);
    if (slectedimage == null) return;
    await referenceimagetoupload.putFile(slectedimage!);
    final imageurlll = await referenceimagetoupload.getDownloadURL();
    setState(() {
      imageurl = imageurlll;
    });
  }

  Future<void> uploaddatatofriebase(
      {required String name,
      required String number,
      required String about,
      required String relation,
      required String id,
      required DateTime time,
      String imageurl = 'null'}) async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    String? email = prefss.getString('email');
    CollectionReference users =
        FirebaseFirestore.instance.collection('User\'s-relatives');
    return users
        .add({
          'imageurl': imageurl,
          'name': name,
          'relation': relation,
          'number': number,
          'about him': about,
          'email': email,
          'id': id,
          'datecreated': time
        })
        .then((value) => print("User Added"))
        .catchError((error) => scaffolmessenger(context, 'error'));
  }

  void scaffolmessenger(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
    ));
  }

  Future pickerimageformgallery() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedimage == null) return;
    setState(() {
      slectedimage = File(returnedimage.path);
      image = File(returnedimage.path).readAsBytesSync();
    });
  }

  void imageviwer({
    required BuildContext context,
    Uint8List? image,
  }) {
    if (image == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
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
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: MemoryImage(image),
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
