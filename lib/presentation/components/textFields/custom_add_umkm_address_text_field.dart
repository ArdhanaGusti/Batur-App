import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class CustomAddUMKMAddressTextField extends StatelessWidget {
  const CustomAddUMKMAddressTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: bSubtitle1.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      decoration: InputDecoration(
        labelText: "Alamat",
        errorStyle: bCaption1.copyWith(color: bError),
        hintText: "Bandung",
      ),
      // Validator must be check
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (text) {},
    );
  }
}
