import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:umkm/presentation/bloc/umkm_create_bloc.dart';
import 'package:umkm/presentation/bloc/umkm_state.dart';
import 'package:umkm/presentation/bloc/umkm_update_bloc.dart';
import 'package:umkm/presentation/screen/gallery_screen.dart';

import '../bloc/umkm_event.dart';
import '../components/textFields/custom_add_umkm_description_text_field.dart';
import '../components/textFields/custom_add_umkm_latitute_text_field.dart';
import '../components/textFields/custom_add_umkm_longitude_text_field.dart';
import '../components/textFields/custom_add_umkm_name_text_field.dart';
import '../components/textFields/custom_add_umkm_phone_text_field.dart';
import '../components/textFields/custom_add_umkm_shopee_text_field.dart';
import '../components/textFields/custom_add_umkm_tokopedia_text_field.dart';
import '../components/textFields/custom_add_umkm_website_text_field.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteUMKMScreen extends StatefulWidget {
  final String coverUrlNow;
  final DocumentReference index;
  final String address;
  final String phone;
  final String shopee;
  final String tokped;
  final String website;
  final String name;
  final String type;
  final String desc;
  final double latitude;
  final double longitude;
  const DeleteUMKMScreen(
      {Key? key,
      required this.coverUrlNow,
      required this.index,
      required this.address,
      required this.phone,
      required this.shopee,
      required this.tokped,
      required this.website,
      required this.name,
      required this.type,
      required this.desc,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  @override
  State<DeleteUMKMScreen> createState() => _DeleteUMKMScreenState();
}

class _DeleteUMKMScreenState extends State<DeleteUMKMScreen> {
  String? imageName;
  String? address;
  File? image;
  double? latitude;
  double? longitude;
  late Position currentLocation;
  LatLng? _center;

  TextEditingController latController = TextEditingController(),
      longController = TextEditingController(),
      addressController = TextEditingController(),
      nameController = TextEditingController(),
      typeController = TextEditingController(),
      descController = TextEditingController(),
      phoneController = TextEditingController(),
      tokpedController = TextEditingController(),
      shopeeController = TextEditingController(),
      websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // getUserLocation();
    // getAddressFromLatLong(widget.latitude, widget.longitude);
    toast.init(context);
    setState(() {
      address = widget.address;
      latController.text = widget.latitude.toString();
      longController.text = widget.longitude.toString();
      addressController.text = widget.address;
      nameController.text = widget.name;
      typeController.text = widget.type;
      descController.text = widget.desc;
      phoneController.text = widget.phone;
      tokpedController.text = widget.tokped;
      shopeeController.text = widget.shopee;
      websiteController.text = widget.website;
    });
  }

  void pickImg() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(selectedImage!.path);
      imageName = path.basename(image!.path);
    });
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
      latController = TextEditingController(text: latitude.toString());
      longController = TextEditingController(text: longitude.toString());
      getAddressFromLatLong(
          currentLocation.latitude, currentLocation.longitude);
    });
  }

  Future<void> getAddressFromLatLong(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    addressController = TextEditingController(text: address);
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

  final toast = FToast();

  void toastError(String message) {
    toast.showToast(
      child: CustomToast(
        logo: "assets/icon/fill/exclamation-circle.svg",
        message: message,
        toastColor: bToastFiled,
        bgToastColor: bBgToastFiled,
        borderToastColor: bBorderToastFiled,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }

  void toastSuccess(String message) {
    toast.showToast(
      child: CustomToast(
        logo: "assets/icon/fill/check-circle.svg",
        message: message,
        toastColor: bToastSuccess,
        bgToastColor: bBgToastSuccess,
        borderToastColor: bBorderToastSuccess,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildAddUMKMScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildAddUMKMScreen(context, screenSize),
      );
    }
  }

  Widget _buildAddUMKMScreen(BuildContext context, Size screenSize) {
    return BlocConsumer<UmkmUpdateBloc, UmkmState>(
      listenWhen: (previous, current) {
        return (previous is UmkmLoading) ? true : false;
      },
      listener: (context, state) async {
        if (state is UmkmUpdated) {
          toastSuccess("Berhasil Ditambahkan");
        } else if (state is UmkmError) {
          toastError("Gagal Ditambahkan");
        }
      },
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            CustomSliverAppBarTextLeading(
              title: "Edit UMKM",
              leadingIcon: "assets/icon/regular/chevron-left.svg",
              // Navigation repair
              leadingOnTap: () {
                Navigator.pop(
                  context,
                );
              },
            ),
            _customEditForm(
              context,
              AppLocalizations.of(context)!.shopName,
              CustomAddUMKMNameTextField(
                name: nameController,
              ),
            ),
            _customEditForm(
              context,
              "Type",
              CustomAddUMKMNameTextField(
                name: typeController,
              ),
            ),
            _customEditFormDesc(
              context,
              AppLocalizations.of(context)!.shopDesc,
              CustomAddUMKMDescriptionTextField(desc: descController),
            ),
            _customEditForm(
              context,
              AppLocalizations.of(context)!.phoneNumber,
              CustomAddUMKMPhoneTextField(phone: phoneController),
            ),
            _customEditForm(
              context,
              'Latitude',
              CustomAddUMKMLatituteTextField(latitute: latController),
            ),
            _customEditForm(
              context,
              'longitude',
              CustomAddUMKMLongitudeTextField(longitude: longController),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, top: 15.0),
                    child: Text(
                      "Alamat",
                      style: bHeading7.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        boxShadow: const [
                          BoxShadow(
                            color: bStroke,
                            spreadRadius: 2.0,
                            blurRadius: 10.0,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          (address != null)
                              ? address!
                              : "Tekan 'Lokasi Saya' untuk mengetahui lokasi anda",
                          style: bSubtitle1.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ))),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20.0,
                right: 20.0,
              ),
              sliver: SliverToBoxAdapter(
                child: CustomPrimaryIconTextButton(
                  icon: 'assets/icon/fill/map-marker.svg',
                  onTap: () {
                    setState(() {
                      getAddressFromLatLong(double.parse(latController.text),
                          double.parse(longController.text));
                    });
                  },
                  text: AppLocalizations.of(context)!.myLocation,
                  width: screenSize.width,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.image,
                      style: bHeading7.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    (image == null)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  curve: Curves.easeInOut,
                                  type: PageTransitionType.rightToLeft,
                                  child: GalleryScreen(
                                    images: widget.coverUrlNow,
                                    typeNetwork: true,
                                  ),
                                ),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: widget.coverUrlNow,
                              placeholder: (context, url) {
                                return Center(
                                  child: LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    size: 14.0,
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) => Center(
                                child: SvgPicture.asset(
                                  "assets/icon/fill/exclamation-circle.svg",
                                  color: bGrey,
                                  height: 14.0,
                                ),
                              ),
                              fit: BoxFit.cover,
                              width: 150.0,
                              height: 80.0,
                            ),
                          )
                        : SizedBox(
                            height: 80.0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      curve: Curves.easeInOut,
                                      type: PageTransitionType.rightToLeft,
                                      child: GalleryScreen(
                                        file: image,
                                        typeNetwork: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Image.file(
                                  image!,
                                  width: 150.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomPrimaryIconTextButton(
                      icon: 'assets/icon/fill/log-out.svg',
                      onTap: () => pickImg(),
                      text: AppLocalizations.of(context)!.uploadImage,
                      width: screenSize.width,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.timetable,
                      style: bHeading7.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _customEditFormLink(
                context, "Online Shop Link (Optional)", screenSize),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverToBoxAdapter(
                child: CustomPrimaryTextButton(
                  onTap: () {
                    context.read<UmkmUpdateBloc>().add(
                          OnUpdateUmkm(
                            context,
                            imageName,
                            nameController.text,
                            typeController.text,
                            descController.text,
                            widget.coverUrlNow,
                            image,
                            double.parse(latController.text),
                            double.parse(longController.text),
                            addressController.text,
                            phoneController.text,
                            shopeeController.text,
                            tokpedController.text,
                            websiteController.text,
                            widget.index,
                          ),
                        );
                  },
                  text: "Simpan",
                  width: screenSize.width,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<File>? imageList;
  List<String> imageString = [];

  Widget _customEditForm(BuildContext context, String title, Widget textField) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: bHeading7.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: textField,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customEditFormLink(
      BuildContext context, String title, Size screenSize) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: bHeading7.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            Column(
              children: <Widget>[
                _customSmallContainerLink(
                    context,
                    CustomAddUMKMTokopediaTextField(
                      tokped: tokpedController,
                    ),
                    () {},
                    true,
                    screenSize),
                _customSmallContainerLink(
                    context,
                    CustomAddUMKMShopeeTextField(
                      shopee: shopeeController,
                    ),
                    () {},
                    true,
                    screenSize),
                _customSmallContainerLink(
                    context,
                    CustomAddUMKMWebsiteTextField(
                      website: websiteController,
                    ),
                    () {},
                    false,
                    screenSize),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customSmallContainerLink(BuildContext context, Widget field,
      Function() onTap, bool isActive, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: screenSize.width - 40,
        child: field,
      ),
    );
  }

  Widget _customEditFormDesc(
      BuildContext context, String title, Widget textField) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: bHeading7.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: textField,
            ),
          ],
        ),
      ),
    );
  }
}
