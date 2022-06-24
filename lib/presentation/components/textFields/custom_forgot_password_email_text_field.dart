import 'package:capstone_design/presentation/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomForgotPasswordEmailTextField extends StatelessWidget {
  final bool enable;
  const CustomForgotPasswordEmailTextField({
    Key? key,
    required this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordFormBloc, ForgotPasswordFormState>(
      builder: (context, regisForm) {
        return TextFormField(
          enabled: enable,
          keyboardType: TextInputType.emailAddress,
          initialValue: regisForm.email,
          style: bSubtitle1.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          cursorColor: Theme.of(context).colorScheme.tertiary,
          decoration: InputDecoration(
            labelText: "Email",
            errorStyle: bCaption1.copyWith(color: bError),
            hintText: "Batur@gmail.com",
            enabled: enable,
            disabledBorder: bBorderBuilder(bGrey),
            fillColor: (enable)
                ? Theme.of(context).colorScheme.secondaryContainer
                : bStroke,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
              ),
              child: SvgPicture.asset(
                "assets/icon/envelope.svg",
                color:
                    (enable) ? Theme.of(context).colorScheme.tertiary : bGrey,
                height: 24.0,
              ),
            ),
          ),
          // Validator must be check
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (text) {
            context.read<ForgotPasswordFormBloc>().add(
                  ForgotPasswordFormEmailChanged(
                    email: text,
                  ),
                );
          },
        );
      },
    );
  }
}
