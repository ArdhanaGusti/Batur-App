import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class CustomAddUMKMPhoneTextField extends StatelessWidget {
  const CustomAddUMKMPhoneTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: bSubtitle1.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "No Telp",
        errorStyle: bCaption1.copyWith(color: bError),
        hintText: "021",
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
