import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/data/sources/theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TourUMKMMapsScreen extends StatefulWidget {
  const TourUMKMMapsScreen({Key? key}) : super(key: key);

  @override
  State<TourUMKMMapsScreen> createState() => _TourUMKMMapsScreenState();
}

class _TourUMKMMapsScreenState extends State<TourUMKMMapsScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return ErrorScreen(
        // Text wait localization
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
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          CustomSliverAppBarTextLeadingAction(
            // Text wait localization
            title: AppLocalizations.of(context)!.tourAndUmkm,
            leadingIcon: "assets/icon/back.svg",
            // Navigation repair
            leadingOnTap: () {
              Navigator.pop(
                context,
              );
            },
            actionIcon: "assets/icon/bold/menu.svg",
            actionOnTap: () {},
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Stack(
              children: <Widget>[
                Container(
                  color: _color,
                ),
                _customDropDown(context, screenSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double turns = 0.0;

  void _changeRotation() {
    setState(() => turns += 1.0 / 2.0);
  }

  Widget _customDropDown(BuildContext context, Size screenSize) {
    final List<String> _tags = [
      AppLocalizations.of(context)!.tour,
      AppLocalizations.of(context)!.umkm,
      AppLocalizations.of(context)!.all,
    ];
    String _tag = AppLocalizations.of(context)!.all;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          if (_isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        },
        child: Container(
          key: _key,
          width: 120.0,
          height: 30.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _tag,
                style: bSubtitle1.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              AnimatedRotation(
                turns: turns,
                duration: const Duration(microseconds: 500),
                child: SvgPicture.asset(
                  "assets/icon/regular/chevron-down.svg",
                  color: bTextPrimary,
                  height: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey _key = LabeledGlobalKey("button");
  late OverlayEntry _overlayEntry;
  late Size _buttonSize;
  late Offset _buttonPosition;
  bool _isMenuOpen = false;

  Color _color = Colors.red;

  final List<Color> _colors = [
    Colors.amber,
    Colors.green,
    Colors.red,
  ];

  findButton() {
    RenderBox? renderBox =
        _key.currentContext!.findRenderObject() as RenderBox?;
    _buttonSize = renderBox!.size;
    _buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void openMenu() {
    findButton();
    _changeRotation();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry);
    _isMenuOpen = !_isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry.remove();
    _changeRotation();
    _isMenuOpen = !_isMenuOpen;
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        final List<String> _tags = [
          AppLocalizations.of(context)!.tour,
          AppLocalizations.of(context)!.umkm,
          AppLocalizations.of(context)!.all,
        ];
        String _tag = AppLocalizations.of(context)!.all;
        return Positioned(
          top: _buttonPosition.dy + _buttonSize.height,
          left: _buttonPosition.dx,
          width: _buttonSize.width,
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: _tags.length * 30.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      _tags.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _color = _colors[index];
                              _tag = _tags[index];
                            });
                            closeMenu();
                          },
                          child: SizedBox(
                            width: _buttonSize.width,
                            height: _buttonSize.height,
                            child: Center(
                              child: Text(
                                _tags[index],
                                style: bBody1.copyWith(
                                  color: bTextPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
