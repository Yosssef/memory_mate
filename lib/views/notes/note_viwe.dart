// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:memory_mate/const.dart';
import 'package:memory_mate/models/note_model.dart';

import '../../components/common/appbar.dart';

class noteview extends StatelessWidget {
  noteview({super.key, required this.note});
  Notes note;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenHeight = screenSize.height;
    String date = note.datacreated;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: screenHeight * 0.1,
          automaticallyImplyLeading: false,
          title: Myappbar()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              note.title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KPrimaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              textAlignVertical: const TextAlignVertical(y: 0.2),
              readOnly: true,
              maxLines: 10,
              enabled: true,
              controller: TextEditingController(text: note.contant),
              decoration: InputDecoration(
                labelText: 'contant',
                labelStyle: const TextStyle(fontSize: 28),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: KSecondaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: KSecondaryColor,
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "date created:$date",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
