import 'dart:io';

import 'package:core/core.dart';
import 'package:news/data/service/api_service.dart';
import 'package:news/presentation/bloc/news_firebase/news_create_bloc.dart';
import 'package:news/presentation/bloc/news_firebase/news_event.dart';
import 'package:news/presentation/bloc/news_firebase/news_state.dart';
import '../components/textFields/custom_add_news_description_text_field.dart';
import '../components/textFields/custom_add_news_title_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  bool isAddedImage = true;
  final toast = FToast();

  File? image;

  String? imageName, judul, konten, urlName;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  void pickImg() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(selectedImage!.path);
      imageName = path.basename(image!.path);
      isAddedImage = false;
      toast.init(context);
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
          child: BlocConsumer<NewsCreateBloc, NewsState>(
            listener: (context, state) async {
              if (state is NewsLoading) {
                Center(
                  child: LoadingAnimationWidget.horizontalRotatingDots(
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 50.0,
                  ),
                );
              } else if (state is NewsCreated) {
                toast.showToast(
                    child: CustomToast(
                      logo: "assets/icon/fill/exclamation-circle.svg",
                      message: state.result,
                      toastColor: bToastSuccess,
                      bgToastColor: bBgToastSuccess,
                      borderToastColor: bBorderToastSuccess,
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: Duration(seconds: 3));
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
                            child: Text(AppLocalizations.of(context)!.back),
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
                  if (judul != null && konten != null && image != null) {
                    context.read<NewsCreateBloc>().add(OnCreateNews(
                        context, image!, imageName!, judul!, konten!));
                    // setState(() {
                    //   image = null;
                    //   imageName = null;
                    // });
                  } else {
                    AlertDialog alert = AlertDialog(
                      title: Text(
                          AppLocalizations.of(context)!.pleaseCompleteData),
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
            onChange: (item) {
              setState(() {
                judul = item;
              });
              if (judul != null) {
                print(judul);
              }
            },
          ),
        ),
        _customEditFormDesc(
          context,
          AppLocalizations.of(context)!.news,
          CustomAddNewsDescriptionTextField(
            onChange: (item) {
              setState(() {
                konten = item;
              });
              if (konten != null) {
                print(konten);
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
              child: (isAddedImage)
                  ? GestureDetector(
                      onTap: pickImg,
                      child: Container(
                        width: 180.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: bStroke)),
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
                                AppLocalizations.of(context)!.inputImage,
                                style: bBody1.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: (image == null)
                                ? Image.network(
                                    "https://cdn-2.tstatic.net/tribunnews/foto/bank/images/indonesiatravel-gedung-sate-salah-satu-ikon-kota-bandung.jpg",
                                    width: 180.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    image!,
                                    width: 180.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  )),
                        const SizedBox(
                          width: 20.0,
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
