import 'dart:core';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:memory_mate/const.dart';
import 'package:memory_mate/firebase_options.dart';
import 'package:memory_mate/models/locationmodel.dart';
import 'package:memory_mate/models/note_model.dart';
import 'package:memory_mate/views/auth/login-view.dart';
import 'package:memory_mate/views/auth/register_view.dart';
import 'package:memory_mate/views/emergency/Emergency_viwe.dart';
import 'package:memory_mate/views/home/home_view.dart';
import 'package:memory_mate/views/home/splach_view.dart';

import 'package:memory_mate/views/maps/add_location_from_maps.dart';
import 'package:memory_mate/views/maps/maps_ask_view.dart';
import 'package:memory_mate/views/maps/maps_viwe.dart';

import 'package:memory_mate/views/memoria/memoria_model.dart';
import 'package:memory_mate/views/news/home_news_page.dart';
import 'package:memory_mate/views/notes/notes_view.dart';

import 'package:memory_mate/views/people/add_pepole.dart';
import 'package:memory_mate/views/people/people_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.openBox<Notes>(Knotes);
  Hive.registerAdapter(NotesAdapter());
  Hive.openBox<Locationsofuser>('locations');
  Hive.registerAdapter(LocationAdapter());

  runApp(const MemoryMate());
}

class MemoryMate extends StatelessWidget {
  const MemoryMate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'homepage',
      routes: {
        'googelmaps': (context) => const Maps(),
        'indector': (context) => const Indctor(),
        'mynote': (context) => const Mynotes(),
        'login': (context) => const Login(),
        'register': (context) => const Register(),
        'homepage': (context) => const Homepage(),
        'homenews': (context) => const HomeNewspage(),
        'Emergencyviwe': (context) => const Emergencyviwe(),
        'addpeople': (context) => const Addpeople(),
        'people': (context) => const Peopelview(),
        'addlocation': (context) => const addlocation(),
        'mapsask': (context) => const Ask(),
        'memoria': (context) => const Modelchatviwe(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
