import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memory_mate/const.dart';
import 'package:memory_mate/models/locationmodel.dart';

import '../../components/common/appbar.dart';
import '../../components/maps/locationaddedcard.dart';
import '../../components/maps/yourlocationcard.dart';

class Ask extends StatefulWidget {
  const Ask({super.key});

  @override
  State<Ask> createState() => _AskState();
}

class _AskState extends State<Ask> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: KSecondaryColor,
          foregroundColor: KPrimaryColor,
          hoverColor: KSecondaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, 'addlocation');
          }),
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        automaticallyImplyLeading: false,
        title: Myappbar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const yourlocatiocard(),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05),
            child: Text(
              'locations you have added:',
              style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: FutureBuilder<List<Locationsofuser>>(
                  future: getlocationsFromHive(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text(
                            'there is no locatins yet',
                            style:
                                TextStyle(fontSize: 24, color: KPrimaryColor),
                          ));
                        } else {
                          List<Locationsofuser> locations = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: ListView.builder(
                                itemCount: locations.length,
                                itemBuilder: (context, index) {
                                  return Youraddedlocatiocard(
                                    locationinfo: locations[index],
                                  );
                                }),
                          );
                        }
                      } else {
                        return const Text('error');
                      }
                    }
                  }))
        ],
      ),
    );
  }

  Future<List<Locationsofuser>> getlocationsFromHive() async {
    var box =
        await Hive.openBox<Locationsofuser>('locations'); // Open the Hive box
    List<Locationsofuser> locationsList = box.values.toList();
    return locationsList;
  }
}
