import 'package:account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

// Review Check 1 (Done)

class CustomEditFullNameTextField extends StatelessWidget {
  const CustomEditFullNameTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, editForm) {
        return TextFormField(
          initialValue: editForm.fullName,
          style: bSubtitle1.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          cursorColor: Theme.of(context).colorScheme.tertiary,
          decoration: InputDecoration(
            // Text wait localization
            labelText: "Full Name",
            errorStyle: bCaption1.copyWith(color: bError),
            hintText: "Bandung Tourism",
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
              // Text wait localization
              return 'Please enter some text';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (text) {
            // Bloc
            context.read<ProfileBloc>().add(
                  ProfileFormFullNameChanged(
                    fullName: text,
                  ),
                );
          },
        );
      },
    );
  }
}
