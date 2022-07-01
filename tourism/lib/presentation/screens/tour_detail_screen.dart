import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';
import 'package:tourism/presentation/components/custom_card_detail_tour_screen.dart';

enum TourDetailScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class TourDetailScreen extends StatefulWidget {
  const TourDetailScreen({Key? key}) : super(key: key);

  @override
  State<TourDetailScreen> createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  TourDetailScreenProcessEnum process = TourDetailScreenProcessEnum.loading;

  final List<String> carouselImages = [
    "https://thumb.viva.co.id/media/frontend/thumbs3/2022/03/23/623b099186419-red-velvet_665_374.jpg",
    "https://awsimages.detik.net.id/visual/2020/09/15/noah-15.jpeg?w=650",
    "https://media.suara.com/pictures/653x366/2022/02/09/60554-isyana-sarasvati-instagramatisyanasarasvati.jpg",
  ];

  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {
        process = TourDetailScreenProcessEnum.loaded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (process == TourDetailScreenProcessEnum.loading) {
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
    } else if (process == TourDetailScreenProcessEnum.failed) {
      return const ErrorScreen(
        title: "AppLocalizations.of(context)!.oops",
        message: "Failed",
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
      title: "Wisata Detail",
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
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        _buildAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                CustomCardDetailTourScreen(
                  img:
                      'https://majalahpeluang.com/wp-content/uploads/2021/03/584ukm-bandung-ayobandung.jpg',
                  title: 'Contrary to popular belief',
                  rating: '4,5',
                  isFavourited: false,
                  carouselImages: carouselImages,
                  description:
                      'Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung, di Kebonjeruk, Andir, tepatnya di perbatasan antara Kelurahan Pasirkaliki, Cicendo dan Kebonjeruk, Andir, Kota Bandung, Jawa Barat.',
                  address: 'Jl. Trunojoyo No. 64 Bandung',
                  telephone: '(022) 4208757',
                  onTap: () {
                    print("Container clicked");
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Jadwal',
                        style: bHeading7.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Senin',
                            style: bSubtitle3.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            '07.00 - 16.00',
                            style: bSubtitle3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Selasa',
                            style: bSubtitle3.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            '07.00 - 16.00',
                            style: bSubtitle3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Rabu',
                            style: bSubtitle3.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            '07.00 - 16.00',
                            style: bSubtitle3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'kamis',
                            style: bSubtitle3.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            '07.00 - 16.00',
                            style: bSubtitle3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Jumat',
                            style: bSubtitle3.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            '07.00 - 16.00',
                            style: bSubtitle3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Sabtu',
                            style: bSubtitle3.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            '07.00 - 16.00',
                            style: bSubtitle3,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomPrimaryIconTextButton(
                  icon: "assets/icon/fill/map-marker.svg",
                  width: screenSize.width,
                  text: "Petunjuk Arah",
                  onTap: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomSecondaryIconTextButton(
                  icon: "assets/icon/fill/coupon.svg",
                  width: screenSize.width,
                  text: "Dapatkan Tiket",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
