// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/common/textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? emailAddress;
  String? password;
  bool islodaing = false;

  GlobalKey<FormState> formkeyl = GlobalKey();
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
                  image: AssetImage("assets/login_screen.jpg"),
                  fit: BoxFit.cover)),
          child: Form(
            key: formkeyl,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: screenHeight * 0.15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight * 0.24,
                        width: screenWidth * 0.56,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/appimage.png'),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    const Apptittel(),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blue, // Change the button color here
                          ),
                          onPressed: () async {
                            if (formkeyl.currentState!.validate()) {
                              islodaing = true;
                              setState(() {});
                              try {
                                await loginuser();
                                Navigator.popAndPushNamed(
                                  context,
                                  'homepage',
                                );
                                saveLoginState(emailAddress!);
                              } catch (e) {
                                scaffolmessengerL(
                                    context, 'there was an error');
                              }
                              islodaing = false;
                              setState(() {});
                            } else {
                              scaffolmessengerL(context, 'ERROR');
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.07),
                          )),
                    ),
                    Text(
                      'If you do not have an account?',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w900,
                          fontSize: screenWidth * 0.06),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, 'register');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: screenWidth * 0.06),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void scaffolmessengerL(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
    ));
  }

  Future<void> loginuser() async {
    if (password != null && emailAddress != null) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
    }
  }

  Future<SharedPreferences> saveLoginState(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
    return prefs;
  }
}
