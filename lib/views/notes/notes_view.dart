import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';

import '../../components/common/appbar.dart';
import '../../components/notes/notebottomsheet.dart';

class Mynotes extends StatefulWidget {
  const Mynotes({super.key});

  @override
  State<Mynotes> createState() => _MynotesState();
}

class _MynotesState extends State<Mynotes> {
  String? result;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: KPrimaryColor,
          foregroundColor: KSecondaryColor,
          hoverColor: KSecondaryColor,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                      child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          KPrimaryColor.withOpacity(0.2),
                          KSecondaryColor.withOpacity(0.95)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                    ),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min, // Adjust based on content

                      children: [
                        Addnotebottomsheet(),
                      ],
                    ),
                  ));
                }).then((value) {
              Navigator.popAndPushNamed(context, 'mynote');
            });
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.1,
          automaticallyImplyLeading: false,
          title: Myappbar(),
        ),
        body: const Mynote());
  }
}
