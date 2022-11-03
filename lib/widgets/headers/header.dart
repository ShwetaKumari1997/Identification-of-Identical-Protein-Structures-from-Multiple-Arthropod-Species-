import 'package:flutter/material.dart';
import 'package:protein_database/utils/colors.dart';

class Header extends StatefulWidget {
  final VoidCallback backPressed;
  final String headerText;
  final Color backgroundColor;
  const Header({Key? key, required this.backPressed, required this.headerText, required this.backgroundColor}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: widget.backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 10),
          IconButton(onPressed: widget.backPressed, icon: Icon(Icons.arrow_back,size: 25,color: CustomeColors.white,)),
          SizedBox(width: 20),
          Text(widget.headerText,style: TextStyle(color: CustomeColors.white,fontSize: 18,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
