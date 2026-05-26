import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'news.dart';
import 'newslist.dart';

// ignore: must_be_immutable
class Newslistbuilder extends StatefulWidget {
  Newslistbuilder(
      {super.key, this.catgoryname, this.searchfor, this.customnews = false});
  String? catgoryname;
  String? searchfor;
  bool customnews;

  @override
  State<Newslistbuilder> createState() => NewslistbuilderState();
}

class NewslistbuilderState extends State<Newslistbuilder> {
  var futer;
  @override
  initState() {
    super.initState();
    if (widget.customnews == true && widget.searchfor != null) {
      futer = customnews_caller(
        dio: Dio(),
      ).get(widget.searchfor!);
    } else {
      futer = news_caller(
        dio: Dio(),
      ).get(widget.catgoryname!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<newsitem>>(
        future: futer,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Newslist(artcals: snapshot.data!);
          } else if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text('There is an error plese try agine later'),
                ),
              ),
            );
          } else {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            );
          }
        });
  }
}
