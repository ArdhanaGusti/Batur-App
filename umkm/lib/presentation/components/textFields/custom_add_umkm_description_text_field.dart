import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class CustomAddUMKMDescriptionTextField extends StatelessWidget {
  final TextEditingController desc;
  const CustomAddUMKMDescriptionTextField({Key? key, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: bSubtitle1.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      minLines: 7,
      maxLines: 7,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: "Dekripsi Toko",
        errorStyle: bCaption1.copyWith(color: bError),
        hintText: "Dekripsi Toko",
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
      controller: desc,
    );
  }
}
