import 'package:capstone_design/presentation/bloc/profile_bloc.dart';
import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_text_leading_action.dart';
import 'package:capstone_design/presentation/screens/edit_account_screen.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class AccountDetailScreen extends StatelessWidget {
  const AccountDetailScreen({Key? key}) : super(key: key);

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
            child: _buildAccountDetailScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildAccountDetailScreen(context, screenSize),
      );
    }
  }

  Widget _buildAccountDetailScreen(BuildContext context, Size screenSize) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            CustomSliverAppBarTextLeadingAction(
              // Text wait localization
              title: "Detail Akun",
              leadingIcon: "assets/icon/back.svg",
              // Navigation repair
              leadingOnTap: () {
                Navigator.pop(
                  context,
                );
              },
              actionIcon: "assets/icon/pen.svg",
              // Navigation repair
              actionOnTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditAccountScreen(),
                  ),
                );
              },
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverToBoxAdapter(
                // Parameter must change, depends on image use
                // Parameter use Bloc
                child: _customProfilePict("assets/image/profile.jpg"),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      _customTextContainer(
                        context,
                        // Text wait localization
                        "Nama",
                        // Parameter use Bloc
                        "Neida Aleida",
                      ),
                      _customDivider(),
                      _customTextContainer(
                        context,
                        // Text wait localization
                        "Username",
                        // Parameter use Bloc
                        "neidaaleida",
                      ),
                      _customDivider(),
                      _customTextContainer(
                        context,
                        // Text wait localization
                        "Email",
                        // Parameter use Bloc
                        "neidaaleida@gmail.com",
                      ),
                      // Display Password with Obsecure
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _customTextContainer(
    BuildContext context,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: bSubtitle2.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
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

  // Parameter must change
  Widget _customProfilePict(String pict) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        // Use image assets or network
        child: Image.asset(
          pict,
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
