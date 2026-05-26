//import 'dart:html';

// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:memory_mate/const.dart';
import 'package:memory_mate/models/locationmodel.dart';

import '../../components/common/appbar.dart';

class Mapsforlocations extends StatefulWidget {
  Mapsforlocations({super.key, required this.thislocation});
  Locationsofuser thislocation;

  @override
  State<Mapsforlocations> createState() => MapsforlocationsState();
}

class MapsforlocationsState extends State<Mapsforlocations> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  late GoogleMapController mapControllerr;

  Location locationcontroller = new Location();
  LatLng? tappedLocation;
  LatLng? currrenntpos;

  @override
  void initState() {
    super.initState();
    getlocation();
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
                target: LatLng(
                    widget.thislocation.poslat, widget.thislocation.poslang),
                zoom: 21,
              ),
              mapType: MapType.hybrid,
              markers: {
                Marker(
                  markerId: const MarkerId('current_position'),
                  position: currrenntpos!,
                  infoWindow: const InfoWindow(title: 'Your Location'),
                ),
                Marker(
                  markerId: const MarkerId('your destnation'),
                  position: LatLng(
                      widget.thislocation.poslat, widget.thislocation.poslang),
                  infoWindow:
                      InfoWindow(title: widget.thislocation.nameoflocation),
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
}
