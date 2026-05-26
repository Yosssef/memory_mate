import 'package:flutter/cupertino.dart';
import 'PeopleCard.dart';

// ignore: must_be_immutable
class Peplolistviwe extends StatelessWidget {
  Peplolistviwe({super.key, required this.peoplelist});
  List<People> peoplelist;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: peoplelist.length,
      itemBuilder: (context, index) {
        return Poeplecard(person: peoplelist[index]);
      },
    );
  }
}
