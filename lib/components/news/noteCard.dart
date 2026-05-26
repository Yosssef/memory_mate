// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';
import 'package:memory_mate/models/note_model.dart';
import 'package:memory_mate/views/notes/note_viwe.dart';

class NoteCard extends StatelessWidget {
  NoteCard({super.key, required this.note});
  Notes note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return noteview(note: note);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
              colors: [KPrimaryColor.withOpacity(0.5), KSecondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  title: Text(
                    note.title,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  subtitle: Text(note.contant,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 20, color: Color.fromARGB(150, 0, 0, 0))),
                  trailing: IconButton(
                    onPressed: () async {
                      note.delete();
                      Navigator.popAndPushNamed(context, 'mynote');
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: KPrimaryColor,
                      size: 30,
                    ),
                  ),
                ),
                Text(
                  note.datacreated,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
