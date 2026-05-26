// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

class news_caller {
  news_caller({
    required this.dio,
  });

  var dio = Dio();
  Future<List<newsitem>> get(String catgoryname) async {
    try {
      var respone = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=33bb48c46df84ec282b5411ff63a4a9c&category=$catgoryname');
      Map<String, dynamic> jsondata = respone.data;
      List<dynamic> artcals = jsondata['articles'];
      List<newsitem> artcallist = [];
      for (var artcal in artcals) {
        if (artcal['title'] != '[Removed]' && artcal['url'] != null) {
          newsitem thisartcal = newsitem(
              url: Uri.parse(artcal['url']),
              contant: artcal['content'] ?? 'sorry there is no contant',
              image: artcal['urlToImage'] ??
                  'https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=',
              title: artcal['title'],
              subtitle:
              artcal['description'] ?? 'clike in to more information');
          artcallist.add(thisartcal);
        }
      }
      return artcallist;
    } catch (e) {
      return [];
    }
  }
}

class customnews_caller {
  customnews_caller({
    required this.dio,
  });
  var dio = Dio();
  Future<List<newsitem>> get(String searchfor) async {
    try {
      var respone = await dio.get(
          'https://newsapi.org/v2/everything?apiKey=33bb48c46df84ec282b5411ff63a4a9c&q=$searchfor');
      Map<String, dynamic> jsondata = respone.data;
      List<dynamic> artcals = jsondata['articles'];
      List<newsitem> artcallist = [];
      for (var artcal in artcals) {
        if (artcal['title'] != '[Removed]' && artcal['url'] != null) {
          newsitem thisartcal = newsitem(
              url: Uri.parse(artcal['url']),
              contant: artcal['content'] ?? 'sorry there is no contant',
              image: artcal['urlToImage'] ??
                  'https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=',
              title: artcal['title'],
              subtitle:
              artcal['description'] ?? 'clike in to more information');
          artcallist.add(thisartcal);
        }
      }
      return artcallist;
    } catch (e) {
      return [];
    }
  }
}

class newsitem {
  String title;
  String image;
  String subtitle;
  String contant;
  Uri url;
  newsitem(
      {required this.contant,
        required this.image,
        required this.subtitle,
        required this.title,
        required this.url});
}

// ignore: must_be_immutable
class Newscard extends StatelessWidget {
  Newscard({super.key, required this.item});
  newsitem item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchInBrowser(item.url);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: item.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              item.subtitle,
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}
