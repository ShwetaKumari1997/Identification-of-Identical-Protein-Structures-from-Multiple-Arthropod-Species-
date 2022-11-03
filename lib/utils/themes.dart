import 'package:flutter/material.dart';
import 'package:protein_database/utils/colors.dart';

class ThemesData{

  static InputDecoration inputDecorationTheme({required String hintText}) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: CustomeColors.black),
      gapPadding: 10,
    );
    return InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
        isDense: true,
        labelText: hintText,
        hintText: hintText,
        hintStyle: TextStyle(color: CustomeColors.black,fontSize: 14),
        labelStyle: TextStyle(color: CustomeColors.black,fontSize: 14),
        contentPadding: EdgeInsets.symmetric(horizontal: 18,vertical: 20)
    );
  }



}


