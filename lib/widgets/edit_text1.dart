import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../utils/themes.dart';

class CustomEditText1 extends StatefulWidget {
  final String hint;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final double width;
  final TextEditingController controller;

  const CustomEditText1({
    Key? key,
    required this.hint,
    required this.validator,
    required this.onSaved,
    required this.width, required this.controller
  }) : super(key: key);

  @override
  State<CustomEditText1> createState() => _CustomEditText1State();
}

class _CustomEditText1State extends State<CustomEditText1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(color: CustomeColors.black2,fontSize: 16),
        obscureText: false,
        validator: widget.validator,
        onSaved: widget.onSaved,
        decoration: ThemesData.inputDecorationTheme(hintText: widget.hint),
      ),
    );
  }
}
