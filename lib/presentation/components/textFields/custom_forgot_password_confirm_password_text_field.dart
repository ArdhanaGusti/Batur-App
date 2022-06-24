import 'package:capstone_design/presentation/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomForgotPasswordConfirmPasswordTextField extends StatelessWidget {
  const CustomForgotPasswordConfirmPasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordFormBloc, ForgotPasswordFormState>(
      builder: (context, forgotPassForm) {
        return TextFormField(
          initialValue: forgotPassForm.passwordConf,
          obscureText: forgotPassForm.obsecurePasswordConf,
          style: bSubtitle1.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          cursorColor: Theme.of(context).colorScheme.tertiary,
          decoration: InputDecoration(
            labelText: "Konfirmasi Password",
            errorStyle: bCaption1.copyWith(color: bError),
            disabledBorder: bBorderBuilder(bGrey),
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 20.0),
              child: GestureDetector(
                onTap: (() => context.read<ForgotPasswordFormBloc>().add(
                      ForgotPasswordFormObsecurePasswordConfChanged(
                        obsecureConf: !forgotPassForm.obsecurePasswordConf,
                      ),
                    )),
                child: SvgPicture.asset(
                  (forgotPassForm.obsecurePasswordConf)
                      ? "assets/icon/eye.svg"
                      : "assets/icon/eye-slash.svg",
                  color: Theme.of(context).colorScheme.tertiary,
                  height: 24.0,
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
                color: Theme.of(context).colorScheme.tertiary,
                height: 24.0,
              ),
            ),
          ),
          // Validator must be check
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please enter some text';
            } else if (text.length < 7) {
              return 'Length must be min 8 char';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (text) => context.read<ForgotPasswordFormBloc>().add(
                ForgotPasswordFormPasswordConfChanged(
                  passwordConf: text,
                ),
              ),
        );
      },
    );
  }
}
