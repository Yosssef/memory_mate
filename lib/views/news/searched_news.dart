import 'package:flutter/material.dart';

import '../../components/common/appbar.dart';
import '../../components/news/newslistbuilder.dart';

// ignore: must_be_immutable
class Searchednewsviwe extends StatelessWidget {
  Searchednewsviwe({super.key, required this.news});
  String news;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Myappbar(),
        toolbarHeight: screenHeight * 0.1,
      ),
      body: CustomScrollView(slivers: [
        Newslistbuilder(
          searchfor: news,
          customnews: true,
        ),
      ]),
    );
  }
}
