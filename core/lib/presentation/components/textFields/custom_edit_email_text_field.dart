import 'package:account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

// Review Check 1 (Done)

class CustomEditEmailTextField extends StatelessWidget {
  const CustomEditEmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, editForm) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          enabled: false,
          initialValue: editForm.email,
          style: bSubtitle1.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          cursorColor: Theme.of(context).colorScheme.tertiary,
          decoration: InputDecoration(
            // Text wait localization
            labelText: "Email",
            errorStyle: bCaption1.copyWith(color: bError),
            hintText: "Batur@gmail.com",
            disabledBorder: bBorderBuilder(bGrey),
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
              ),
              child: SvgPicture.asset(
                "assets/icon/regular/envelope.svg",
                color: Theme.of(context).colorScheme.tertiary,
                height: 24.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
