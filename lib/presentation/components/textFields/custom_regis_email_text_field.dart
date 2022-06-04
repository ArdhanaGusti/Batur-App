import 'package:capstone_design/presentation/bloc/regis_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomRegisEmailTextField extends StatelessWidget {
  const CustomRegisEmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisFormBloc, RegisFormState>(
      builder: (context, regisForm) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          initialValue: regisForm.email,
          style: bSubtitle1.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          decoration: InputDecoration(
            labelText: "Email",
            errorStyle: bCaption1.copyWith(color: bError),
            hintText: "Batur@gmail.com",
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
              ),
              child: SvgPicture.asset(
                "assets/icon/envelope.svg",
                color: Theme.of(context).colorScheme.tertiary,
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
            context.read<RegisFormBloc>().add(
                  RegisFormEmailChanged(
                    email: text,
                  ),
                );
          },
        );
      },
    );
  }
}
