import 'dart:io';
import 'package:capstone_design/presentation/page/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class EditUmkm extends StatefulWidget {
  final DocumentReference index;
  final String name, coverUrl, type;
  final double latitude, longitude;

  const EditUmkm({
    Key? key,
    required this.coverUrl,
    required this.index,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<EditUmkm> createState() => _EditUmkmState();
}

class _EditUmkmState extends State<EditUmkm> {
  File? image;
  LatLng? _center;
  String? addressNow, imageName, coverUrlNow, nameNow, typeNow;
  TextEditingController? namecontroller, typecontroller;
  late Position currentLocation;

  @override
  void initState() {
    setState(() {
      namecontroller = TextEditingController(text: widget.name);
      typecontroller = TextEditingController(text: widget.type);
      typeNow = widget.type;
      coverUrlNow = widget.coverUrl;
      nameNow = widget.name;
      _center = LatLng(widget.latitude, widget.longitude);
    });
    as();
    super.initState();
  }

  void as() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.latitude, widget.longitude);
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

  void editData(BuildContext context) {
    UploadTask? uploadTask;
    if (image != null) {
      FirebaseStorage.instance.refFromURL(widget.coverUrl).delete();
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(imageName! + DateTime.now().toString());
      uploadTask = ref.putFile(image!);
    } else {
      uploadTask = null;
    }
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("UMKM");
      if (image != null) {
        uploadTask!.then((res) async {
          coverUrlNow = await res.ref.getDownloadURL();
          if (nameNow != null && typeNow != null) {
            await reference.doc(widget.index.id).update({
              "name": nameNow,
              "latitude": _center!.latitude,
              "longitude": _center!.longitude,
              "coverUrl": coverUrlNow,
              "type": typeNow,
            });
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Dashboard(user: user);
            }));
            image = null;
            imageName = null;
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
        });
      } else {
        if (nameNow != null && typeNow != null) {
          await reference.doc(widget.index.id).update({
            "name": nameNow,
            "latitude": _center!.latitude,
            "longitude": _center!.longitude,
            "coverUrl": coverUrlNow,
            "type": typeNow,
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Dashboard(user: user);
          }));
          image = null;
          imageName = null;
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
      }
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
                TextField(
                  controller: typecontroller,
                  decoration: InputDecoration(hintText: "Jenis"),
                  onChanged: (value) {
                    setState(() {
                      typeNow = value;
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
                          Text("Address: $addressNow"),
                        ],
                      )
                    : Text("Lokasi belum didapatkan"),
                ElevatedButton(
                  onPressed: () {
                    pickImg();
                  },
                  child: Text("Input Foto"),
                ),
                (image == null)
                    ? Image.network(widget.coverUrl)
                    : Image.file(image!),
                ElevatedButton(
                  onPressed: () {
                    editData(context);
                  },
                  child: Text("Update UMKM"),
                ),
              ],
            ),
          ),
        ));
  }
}
