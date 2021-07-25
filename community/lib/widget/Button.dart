import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:community/constants/buttonStyle.dart';

class Button extends StatelessWidget {
  String buttonText;
  Function ontap;
  Button({this.buttonText,this.ontap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 55.w,
        alignment: Alignment.center,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [Color(0xff0c00aa), Color(0xff3c00f4)]),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          buttonText,
          style: homePageButtonText,
        ),
      ),
    );
  }
}
