import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class CustomAddNewsTitleTextField extends StatelessWidget {
  final Function(String item) onChange;
  const CustomAddNewsTitleTextField({Key? key, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: bSubtitle1.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),

      decoration: InputDecoration(
        labelText: "Judul Berita",
        errorStyle: bCaption1.copyWith(color: bError),
        hintText: "Berita",
      ),
      // Validator must be check
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (onChange) {},
    );
  }
}
