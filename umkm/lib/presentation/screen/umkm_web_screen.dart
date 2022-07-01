import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UmkmWebScreen extends StatelessWidget {
  const UmkmWebScreen({Key? key}) : super(key: key);

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
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          title: "Detail",
          leadingIcon: "assets/icon/back.svg",
          // Navigation repair
          leadingOnTap: () {
            Navigator.pop(
              context,
            );
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: screenSize.height - 80,
            child: const WebView(
              initialUrl:
                  'https://endpts.com/pfizers-paxlovid-doesnt-stack-up-as-well-for-those-who-are-vaccinated-new-data-show/',
            ),
          ),
        ),
      ],
    );
  }
}
