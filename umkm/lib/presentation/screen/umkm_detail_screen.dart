import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:umkm/presentation/bloc/umkm_remove_bloc.dart';
import 'package:umkm/presentation/bloc/umkm_state.dart';
import 'package:umkm/presentation/bloc/umkm_event.dart';
import 'package:page_transition/page_transition.dart';

enum UmkmDetailScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class UmkmDetailScreen extends StatefulWidget {
  final String address, coverUrl, name, desc, type, noHp;
  final DocumentReference index;
  const UmkmDetailScreen(
      {Key? key,
      required this.address,
      required this.coverUrl,
      required this.name,
      required this.desc,
      required this.type,
      required this.noHp,
      required this.index})
      : super(key: key);

  @override
  State<UmkmDetailScreen> createState() => _UmkmDetailScreenState();
}

class _UmkmDetailScreenState extends State<UmkmDetailScreen> {
  UmkmDetailScreenProcessEnum process = UmkmDetailScreenProcessEnum.loaded;

  // @override
  // void initState() {
  //   super.initState();

  //   // Must be repair
  //   // Change with to fetch data
  //   Timer(const Duration(seconds: 2), () {
  //     // Change state value if data loaded or failed
  //     setState(() {
  //       process = UmkmDetailScreenProcessEnum.loaded;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (process == UmkmDetailScreenProcessEnum.loading) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
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
    } else if (process == UmkmDetailScreenProcessEnum.failed) {
      return const ErrorScreen(
        title: "AppLocalizations.of(context)!.oops",
        message: "AppLocalizations.of(context)!.screenSmall",
      );
    } else {
      return _buildScreen(context, screenSize);
    }
  }

  Widget _buildAppBar() {
    return CustomSliverAppBarTextLeading(
      // Text wait localization
      title: "Transportasi Umum Detail",
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
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoaded(context, screenSize),
      );
    }
  }

  Widget _buildLoaded(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        _buildAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverToBoxAdapter(
              child: Column(
            children: [
              CustomDetailScreen(
                img: widget.coverUrl,
                title: widget.name,
                isFavorite: '155',
                description: widget.desc,
                address: widget.address,
                telephone: widget.noHp,
                onTap: () {
                  print("Container clicked");
                },
              ),
              SizedBox(
                height: 15,
              ),
              CustomSecondaryIconTextButton(
                icon: "assets/icon/tokopedia.svg",
                width: screenSize.width,
                text: "Tokopedia",
                onTap: () {
                  // Navigator.pop(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Login(),
                  //   ),
                  // );
                },
              ),
              SizedBox(
                height: 15,
              ),
              CustomSecondaryIconTextButton(
                icon: "assets/icon/shopee.svg",
                width: screenSize.width,
                text: "Shopee",
                onTap: () {
                  // Navigator.pop(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Login(),
                  //   ),
                  // );
                },
              ),
              SizedBox(
                height: 15,
              ),
              CustomSecondaryIconTextButton(
                icon: "assets/icon/shopee.svg",
                width: screenSize.width,
                text: "Website",
                onTap: () {
                  // Navigator.pop(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Login(),
                  //   ),
                  // );
                },
              ),
            ],
          )),
        ),
      ],
    );
  }
}
