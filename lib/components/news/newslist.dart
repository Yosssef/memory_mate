import 'package:flutter/material.dart';
import 'package:memory_mate/components/news/news.dart';

// ignore: must_be_immutable
class Newslist extends StatelessWidget {
  Newslist({super.key, required this.artcals});
  List<newsitem> artcals = [];
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: artcals.length,
            (context, index) {
      return Newscard(
        item: artcals[index],
      );
    }));
  }
}

