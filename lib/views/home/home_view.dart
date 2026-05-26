import 'package:flutter/material.dart';

import '../../components/common/appbar.dart';
import '../../components/home/buttons_of_hp.dart';
List<String> homebutonscontant = [
  'News',
  'Your People',
  'Maps',
  'Memoria',
  'Emergancy',
  'Notes'
];
List<String> icones = [
  'assets/icons/newspaper.png',
  'assets/icons/people-together.png',
  'assets/icons/chatbot.png',
  'assets/icons/map.png',
  'assets/icons/siren.png',
  'assets/icons/note.png'
];

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final screenHieght = screen.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHieght * 0.1,
        title: Myappbar(),
      ),
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        Padding(
          padding: EdgeInsets.only(top: screenHieght * 0.05),
          child: Rowbutton(
            nextW2: 'people',
            icon1: icones[0],
            icon2: icones[1],
            nextW1: 'homenews',
            contant1: homebutonscontant[0],
            contant2: homebutonscontant[1],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Rowbutton(
              icon1: icones[2],
              icon2: icones[3],
              nextW2: 'mapsask',
              nextW1: 'memoria',
              contant1: homebutonscontant[3],
              contant2: homebutonscontant[2]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Rowbutton(
              icon1: icones[5],
              icon2: icones[4],
              nextW2: 'Emergencyviwe',
              nextW1: 'mynote',
              contant1: homebutonscontant[5],
              contant2: homebutonscontant[4]),
        ),
      ]),
    );
  }
}
