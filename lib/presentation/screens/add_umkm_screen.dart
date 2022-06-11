import 'dart:io';

import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_text_leading.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_icon_text_button.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/components/textFields/custom_add_umkm_address_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_add_umkm_description_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_add_umkm_name_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_add_umkm_phone_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_add_umkm_shopee_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_add_umkm_tokopedia_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_add_umkm_website_text_field.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/presentation/screens/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:theme/theme.dart';

class AddUMKMScreen extends StatefulWidget {
  const AddUMKMScreen({Key? key}) : super(key: key);

  @override
  State<AddUMKMScreen> createState() => _AddUMKMScreenState();
}

class _AddUMKMScreenState extends State<AddUMKMScreen> {
  List<String> days = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
  ];
  List<String> images = [
    "https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2022/03/11/4072812075.jpg",
    "https://akcdn.detik.net.id/visual/2022/03/30/seulgi-red-velvet-1_169.jpeg?w=650",
    "https://ecs7.tokopedia.net/blog-tokopedia-com/uploads/2021/01/scmc.jpg",
    "https://media.suara.com/pictures/970x544/2020/08/19/24987-wendy-red-velvet-soompi.jpg",
  ];
  List<String> time = [
    "07.00 - 16.00",
    "07.00 - 16.00",
    "07.00 - 16.00",
    "07.00 - 16.00",
  ];
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
      return const ErrorScreen(
        // Text wait localization
        title: "Error Layar",
        message: "Aduh, Layar anda terlalu kecil",
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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: "Daftar UMKM",
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
          // Text wait localization
          "Nama Toko*",
          const CustomAddUMKMNameTextField(),
        ),
        _customEditFormDesc(
          context,
          // Text wait localization
          "Deskripsi Toko*",
          const CustomAddUMKMDescriptionTextField(),
        ),
        _customEditForm(
          context,
          // Text wait localization
          "No Telepon*",
          const CustomAddUMKMPhoneTextField(),
        ),
        _customEditForm(
          context,
          // Text wait localization
          "Alamat*",
          const CustomAddUMKMAddressTextField(),
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
              onTap: () {},
              text: 'Lokasi saya',
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
                  "Gambar",
                  style: bHeading7.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                (imageList == null)
                    ? Container(
                        width: 150.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
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
                                color: Theme.of(context).colorScheme.tertiary,
                                height: 24.0,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Masukkan Gambar",
                                style: bBody1.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 80.0,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: imageList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GalleryScreen(
                                        images: imageList!,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                child: Image.file(
                                  imageList![index],
                                  width: 150.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomPrimaryIconTextButton(
                  icon: 'assets/icon/fill/log-out.svg',
                  onTap: () => pickImage(),
                  text: 'Upload Gambar',
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
                  "Jadwal",
                  style: bHeading7.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _customCardScedule(
                  days[index],
                  time[index],
                  () {},
                  () {},
                  isClose[index],
                );
              },
              childCount: isClose.length, // 1000 list items
            ),
          ),
        ),
        _customEditFormLink(context, "Link Online Shop", screenSize),
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
              onTap: () {},
              text: 'Ajukan Toko',
              width: screenSize.width,
            ),
          ),
        ),
      ],
    );
  }

  File? image;
  List<File>? imageList;
  List<String> imageString = [];

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickMultiImage();

      if (image == null) return;
      final imageTemp = image.map<File>((xfile) => File(xfile.path)).toList();

      setState(() {
        imageList = imageTemp;
      });
    } on PlatformException catch (e) {
      print("Failed pick Image: $e");
    }
  }

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
                    const CustomAddUMKMTokopediaTextField(),
                    () {},
                    true,
                    screenSize),
                _customSmallContainerLink(
                    context,
                    const CustomAddUMKMShopeeTextField(),
                    () {},
                    true,
                    screenSize),
                _customSmallContainerLink(
                    context,
                    const CustomAddUMKMWebsiteTextField(),
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
          // Text wait localization
          Flexible(
            child: Text(
              "Dengan ini saya menyetujui persyaratan dan ketentuan yang ada",
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
                        'assets/icon/pen-Light.svg',
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
                        'assets/icon/trash-Light.svg',
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
