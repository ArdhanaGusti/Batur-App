import 'package:account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

// Review Check 1 (Done)

class CustomLoginUsernameTextField extends StatelessWidget {
  const CustomLoginUsernameTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, loginForm) {
        return TextFormField(
          initialValue: loginForm.email,
          cursorColor: Theme.of(context).colorScheme.tertiary,
          style: bSubtitle1.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          decoration: InputDecoration(
            // Wait Localization
            labelText: "Username / Email",
            errorStyle: bCaption1.copyWith(color: bError),
            // Wait Localization
            hintText: "batur / Batur@gmail.com",
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
              ),
              child: SvgPicture.asset(
                "assets/icon/regular/user.svg",
                color: Theme.of(context).colorScheme.tertiary,
                height: 24.0,
              ),
            ),
          ),
          // Validator must be check
          validator: (text) {
            if (text == null || text.isEmpty) {
              // Wait Localization
              return "Please enter some text";
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (text) {
            context.read<LoginFormBloc>().add(
                  LoginFormEmailChanged(
                    email: text,
                  ),
                );
          },
        );
      },
    );
  }
}
