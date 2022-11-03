import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../utils/themes.dart';

class CustomEditText extends StatefulWidget {
  final String hint;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final double width;

  const CustomEditText({
    Key? key,
    required this.hint,
    required this.validator,
    required this.onSaved,
    required this.width
  }) : super(key: key);

  @override
  State<CustomEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: TextFormField(
        style: TextStyle(color: CustomeColors.black2,fontSize: 16),
        obscureText: false,
        validator: widget.validator,
        onSaved: widget.onSaved,
        decoration: ThemesData.inputDecorationTheme(hintText: widget.hint),
      ),
    );
  }
}
