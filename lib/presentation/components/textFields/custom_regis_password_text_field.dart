import 'package:capstone_design/presentation/bloc/regis_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomRegisPasswordTextField extends StatelessWidget {
  const CustomRegisPasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisFormBloc, RegisFormState>(
      builder: (context, regisForm) {
        return TextFormField(
          initialValue: regisForm.password,
          obscureText: regisForm.obsecurePassword,
          style: bSubtitle1.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          decoration: InputDecoration(
            labelText: "Password",
            errorStyle: bCaption1.copyWith(color: bError),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 20.0),
              child: GestureDetector(
                onTap: (() => context.read<RegisFormBloc>().add(
                      RegisFormObsecurePasswordChanged(
                        obsecure: !regisForm.obsecurePassword,
                      ),
                    )),
                child: SvgPicture.asset(
                  (regisForm.obsecurePassword)
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
          onChanged: (text) => context.read<RegisFormBloc>().add(
                RegisFormPasswordChanged(
                  password: text,
                ),
              ),
        );
      },
    );
  }
}
