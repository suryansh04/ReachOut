import 'package:community/constants/buttonStyle.dart';
import 'package:community/constants/textStyle.dart';
import 'package:community/screens/Login.dart';
import 'package:community/screens/signup.dart';
import 'package:community/widget/Button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: 
      [
        Expanded(child: SvgPicture.asset('assets/city.svg')),

        SizedBox(
          height: 3.h,
        ),

        Expanded(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [

    Container(
      alignment: Alignment.center,
      child: Text(
      'Hello !',
      style:GoogleFonts.lato(
       textStyle: homePageTextStyle.copyWith(fontSize: 25.sp,color: Colors.black),
      ),
      ),
    ),    

      SizedBox(
        height: 2.h,
      ),

      Text('Help your old neighbours and  \n make a better future',
      style:GoogleFonts.lato(
        textStyle: homePageTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 15.sp,letterSpacing:0.5 ),
      ),
      textAlign: TextAlign.center,
      ),

      SizedBox(
        height: 5.h,
      ),

      GestureDetector(
        onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
        },
        child: Button(buttonText: 'Login'),
      ),

      SizedBox(height: 3.h,),

  GestureDetector(
    onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignupPage()),
);
    },
        child: Container(
          width: 55.w,
          alignment: Alignment.center,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
          border: Border.all(color: Color(0xff3a3380),width:2.0),
          borderRadius: BorderRadius.circular(5.0),
          ),
          child:Text(
            'Signup',
            style:homePageButtonText.copyWith(
              color: Color(0xff3a3380),
            fontWeight: FontWeight.w400,
          ),
        ),
        ),
      ),
       ],
        )
        ),
  
]
      ),
    );
  }
}

