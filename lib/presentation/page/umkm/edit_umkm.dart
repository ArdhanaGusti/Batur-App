import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_event.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_state.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_update_bloc.dart';
import 'package:capstone_design/presentation/page/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class EditUmkm extends StatefulWidget {
  final DocumentReference index;
  final String name, coverUrl, type, desc;
  final double latitude, longitude;

  const EditUmkm({
    Key? key,
    required this.coverUrl,
    required this.index,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.desc,
  }) : super(key: key);

  @override
  State<EditUmkm> createState() => _EditUmkmState();
}

class _EditUmkmState extends State<EditUmkm> {
  File? image;
  ApiService apiService = ApiService();
  LatLng? _center;
  String? addressNow, imageName, coverUrlNow, nameNow, typeNow, descNow;
  TextEditingController? namecontroller,
      typecontroller,
      descController,
      latController,
      longController;
  double? latitudeNow, longitudeNow;
  late Position currentLocation;

  @override
  void initState() {
    setState(() {
      namecontroller = TextEditingController(text: widget.name);
      typecontroller = TextEditingController(text: widget.type);
      descController = TextEditingController(text: widget.desc);
      latController = TextEditingController(text: widget.latitude.toString());
      longController = TextEditingController(text: widget.longitude.toString());
      typeNow = widget.type;
      coverUrlNow = widget.coverUrl;
      nameNow = widget.name;
      descNow = widget.desc;
      latitudeNow = widget.latitude;
      longitudeNow = widget.longitude;
      // _center = LatLng(widget.latitude, widget.longitude);
    });
    as();
    super.initState();
  }

  void as() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitudeNow!, longitudeNow!);
    Placemark place = placemarks[0];
    addressNow =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  void getUserLocation() async {
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
    addressNow =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  void pickImg() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(selectedImage!.path);
      imageName = basename(image!.path);
    });
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
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(hintText: "Nama"),
                  onChanged: (value) {
                    setState(() {
                      nameNow = value;
                    });
                  },
                ),
                TextFormField(
                  controller: descController,
                  maxLines: 3,
                  decoration: InputDecoration(hintText: "Deskripsi"),
                  onChanged: (value) {
                    setState(() {
                      descNow = value;
                    });
                  },
                ),
                TextField(
                  controller: typecontroller,
                  decoration: InputDecoration(hintText: "Jenis"),
                  onChanged: (value) {
                    setState(() {
                      typeNow = value;
                    });
                  },
                ),
                TextField(
                  controller: latController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Latitude"),
                  onChanged: (value) async {
                    if (value == '') {
                      latitudeNow = 0;
                    } else {
                      setState(() {
                        latitudeNow = double.parse(value);
                      });
                    }
                  },
                ),
                TextField(
                  controller: longController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Longitude"),
                  onChanged: (value) async {
                    if (value == '') {
                      latitudeNow = 0;
                    } else {
                      setState(() {
                        longitudeNow = double.parse(value);
                      });
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        latitudeNow!, longitudeNow!);
                    Placemark place = placemarks[0];
                    addressNow =
                        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                    setState(() {});
                  },
                  child: Text("get location"),
                ),
                Column(
                  children: [
                    Text("Address: $addressNow"),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    pickImg();
                  },
                  child: Text("Input Foto"),
                ),
                (image == null)
                    ? Image.network(widget.coverUrl)
                    : Image.file(image!),
                BlocConsumer<UmkmUpdateBloc, UmkmState>(
                    listener: (context, state) async {
                  if (state is UmkmLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: CircularProgressIndicator(),
                    ));
                  } else if (state is UmkmUpdated) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.result),
                    ));
                  } else if (state is UmkmError) {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(state.message),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Kembali"),
                              )
                            ],
                          );
                        });
                  }
                }, builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (nameNow != null &&
                          typeNow != null &&
                          descNow != null) {
                        context.read<UmkmUpdateBloc>().add(OnUpdateUmkm(
                              context,
                              imageName,
                              nameNow!,
                              typeNow!,
                              descNow!,
                              coverUrlNow!,
                              image,
                              latitudeNow!,
                              longitudeNow!,
                              widget.index,
                            ));
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
                    child: Text("Update UMKM"),
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
