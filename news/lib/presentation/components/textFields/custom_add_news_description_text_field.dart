import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class CustomAddNewsDescriptionTextField extends StatelessWidget {
  final Function(String item) onChange;
  final TextEditingController? controller;
  const CustomAddNewsDescriptionTextField(
      {Key? key, required this.onChange, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: bSubtitle1.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      minLines: 7,
      maxLines: 7,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        alignLabelWithHint: true,
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
      onChanged: onChange,
    );
  }
}
