import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class CustomAddUMKMLatituteTextField extends StatelessWidget {
  final TextEditingController latitute;
  const CustomAddUMKMLatituteTextField({Key? key, required this.latitute})
      : super(key: key);

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
      controller: latitute,
      onChanged: (x) {
        print(latitute.text);
      },
    );
  }
}
