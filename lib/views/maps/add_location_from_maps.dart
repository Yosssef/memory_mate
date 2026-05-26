import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:memory_mate/const.dart';
import 'package:memory_mate/models/locationmodel.dart';

import '../../components/common/appbar.dart';
import '../../components/common/textfield.dart';

class addlocation extends StatefulWidget {
  const addlocation({super.key});

  @override
  State<addlocation> createState() => _addlocationState();
}

class _addlocationState extends State<addlocation> {
  late GoogleMapController mapControllerr;
  Location locationcontroller = new Location();
  LatLng? currrenntpos;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void initState() {
    getlocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor.withOpacity(0.003),
        title: Myappbar(),
      ),
      body: currrenntpos == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: currrenntpos!,
                zoom: 20,
              ),
              mapType: MapType.hybrid,
              onLongPress: (LatLng latLng) {
                askindiolog(context, latLng);
              },
              markers: {
                Marker(
                  markerId: const MarkerId('current_position'),
                  position: currrenntpos!,
                  infoWindow: const InfoWindow(title: 'Your Location'),
                ),
              },
            ),
    );
  }

  Future<void> getlocation() async {
    bool serviceenabled;
    PermissionStatus permissiongranted;
    serviceenabled = await locationcontroller.serviceEnabled();
    if (serviceenabled) {
      serviceenabled = await locationcontroller.requestService();
    } else {
      return;
    }
    permissiongranted = await locationcontroller.hasPermission();
    if (permissiongranted == PermissionStatus.denied) {
      permissiongranted = await locationcontroller.requestPermission();
      if (permissiongranted != PermissionStatus.granted) {
        return;
      }
    }
    locationcontroller.onLocationChanged.listen((LocationData currentlocation) {
      if (currentlocation.latitude != null &&
          currentlocation.longitude != null) {
        if (mounted) {
          setState(() {
            currrenntpos =
                LatLng(currentlocation.latitude!, currentlocation.longitude!);
          });
        }
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapControllerr = controller;
  }

  void askindiolog(BuildContext context, LatLng pos) async {
    String? name;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black.withOpacity(0.7),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1.01,
              height: MediaQuery.of(context).size.width * 0.78,
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05),
                      child: Text(
                        textAlign: TextAlign.center,
                        'you will add this location as',
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Mytextfield(
                      name: 'location name',
                      fieldicon: Icons.location_on,
                      onchanged: (data) {
                        name = data;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      child: const Text(
                        'warinig: make sure you have taped the right location',
                        style: TextStyle(
                            color: KSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.02),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                Locationsofuser loc = Locationsofuser(
                                    nameoflocation: name!,
                                    poslang: pos.longitude,
                                    poslat: pos.latitude);
                                try {
                                  addlocation(loc);
                                  Navigator.pop(
                                    context,
                                  );

                                  scaffolmessenger(context, 'Added secssful');
                                } catch (e) {
                                  scaffolmessenger(context,
                                      'error while add try agin later');
                                }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.08),
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.034,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.015),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width * 0.12,
                              child: const VerticalDivider(
                                color: Colors.grey,
                                thickness: 2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.032,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void scaffolmessenger(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
    ));
  }

  addlocation(Locationsofuser locationnn) async {
    await Hive.openBox<Locationsofuser>('locations');
    var locationbox = Hive.box<Locationsofuser>('locations');
    await locationbox.add(locationnn);
    print('done');
  }
}
