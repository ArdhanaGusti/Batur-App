import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class CustomAddUMKMNameTextField extends StatelessWidget {
  final TextEditingController name;

  const CustomAddUMKMNameTextField({Key? key, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: bSubtitle1.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),

      decoration: InputDecoration(
        labelText: "Nama Toko",
        errorStyle: bCaption1.copyWith(color: bError),
        hintText: "Bandung Shop",
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
      controller: name,
    );
  }
}
