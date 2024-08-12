import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommanWidgets {
  static Color textheadingcolor = const Color.fromRGBO(28, 13, 18, 1);
  static Color textsubheadingcolor = const Color.fromRGBO(150, 79, 102, 1);
  static Color backgroundcolor = const Color.fromRGBO(252, 247, 250, 1);
  static Color boxbackgroundcolor = const Color.fromRGBO(242, 232, 235, 1);

  static PreferredSizeWidget myAppBar(String title, BuildContext context) {
    return AppBar(
      backgroundColor: backgroundcolor,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.epilogue(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: textheadingcolor,
        ),
      ),
    );
  }

  static void flushBarSuccessMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          icon: Icon(
            Icons.done_all,
            color: textheadingcolor,
          ),
          backgroundColor: boxbackgroundcolor,
          message: message,
          messageColor: textheadingcolor,
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(12),
          duration: const Duration(seconds: 3),
          forwardAnimationCurve: Curves.decelerate,
        )..show(context));
  }

  static void streakSuccessMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          icon: Icon(
            Icons.insights,
            color: textheadingcolor,
          ),
          backgroundColor: boxbackgroundcolor,
          message: message,
          messageColor: textheadingcolor,
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(12),
          duration: const Duration(seconds: 3),
          forwardAnimationCurve: Curves.decelerate,
        )..show(context));
  }

  static void rewardSuccessMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          icon: Icon(
            Icons.celebration,
            color: textheadingcolor,
          ),
          backgroundColor: boxbackgroundcolor,
          message: message,
          animationDuration: Durations.long1,
          messageColor: textheadingcolor,
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(12),
          duration: const Duration(seconds: 3),
          forwardAnimationCurve: Curves.decelerate,
        )..show(context));
  }

  static mybutton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CommanWidgets.boxbackgroundcolor,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: textheadingcolor,
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {},
          child: Text(
            "Get Started",
            style: GoogleFonts.epilogue(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: textheadingcolor,
            ),
          ),
        ),
      ),
    );
  }
}
