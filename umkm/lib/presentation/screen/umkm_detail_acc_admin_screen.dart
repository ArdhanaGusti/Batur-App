import 'package:account/account.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:umkm/data/service/api_service.dart';
import 'package:umkm/presentation/bloc/umkm_event.dart';
import 'package:umkm/presentation/bloc/umkm_state.dart';
import 'package:umkm/presentation/bloc/umkm_update_bloc.dart';
import 'package:umkm/presentation/components/costom_detail_umkm_acc.dart';
import 'package:umkm/presentation/screen/umkm_web_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum UmkmDetailAccAdminScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class UmkmDetailAccAdminScreen extends StatefulWidget {
  final String address,
      coverUrl,
      name,
      desc,
      type,
      noHp,
      email,
      web,
      tokped,
      shopee;
  final double lat, long;
  final DocumentReference index;
  const UmkmDetailAccAdminScreen({
    Key? key,
    required this.address,
    required this.web,
    required this.tokped,
    required this.shopee,
    required this.coverUrl,
    required this.name,
    required this.desc,
    required this.type,
    required this.noHp,
    required this.email,
    required this.index,
    required this.lat,
    required this.long,
  }) : super(key: key);

  @override
  State<UmkmDetailAccAdminScreen> createState() =>
      _UmkmDetailAccAdminScreenState();
}

class _UmkmDetailAccAdminScreenState extends State<UmkmDetailAccAdminScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UmkmDetailAccAdminScreenProcessEnum process =
      UmkmDetailAccAdminScreenProcessEnum.loading;
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
  void initState() {
    super.initState();
    toast.init(context);

    // Must be repair
    // Change with to fetch data
    if (mounted) {
      setState(() {
        process = UmkmDetailAccAdminScreenProcessEnum.loaded;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (process == UmkmDetailAccAdminScreenProcessEnum.loading) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildAppBar(),
          ];
        },
        body: Scaffold(
          body: Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: Theme.of(context).colorScheme.tertiary,
              size: 50.0,
            ),
          ),
        ),
      );
    } else if (process == UmkmDetailAccAdminScreenProcessEnum.failed) {
      return ErrorScreen(
        // Wait Localization
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else {
      return _buildScreen(context, screenSize);
    }
  }

  Widget _buildAppBar() {
    return CustomSliverAppBarTextLeading(
      // Text wait localization
      title: widget.name,
      leadingIcon: "assets/icon/regular/chevron-left.svg",
      leadingOnTap: () {
        Navigator.pop(
          context,
        );
      },
    );
  }

  Widget _buildScreen(BuildContext context, Size screenSize) {
    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Eror",
        message: "Eror",
      );
    } else if (screenSize.width > 500.0) {
      // Mobile Mode
      return Scaffold(
        body: Container(
          constraints: const BoxConstraints(maxWidth: 500.0),
          child: _buildLoaded(context, screenSize),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoaded(context, screenSize),
      );
    }
  }

  Widget _buildLoaded(BuildContext context, Size screenSize) {
    return BlocConsumer<UmkmUpdateBloc, UmkmState>(
      listenWhen: (previous, current) {
        return (previous is UmkmLoading) ? true : false;
      },
      listener: (context, state) async {
        if (state is UmkmUpdated) {
          toastSuccess(AppLocalizations.of(context)!.umkmAccepted);
        } else if (state is UmkmError) {
          toastError(AppLocalizations.of(context)!.umkmRejected);
        }
      },
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            _buildAppBar(),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                      stream: (user == null)
                          ? FirebaseFirestore.instance
                              .collection("Favorite")
                              .where("umkm", isEqualTo: widget.name)
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection("Favorite")
                              .where("umkm", isEqualTo: widget.name)
                              .where("email", isEqualTo: user!.email)
                              .where("seller", isEqualTo: widget.email)
                              .snapshots(),
                      builder: (context, fav) {
                        return CustomDetailAccScreen(
                          img: widget.coverUrl,
                          title: widget.name,
                          description: widget.desc,
                          address: widget.address,
                          telephone: widget.noHp,
                          onTap: () {
                            if (user == null) {
                              Navigator.push(
                                context,
                                PageTransition(
                                  curve: Curves.easeInOut,
                                  type: PageTransitionType.bottomToTop,
                                  child: const LoginScreen(),
                                ),
                              );
                            } else {
                              if (fav.data!.docs.isEmpty) {
                                ApiServiceUMKM().addFavorite(
                                  widget.coverUrl,
                                  widget.address,
                                  widget.email,
                                  "",
                                  widget.name,
                                );
                              } else {
                                ApiServiceUMKM().removeFavorite(
                                  fav.data!.docs[0].reference,
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomSecondaryIconTextButton(
                      icon: "assets/icon/tokopedia.svg",
                      width: screenSize.width,
                      text: "Tokopedia",
                      onTap: () {
                        // To WebView
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomSecondaryIconTextButton(
                      icon: "assets/icon/shopee.svg",
                      width: screenSize.width,
                      text: "Shopee",
                      onTap: () {
                        // To WebView
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomSecondaryIconTextButton(
                      icon: "assets/icon/shopee.svg",
                      width: screenSize.width,
                      text: "Website",
                      onTap: () {
                        // To WebView
                        if (widget.web == "") {
                          toastError("Link Tidak Ditemukan");
                        } else {
                          Navigator.push(
                            context,
                            PageTransition(
                              curve: Curves.easeInOut,
                              type: PageTransitionType.rightToLeft,
                              child: UmkmWebScreen(
                                url: "https://pub.dev/packages/photo_view",
                                title: widget.name,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomPrimaryIconTextButton(
                      icon: "assets/icon/fill/pen.svg",
                      width: screenSize.width,
                      text: AppLocalizations.of(context)!.accepted,
                      onTap: () {
                        context.read<UmkmUpdateBloc>().add(
                              OnVerifUmkm(
                                true,
                                widget.index,
                              ),
                            );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomErrorIconTextButton(
                      icon: "assets/icon/fill/trash.svg",
                      width: screenSize.width,
                      text: AppLocalizations.of(context)!.rejected,
                      onTap: () {
                        context.read<UmkmUpdateBloc>().add(
                              OnVerifUmkm(
                                false,
                                widget.index,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
