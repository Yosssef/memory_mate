import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';
import '../../views/news/searched_news.dart';

// ignore: must_be_immutable
class Myappbar extends StatefulWidget {
  Myappbar(
      {this.searchappbar = false, super.key, this.whattosearchfor = 'News'});
  String whattosearchfor;
  bool searchappbar;

  @override
  State<Myappbar> createState() => _MyappbarState();
}

class _MyappbarState extends State<Myappbar> {
  bool isSearching = false;

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    if (widget.searchappbar == true) {
      return Container(
        height: screenHeight * 0.1,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          color: KPrimaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppBar(
            toolbarHeight: screenHeight * 0.2,
            actions: [
              IconButton(
                icon: isSearching
                    ? Icon(
                        Icons.close,
                        color: KSecondaryColor.withOpacity(0.7),
                        size: screenWidth * 0.1,
                      )
                    : Icon(
                        Icons.search,
                        color: KSecondaryColor.withOpacity(0.7),
                        size: screenWidth * 0.1,
                      ),
                onPressed: () {
                  _toggleSearch();
                },
              ),
            ],
            title: isSearching
                ? TextField(
                    onSubmitted: (value) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Searchednewsviwe(
                          news: value,
                        );
                      }));
                    },
                    decoration: InputDecoration(
                      labelText: widget.whattosearchfor,
                      prefixIcon: Icon(
                        Icons.search,
                        color: KSecondaryColor.withOpacity(0.7),
                        size: screenWidth * 0.1,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 5,
                          color: KSecondaryColor.withOpacity(0.5),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: KSecondaryColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  )
                : const Apptittel(),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: AppBar(
          toolbarHeight: screenHeight * 0.08,
          title: const Apptittel(),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }
  }
}
