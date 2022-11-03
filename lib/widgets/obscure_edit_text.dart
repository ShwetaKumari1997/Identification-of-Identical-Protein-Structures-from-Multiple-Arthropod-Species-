import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../utils/themes.dart';

class ObscureEditText extends StatefulWidget {
  final String hint;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final double width;
  final bool obscure;

  const ObscureEditText({
    Key? key,
    required this.hint,
    required this.validator,
    required this.onSaved,
    required this.width,
    required this.obscure
  }) : super(key: key);

  @override
  State<ObscureEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<ObscureEditText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: TextFormField(
        style: TextStyle(color: CustomeColors.black2,fontSize: 16),
        obscureText: widget.obscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: CustomeColors.black),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: CustomeColors.black),
              gapPadding: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: CustomeColors.black),
              gapPadding: 10,
            ),
            isDense: true,
            labelText: widget.hint,
            hintText: widget.hint,
            hintStyle: TextStyle(color: CustomeColors.black,fontSize: 14),
            labelStyle: TextStyle(color: CustomeColors.black,fontSize: 14),
            contentPadding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                widget.obscure
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                });
              },
            )

        ),
      ),
    );
  }
}