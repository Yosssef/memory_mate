import 'package:flutter/material.dart';

import '../../components/common/appbar.dart';
import '../../components/news/catgory.dart';
import '../../components/news/newslistbuilder.dart';

class HomeNewspage extends StatefulWidget {
  const HomeNewspage({super.key});

  @override
  State<HomeNewspage> createState() => _HomeNewspageState();
}

class _HomeNewspageState extends State<HomeNewspage> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final screenH = screen.height;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: screenH * 0.1,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Myappbar(
            searchappbar: true,
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: Listviwe1()),
            const SliverToBoxAdapter(
              child: SizedBox(height: 18),
            ),
            Newslistbuilder(
              catgoryname: 'general',
            ),
          ],
        ),
      ),
    );
  }
}
