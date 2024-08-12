import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:urbanculture/utills/comman_widgets.dart';
import 'package:urbanculture/utills/linechart.dart';
import '../provider/skincareprovider.dart';

class Streakscreen extends StatefulWidget {
  const Streakscreen({super.key});

  @override
  State<Streakscreen> createState() => _StreakscreenState();
}

class _StreakscreenState extends State<Streakscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommanWidgets.backgroundcolor,
      appBar: CommanWidgets.myAppBar("Streaks", context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Today's Goal: 3 streak days",
                style: GoogleFonts.epilogue(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: CommanWidgets.textheadingcolor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CommanWidgets.boxbackgroundcolor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Streak Days",
                        style: GoogleFonts.epilogue(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: CommanWidgets.textheadingcolor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Consumer<SkincareProvider>(
                          builder: (context, value, child) {
                            return Text(
                              "${value.streak.currentStreak}",
                              style: GoogleFonts.epilogue(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: CommanWidgets.textheadingcolor,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16),
              child: Text(
                "Daily Streak",
                style: GoogleFonts.epilogue(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: CommanWidgets.textheadingcolor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Consumer<SkincareProvider>(
                builder: (context, value, child) {
                  print(" my streak is ${value.streak.currentStreak}");
                  return Text(
                    "${value.streak.currentStreak}",
                    style: GoogleFonts.epilogue(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: CommanWidgets.textheadingcolor,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Last 30 Days ",
                      style: GoogleFonts.epilogue(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: CommanWidgets.textsubheadingcolor,
                      ),
                    ),
                  ),
                  Consumer<SkincareProvider>(
                    builder: (context, value, child) {
                      return Expanded(
                        flex: 2,
                        child: Text(
                          "+${value.getLast30DaysPercentage()}%",
                          style: GoogleFonts.epilogue(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: const Color.fromRGBO(8, 135, 89, 1),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            linechart()
          ],
        ),
      ),
    );
  }
}
