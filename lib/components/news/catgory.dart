import 'package:flutter/material.dart';

import '../../views/news/news_catgory_viwe.dart';

class Catgoryitems {
  Catgoryitems({required this.image, required this.titel});
  String image;
  String titel;
}

List<Catgoryitems> items = [
  Catgoryitems(
      image: 'assets/newscatgory_image/business.jpg', titel: 'Business'),
  Catgoryitems(
      image: 'assets/newscatgory_image/entertaiment.avif',
      titel: 'Entertainment'),
  Catgoryitems(image: 'assets/newscatgory_image/genral.jpg', titel: 'General'),
  Catgoryitems(image: 'assets/newscatgory_image/health.avif', titel: 'Health'),
  Catgoryitems(
      image: 'assets/newscatgory_image/science.avif', titel: 'Science'),
  Catgoryitems(image: 'assets/newscatgory_image/sports.jpg', titel: 'Sports'),
  Catgoryitems(
      image: 'assets/newscatgory_image/technology.jpeg', titel: 'Technology'),
];

// ignore: must_be_immutable
class Catgorcard extends StatelessWidget {
  Catgorcard({super.key, required this.item});
  Catgoryitems item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Catgory_view(catgoryname: item.titel);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(item.image), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              item.titel,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class Listviwe1 extends StatelessWidget {
  const Listviwe1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Catgorcard(item: items[index]);
          }),
    );
  }
}
