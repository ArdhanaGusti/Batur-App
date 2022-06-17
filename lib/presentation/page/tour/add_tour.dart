import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_event.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class AddTour extends StatefulWidget {
  const AddTour({Key? key}) : super(key: key);

  @override
  State<AddTour> createState() => _AddTourState();
}

class _AddTourState extends State<AddTour> {
  ApiService apiService = ApiService();
  File? image;
  LatLng? _center;
  String? address, imageName, urlName, name, type, desc;
  late Position currentLocation;

  void pickImg() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(selectedImage!.path);
      imageName = basename(image!.path);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
    setState(() {});
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    getAddressFromLatLong(currentLocation);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  Future<Position> locateUser() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Nama"),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(hintText: "Deskripsi"),
              onChanged: (value) {
                setState(() {
                  desc = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "Jenis"),
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: getUserLocation,
              child: Text("get location"),
            ),
            (_center != null)
                ? Column(
                    children: [
                      Text("Lattitude: ${_center!.latitude}"),
                      Text("Longitude: ${_center!.longitude}"),
                      Text("Address: $address"),
                    ],
                  )
                : Text("Lokasi belum didapatkan"),
            ElevatedButton(
              onPressed: () {
                pickImg();
              },
              child: Text("Input Foto"),
            ),
            (image == null) ? Text("Tidak ada gambar") : Image.file(image!),
            BlocBuilder<TourCreateBloc, TourState>(builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (name != null && type != null) {
                    context.read<TourCreateBloc>().add(OnCreateTour(
                        context,
                        imageName!,
                        name!,
                        type!,
                        desc!,
                        image!,
                        currentLocation));
                    // ApiService().sendTour(context, imageName!, name!, type!,
                    //     desc!, image!, currentLocation);
                    setState(() {
                      image = null;
                      imageName = null;
                    });
                  } else {
                    AlertDialog alert = AlertDialog(
                      title: Text("Silahkan lengkapi data"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Ok"))
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                },
                child: Text("Send Tour"),
              );
            })
          ],
        ),
      ),
    ));
  }
}
