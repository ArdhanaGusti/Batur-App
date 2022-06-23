import 'package:capstone_design/presentation/bloc/verification_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class CustomVerificationTextField extends StatelessWidget {
  final FocusNode focusNow;
  final FocusNode focusNext;
  final int field;
  const CustomVerificationTextField({
    Key? key,
    required this.focusNow,
    required this.focusNext,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationFormBloc, VerificationFormState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            width: 60.0,
            height: 80.0,
            child: TextFormField(
              cursorColor: Theme.of(context).colorScheme.tertiary,
              focusNode: focusNow,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              autofocus: true,
              textAlign: TextAlign.center,
              style: bHeading6.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              textAlignVertical: TextAlignVertical.center,
              maxLength: 1,
              decoration: InputDecoration(
                isDense: false,
                border: _borderBuilder(bStroke),
                enabledBorder: _borderBuilder(bStroke),
                errorBorder: _borderBuilder(bError),
                focusedErrorBorder: _borderBuilder(bError),
                focusedBorder: _borderBuilder(
                  Theme.of(context).colorScheme.tertiary,
                ),
                disabledBorder: _borderBuilder(bStroke),
                counterStyle: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onFieldSubmitted: (value) {
                context.read<VerificationFormBloc>().add(
                      VerificationInputNumber(
                        number: value,
                        numberField: field,
                      ),
                    );
                if (focusNow == focusNext) {
                  FocusScope.of(context).unfocus();
                } else {
                  FocusScope.of(context).requestFocus(focusNext);
                }
              },
              onChanged: (value) {
                if (value.length == 1) {
                  context.read<VerificationFormBloc>().add(
                        VerificationInputNumber(
                          number: value,
                          numberField: field,
                        ),
                      );
                  if (focusNow == focusNext) {
                    FocusScope.of(context).unfocus();
                  } else {
                    FocusScope.of(context).requestFocus(focusNext);
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  // border
  OutlineInputBorder _borderBuilder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(11.0)),
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );
  }
}
