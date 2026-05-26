import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login-view.dart';
import 'home_view.dart';

class Indctor extends StatefulWidget {
  const Indctor({super.key});

  @override
  IndctorState createState() => IndctorState();
}

class IndctorState extends State<Indctor> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidinganmation;
  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    slidinganmation = Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
    slidinganmation.addListener(() {
      setState(() {});
    });
    Future.delayed(const Duration(seconds: 2), () => checkLoginState());
  }

  void checkLoginState() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    bool isLoggedIn = prefss.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      navigateToMainScreen();
    } else {
      navigateToLoginScreen();
    }
  }

  void navigateToMainScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Homepage(),
      ),
    );
  }

  void navigateToLoginScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenWidth = screenSize.width;
    return Scaffold(
      body: Container(
        color: KPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Memory',
                  style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Mate',
                  style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      color: KSecondaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SlideTransition(
              position: slidinganmation,
              child: Text(
                'HERE TO HELP',
                style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            )
          ],
        ),
      ),
    );
  }
}
