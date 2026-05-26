// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:memory_mate/const.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/common/textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? emailAddress;
  String? password;
  String? uesrname;
  String? age;
  String? resname;
  String? resnumber;
  bool islodaing = false;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return ModalProgressHUD(
      inAsyncCall: islodaing,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/register_screen.jpeg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.05, horizontal: screenWidth * 0.05),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: Form(
                key: formkey,
                child: Column(children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  const Apptittel(),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Mytextfield(
                          name: 'User Name',
                          fieldicon: Icons.person_outline,
                          onchanged: (data) {
                            uesrname = data;
                          },
                        ),
                        Mytextfield(
                          name: 'User Age',
                          fieldicon: Icons.calendar_month_outlined,
                          onchanged: (data) {
                            age = data;
                          },
                        ),
                        Mytextfield(
                          name: 'Responsible For him',
                          fieldicon: Icons.people,
                          onchanged: (data) {
                            resname = data;
                          },
                        ),
                        Mytextfield(
                          name: 'Nember of Res',
                          fieldicon: Icons.phone_android,
                          onchanged: (data) {
                            resnumber = data;
                          },
                        ),
                        Mytextfield(
                          name: 'Email',
                          fieldicon: Icons.email,
                          onchanged: (data) {
                            emailAddress = data;
                          },
                        ),
                        Mytextfield(
                          name: 'Password',
                          fieldicon: Icons.password,
                          password: true,
                          onchanged: (data) {
                            password = data;
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.2),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.blue, // Change the button color here
                              ),
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  islodaing = true;
                                  setState(() {});
                                  try {
                                    await registeruser();
                                    saveLoginState(emailAddress!);
                                    Navigator.popAndPushNamed(
                                      context,
                                      'homepage',
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      scaffolmessenger(
                                          context, 'weak-password');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      scaffolmessenger(
                                          context, 'email-already-in-use');
                                    }
                                  } catch (e) {
                                    scaffolmessenger(
                                        context, 'there was an error');
                                  }
                                  islodaing = false;
                                  setState(() {});
                                } else {
                                  scaffolmessenger(context, 'ERROR');
                                }
                              },
                              child: Text(
                                'REGESTER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight * 0.028),
                              )),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Center(
                          child: Text(
                            'If you already have an account?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: screenHeight * 0.028),
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, 'login');
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: KPrimaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: screenHeight * 0.033),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void scaffolmessenger(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
    ));
  }

  Future<void> registeruser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress!,
      password: password!,
    );
    CollectionReference users =
        FirebaseFirestore.instance.collection('uesr-information');
    return users
        .add({
          'email': emailAddress,
          'password': password,
          'uesrname': uesrname,
          'age': age,
          'resname': resname,
          'res number': resnumber,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<SharedPreferences> saveLoginState(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
    return prefs;
  }
}
