// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memory_mate/const.dart';
import 'package:memory_mate/models/note_model.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../common/textfield.dart';
import '../news/noteCard.dart';

Future<List<Notes>> getnotesFromHive() async {
  var box = await Hive.openBox<Notes>(Knotes); // Open the Hive box
  List<Notes> notesList = box.values.toList();
  return notesList;
}

class Mynote extends StatefulWidget {
  const Mynote({super.key});

  @override
  State<Mynote> createState() => _MynoteState();
}

class _MynoteState extends State<Mynote> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<Notes>>(
            future: getnotesFromHive(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text(
                      'there is no notes',
                      style: TextStyle(fontSize: 24, color: KPrimaryColor),
                    ));
                  } else {
                    List<Notes> note = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: ListView.builder(
                          itemCount: note.length,
                          itemBuilder: (context, index) {
                            return NoteCard(note: note[index]);
                          }),
                    );
                  }
                } else {
                  return const Text('error');
                }
              }
            }));
  }
}

class Addnotebottomsheet extends StatelessWidget {
  const Addnotebottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Addnoteform();
  }
}

class Addnoteform extends StatefulWidget {
  const Addnoteform({super.key});

  @override
  State<Addnoteform> createState() => _AddnoteformState();
}

class _AddnoteformState extends State<Addnoteform> {
  DateTime now = DateTime.now();
  bool islodaing = false;
  String? title;
  String? contant;
  String? subtitle;
  String? datacreated;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: islodaing,
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Colors.grey.withOpacity(0.9)),
              ),
            ),
            Mytextfield(
              name: 'Titel',
              fieldicon: Icons.title_rounded,
              onchanged: (data) {
                title = data;
              },
            ),
            Mytextfield(
              name: 'Contant',
              fieldicon: Icons.abc,
              maxliness: 5,
              onchanged: (data) {
                contant = data;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      islodaing = true;
                      int year = now.year;
                      int month = now.month;
                      int day = now.day;
                      int hour = (now.hour - 12).abs();
                      int minute = now.minute;
                      datacreated = '$year-$month-$day  $hour:$minute';
                      // print(datacreated);
                      Notes note = Notes(
                          title: title!,
                          contant: contant!,
                          datacreated: datacreated!);
                      setState(() {});

                      try {
                        addnote(note);
                        Navigator.pop(context);
                        scaffolmessenger(context, 'note added');
                        setState(() {});
                      } catch (e) {
                        scaffolmessenger(context, 'there was an error');
                      }
                      islodaing = false;
                      setState(() {});
                    } else {
                      scaffolmessenger(context, 'ERROR');
                    }
                  },
                  child: const Text(
                    'ADD',
                    style: TextStyle(color: KPrimaryColor, fontSize: 24),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void scaffolmessenger(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
    ));
  }

  addnote(Notes note) async {
    await Hive.openBox<Notes>(Knotes);
    var notesbox = Hive.box<Notes>(Knotes);
    await notesbox.add(note);
  }
}
