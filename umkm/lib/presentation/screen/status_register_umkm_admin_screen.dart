import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:umkm/presentation/screen/umkm_detail_acc_admin_screen.dart';

enum UmkmListAdminScreenProcessEnum { loading, loaded, failed }

class StatusRegisterUmkmAdminScreen extends StatefulWidget {
  const StatusRegisterUmkmAdminScreen({Key? key}) : super(key: key);

  @override
  State<StatusRegisterUmkmAdminScreen> createState() =>
      _StatusRegisterUmkmAdminScreenState();
}

class _StatusRegisterUmkmAdminScreenState
    extends State<StatusRegisterUmkmAdminScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  UmkmListAdminScreenProcessEnum process =
      UmkmListAdminScreenProcessEnum.loading;

  @override
  void initState() {
    super.initState();

    // Must be repair
    if (mounted) {
      setState(() {
        process = UmkmListAdminScreenProcessEnum.loaded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (process == UmkmListAdminScreenProcessEnum.loading) {
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
    } else if (process == UmkmListAdminScreenProcessEnum.failed) {
      return const ErrorScreen(
        title: "AppLocalizations.of(context)!.internetConnection",
        message: "AppLocalizations.of(context)!.tryAgain",
      );
    } else {
      return _buildSuccess(screenSize);
    }
  }

  Widget _buildSuccess(Size screenSize) {
    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Eror",
        message: "Eror",
      );
    } else if (screenSize.width > 500.0) {
      // Mobile Mode
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildLoaded(screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoaded(screenSize),
      );
    }
  }

  Widget _buildAppBar() {
    return CustomSliverAppBarTextLeading(
      // Text wait localization
      title: "UMKM",
      leadingIcon: "assets/icon/regular/chevron-left.svg",
      leadingOnTap: () {
        Navigator.pop(
          context,
        );
      },
    );
  }

  Widget _buildLoaded(Size screenSize) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        _buildAppBar(),
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("UMKM").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: LoadingAnimationWidget.horizontalRotatingDots(
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 50.0,
                    ),
                  );
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final data = snapshot.data!.docs[index];
                    // Use Data News
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: CardStatusRegistrasi(
                        img: data["coverUrl"],
                        title: data["name"],
                        validasi: data["verification"],
                        desc: data["desc"],
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              curve: Curves.easeInOut,
                              type: PageTransitionType.rightToLeft,
                              child: UmkmDetailAccAdminScreen(
                                name: data['name'],
                                coverUrl: data['coverUrl'],
                                address: data['address'],
                                desc: data['desc'],
                                index: data.reference,
                                type: data['desc'],
                                noHp: data['phone'],
                                email: data["email"],
                                web: data["website"],
                                tokped: data["tokped"],
                                shopee: data["shopee"],
                                lat: data["latitude"],
                                long: data["longitude"],
                              ),
                              duration: const Duration(milliseconds: 150),
                              reverseDuration:
                                  const Duration(milliseconds: 150),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
