import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:theme/theme.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:umkm/presentation/bloc/umkm_create_bloc.dart';
import 'package:umkm/presentation/bloc/umkm_state.dart';

import '../bloc/umkm_event.dart';
import '../components/textFields/custom_add_umkm_address_text_field.dart';
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

class AddUMKMScreen extends StatefulWidget {
  const AddUMKMScreen({Key? key}) : super(key: key);

  @override
  State<AddUMKMScreen> createState() => _AddUMKMScreenState();
}

class _AddUMKMScreenState extends State<AddUMKMScreen> {
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
      descController = TextEditingController(),
      phoneController = TextEditingController(),
      tokpedController = TextEditingController(),
      shopeeController = TextEditingController(),
      websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserLocation();

    setState(() {});
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
    // getAddressFromLatLong(currentLocation);
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

  List<String> images = [
    "https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2022/03/11/4072812075.jpg",
    "https://akcdn.detik.net.id/visual/2022/03/30/seulgi-red-velvet-1_169.jpeg?w=650",
    "https://ecs7.tokopedia.net/blog-tokopedia-com/uploads/2021/01/scmc.jpg",
    "https://media.suara.com/pictures/970x544/2020/08/19/24987-wendy-red-velvet-soompi.jpg",
  ];
  // List<String> time = [
  //   "07.00 - 16.00",
  //   "07.00 - 16.00",
  //   "07.00 - 16.00",
  //   "07.00 - 16.00",
  // ];
  List<bool> isClose = [
    false,
    false,
    false,
    true,
  ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
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
            child: _buildNewsDetailScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildNewsDetailScreen(context, screenSize),
      );
    }
  }

  Widget _buildNewsDetailScreen(BuildContext context, Size screenSize) {
    List<String> days = [
      AppLocalizations.of(context)!.monday,
      AppLocalizations.of(context)!.tuesday,
      AppLocalizations.of(context)!.wednesday,
      AppLocalizations.of(context)!.thursday,
    ];
    return BlocConsumer<UmkmCreateBloc, UmkmState>(
      listener: (context, state) async {
        if (state is UmkmLoading) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CircularProgressIndicator(),
          ));
        } else if (state is UmkmCreated) {
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
      },
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            CustomSliverAppBarTextLeading(
              title: AppLocalizations.of(context)!.listUMKM,
              leadingIcon: "assets/icon/back.svg",
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
            // _customEditForm(
            //   context,
            //   AppLocalizations.of(context)!.address,
            //   CustomAddUMKMAddressTextField(address: addressController),
            // ),
            SliverToBoxAdapter(
              child: Container(
                child: Text((address != null) ? address! : ""),
              ),
            ),
            _customEditForm(
              context,
              AppLocalizations.of(context)!.address,
              CustomAddUMKMLatituteTextField(latitute: latController),
            ),
            _customEditForm(
              context,
              AppLocalizations.of(context)!.address,
              CustomAddUMKMLongitudeTextField(longitude: longController),
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
                        ? Container(
                            width: 150.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(color: bStroke),
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icon/camera-Light.svg",
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    height: 24.0,
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.inputImage,
                                    style: bBody1.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 80.0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => GalleryScreen(
                                  //       images: image!,
                                  //     ),
                                  //   ),
                                  // );
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
            // SliverPadding(
            //   padding: const EdgeInsets.only(
            //     left: 20.0,
            //     right: 20.0,
            //   ),
            //   sliver: SliverList(
            //     delegate: SliverChildBuilderDelegate(
            //       (BuildContext context, int index) {
            //         return _customCardScedule(
            //           days[index],
            //           time[index],
            //           () {},
            //           () {},
            //           isClose[index],
            //         );
            //       },
            //       childCount: isClose.length, // 1000 list items
            //     ),
            //   ),
            // ),
            _customEditFormLink(context,
                AppLocalizations.of(context)!.onlineShopLink, screenSize),
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              sliver: SliverToBoxAdapter(
                child: _buildCheckBox(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverToBoxAdapter(
                child: CustomPrimaryTextButton(
                  onTap: () {
                    context.read<UmkmCreateBloc>().add(OnCreateUmkm(
                        context,
                        imageName!,
                        address!,
                        phoneController.text,
                        shopeeController.text,
                        tokpedController.text,
                        websiteController.text,
                        nameController.text,
                        "seblak",
                        descController.text,
                        image!,
                        latitude!,
                        longitude!));
                  },
                  text: AppLocalizations.of(context)!.applyShop,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: screenSize.width - 90,
            child: field,
          ),
          GestureDetector(
            onTap: onTap,
            child: Center(
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  color: (isActive) ? bError : bPrimary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icon/regular/times-square.svg',
                    color: bTextPrimary,
                    height: 24.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _checkBox = false;

  Widget _buildCheckBox() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: _checkBox,
              onChanged: (value) {
                setState(() {
                  _checkBox = value!;
                });
              },
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              AppLocalizations.of(context)!.terms,
              style: bBody1.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customCardScedule(
    String day,
    String time,
    Function() editOnTap,
    Function() deleteOnTap,
    bool isClose,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                day,
                style: bSubtitle3.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Text(
                time,
                style: bButton2.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: editOnTap,
                child: Center(
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color: (isClose)
                          ? bPrimary
                          : Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icon/camera-Light.svg',
                        color: (isClose)
                            ? bTextPrimary
                            : Theme.of(context).colorScheme.onTertiary,
                        height: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: deleteOnTap,
                child: Center(
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color: (isClose)
                          ? Theme.of(context).colorScheme.primaryContainer
                          : bError,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icon/camera-Light.svg',
                        color: (isClose)
                            ? Theme.of(context).colorScheme.onTertiary
                            : bTextPrimary,
                        height: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
