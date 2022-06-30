import 'package:account/presentation/bloc/profile_bloc.dart';
import 'package:account/presentation/screens/edit_account_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:core/core.dart';

// Check

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({Key? key}) : super(key: key);

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  final users = FirebaseFirestore.instance
      .collection("Profile")
      .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
  final snapshot = FirebaseFirestore.instance
      .collection("Profile")
      .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .snapshots();
  final toast = FToast();

  @override
  void initState() {
    super.initState();
    toast.init(context);
    users
        .then(
          (value) => context.read<ProfileBloc>().add(
                OnInit(
                  email: value.docs[0]["email"],
                  fullName: value.docs[0]["fullname"],
                  username: value.docs[0]["username"],
                  imageUrl: value.docs[0]["imgUrl"],
                  id: value.docs[0].reference,
                ),
              ),
        )
        .onError(
          // Text wait localization
          (error, stackTrace) => toastError("Error While Fetch Data"),
        );
  }

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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Aduh...",
        message: "Layar Terlalu Kecil",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildAccountDetailScreen(screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildAccountDetailScreen(screenSize),
      );
    }
  }

  Widget _buildAccountDetailScreen(Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeadingAction(
          // Text wait localization
          title: "Detail Akun",
          leadingIcon: "assets/icon/regular/chevron-left.svg",
          leadingOnTap: () {
            Navigator.pop(
              context,
            );
          },
          actionIcon: "assets/icon/regular/pen.svg",
          actionOnTap: () {
            Navigator.push(
              context,
              PageTransition(
                curve: Curves.easeInOut,
                type: PageTransitionType.rightToLeft,
                child: const EditAccountScreen(),
                duration: const Duration(milliseconds: 150),
                reverseDuration: const Duration(milliseconds: 150),
              ),
            );
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream: snapshot,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      // Text wait localization
                      "Aduh, Terjadi sesuatu, Coba lagi nanti ...",
                      style: bHeading4.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data!.docs.length > 1) {
                  return Center(
                    child: Text(
                      // Text wait localization
                      "Aduh, Data tidak ditemukan..",
                      style: bHeading4.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.horizontalRotatingDots(
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 50.0,
                    ),
                  );
                } else {
                  final userProfile = snapshot.data!.docs[0];

                  return Column(
                    children: <Widget>[
                      _customProfilePict(userProfile["imgUrl"]),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            _customTextContainer(
                              // Text wait localization
                              "Nama Lengkap",
                              userProfile["fullname"],
                            ),
                            _customDivider(),
                            _customTextContainer(
                              // Text wait localization
                              "Username",
                              userProfile["username"],
                            ),
                            _customDivider(),
                            _customTextContainer(
                              // Text wait localization
                              "Email",
                              userProfile["email"],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _customTextContainer(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: bSubtitle2.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: bSubtitle1.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customProfilePict(String picture) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: CachedNetworkImage(
          imageUrl: picture,
          placeholder: (context, url) {
            return Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: Theme.of(context).colorScheme.tertiary,
                size: 24.0,
              ),
            );
          },
          errorWidget: (context, url, error) => Center(
            child: SvgPicture.asset(
              "assets/icon/fill/exclamation-circle.svg",
              color: Theme.of(context).colorScheme.tertiary,
              height: 24.0,
            ),
          ),
          fit: BoxFit.cover,
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }

  Divider _customDivider() {
    return const Divider(
      height: 0,
      thickness: 1.0,
      indent: 20.0,
      endIndent: 20.0,
      color: bStroke,
    );
  }
}
