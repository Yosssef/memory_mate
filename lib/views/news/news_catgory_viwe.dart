// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import '../../components/common/appbar.dart';
import '../../components/news/newslistbuilder.dart';

class Catgory_view extends StatelessWidget {
  Catgory_view({super.key, required this.catgoryname});
  String catgoryname;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenHeight = screenSize.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Myappbar(),
          toolbarHeight: screenHeight * 0.1,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: CustomScrollView(slivers: [
            Newslistbuilder(catgoryname: catgoryname),
          ]),
        ));
  }
}
