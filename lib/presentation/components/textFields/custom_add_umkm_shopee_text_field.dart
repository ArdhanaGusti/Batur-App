import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomAddUMKMShopeeTextField extends StatelessWidget {
  const CustomAddUMKMShopeeTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: bSubtitle1.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      decoration: InputDecoration(
        labelText: "Shopee",
        errorStyle: bCaption1.copyWith(color: bError),
        hintText: "Shopee",
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 15.0,
          ),
          child: SvgPicture.asset(
            "assets/icon/shopee.svg",
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
      onChanged: (text) {},
    );
  }
}
