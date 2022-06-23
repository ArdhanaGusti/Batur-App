import 'package:account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomRegisFullNameTextField extends StatelessWidget {
  const CustomRegisFullNameTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisFormBloc, RegisFormState>(
      builder: (context, regisForm) {
        return TextFormField(
          initialValue: regisForm.fullName,
          style: bSubtitle1.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          cursorColor: Theme.of(context).colorScheme.tertiary,
          decoration: InputDecoration(
            labelText: "Full Name",
            errorStyle: bCaption1.copyWith(color: bError),
            hintText: "Bandung Tourism",
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
              ),
              child: SvgPicture.asset(
                "assets/icon/user_outline.svg",
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
                  RegisFormFullNameChanged(
                    fullName: text,
                  ),
                );
          },
        );
      },
    );
  }
}
