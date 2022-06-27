import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:news/data/service/api_service.dart';
import 'package:news/news.dart';
import 'package:news/presentation/bloc/news_create_bloc.dart';
import 'package:news/presentation/bloc/news_event.dart';
import 'package:news/presentation/bloc/news_state.dart';
import '../components/textFields/custom_add_news_description_text_field.dart';
import '../components/textFields/custom_add_news_title_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/service/api_service.dart';

class EditNewsScreen extends StatefulWidget {
  final String judul, konten, urlName;
  final DocumentReference index;
  const EditNewsScreen(
      {Key? key,
      required this.judul,
      required this.konten,
      required this.urlName,
      required this.index})
      : super(key: key);

  @override
  State<EditNewsScreen> createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {
  bool isAddedImage = false;

  ApiServiceNews apiService = ApiServiceNews();
  File? imageNow;
  String? imageNameNow, judulNow, kontenNow, urlNameNow;
  TextEditingController? titlecontroller;
  TextEditingController? contentcontroller;
  final DateTime _dateTime = DateTime.now();

  String? imageName, judul, konten, urlName;

  @override
  void initState() {
    judulNow = widget.judul;
    kontenNow = widget.konten;
    urlNameNow = widget.urlName;
    titlecontroller = TextEditingController(text: widget.judul);
    contentcontroller = TextEditingController(text: widget.konten);
    super.initState();
  }

  void pickImg() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageNow = File(selectedImage!.path);
      imageName = basename(imageNow!.path);
      isAddedImage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildSettingScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildSettingScreen(context, screenSize),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<NewsUpdateBloc, NewsState>(
            listener: (context, state) async {
              if (state is NewsLoading) {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: CircularProgressIndicator(),
                // ));
              } else if (state is NewsCreated) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.result),
                ));
              } else if (state is NewsError) {
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
              return CustomPrimaryTextButton(
                width: screenSize.width,
                text: AppLocalizations.of(context)!.save,
                onTap: () async {
                  if (judulNow != null && kontenNow != null) {
                    // ApiServiceNews()
                    //     .sendNews(context, imageNow!, imageNameNow!, judulNow, kontenNow);
                    context.read<NewsUpdateBloc>().add(OnUpdateNews(
                        context,
                        imageNow,
                        imageNameNow,
                        kontenNow!,
                        judulNow!,
                        urlNameNow!,
                        widget.index));
                    setState(() {
                      imageNow = null;
                      imageNameNow = null;
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
              );
            },
          ),
        ),
      );
    }
  }

  Widget _buildSettingScreen(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          title: AppLocalizations.of(context)!.addNews,
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
          AppLocalizations.of(context)!.newsTitle,
          CustomAddNewsTitleTextField(
            controller: titlecontroller,
            onChange: (item) {
              setState(() {
                judulNow = item;
              });
              if (judul != null) {
                print(judulNow);
              }
            },
          ),
        ),
        _customEditFormDesc(
          context,
          AppLocalizations.of(context)!.news,
          CustomAddNewsDescriptionTextField(
            controller: contentcontroller,
            onChange: (item) {
              setState(() {
                kontenNow = item;
              });
              if (kontenNow != null) {
                print(kontenNow);
              }
            },
          ),
        ),
        _customEditImage(
          context,
          AppLocalizations.of(context)!.image,
          // CustomAddNewsDescriptionTextField(),
        ),
      ],
    );
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

  Widget _customEditImage(BuildContext context, String title) {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: (imageNow == null)
                          ? CachedNetworkImage(
                              imageUrl: widget.urlName,
                              width: 180.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              imageNow!,
                              width: 180.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  GestureDetector(
                    onTap: pickImg,
                    child: Center(
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icon/trash-Light.svg",
                            color: bError,
                            height: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
