import 'package:capstone_design/presentation/bloc/login_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomLoginUsernameTextField extends StatelessWidget {
  final bool isLight;
  const CustomLoginUsernameTextField({
    Key? key,
    required this.isLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
          style:
              bSubtitle1.copyWith(color: (isLight) ? bPrimary : bTextPrimary),
          decoration: InputDecoration(
            labelText: "Username / Email",
            errorStyle: bCaption1.copyWith(color: bError),
            hintText: "batur / Batur@gmail.com",
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
              ),
              child: SvgPicture.asset(
                "assets/icon/user_outline.svg",
                color: (isLight) ? bPrimary : bTextPrimary,
                height: 24,
              ),
            ),
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please enter some text';
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
