import 'package:capstone_design/presentation/bloc/login_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomLoginPasswordTextField extends StatelessWidget {
  final bool isLight;
  const CustomLoginPasswordTextField({
    Key? key,
    required this.isLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password,
          obscureText: state.obsecurePassword,
          style:
              bSubtitle1.copyWith(color: (isLight) ? bPrimary : bTextPrimary),
          decoration: InputDecoration(
            labelText: "Password",
            errorStyle: bCaption1.copyWith(color: bError),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 20.0),
              child: GestureDetector(
                onTap: (() => context.read<LoginFormBloc>().add(
                      LoginFormObsecurePasswordChanged(
                        obsecure: !state.obsecurePassword,
                      ),
                    )),
                child: SvgPicture.asset(
                  (state.obsecurePassword)
                      ? "assets/icon/eye.svg"
                      : "assets/icon/eye-slash.svg",
                  color: (isLight) ? bPrimary : bTextPrimary,
                  height: 24,
                ),
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
              ),
              child: SvgPicture.asset(
                "assets/icon/lock.svg",
                color: (isLight) ? bPrimary : bTextPrimary,
                height: 24,
              ),
            ),
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please enter some text';
            } else if (text.length < 7) {
              return 'Length must be min 8 char';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (text) => context.read<LoginFormBloc>().add(
                LoginFormPasswordChanged(
                  password: text,
                ),
              ),
        );
      },
    );
  }
}
