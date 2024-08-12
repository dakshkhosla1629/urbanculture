import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urbanculture/screens/streakscreen.dart';
import 'package:urbanculture/screens/dailyscreen.dart';

import '../utills/comman_widgets.dart';

class Navigationbarscreen extends StatefulWidget {
  const Navigationbarscreen({super.key});

  @override
  State<Navigationbarscreen> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbarscreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Dailyscreen(),
    const Streakscreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommanWidgets.backgroundcolor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(242, 232, 235, 1),
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 90.0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: CommanWidgets.backgroundcolor,
          selectedItemColor: CommanWidgets.textsubheadingcolor,
          unselectedItemColor: CommanWidgets.textsubheadingcolor,
          selectedLabelStyle: GoogleFonts.epilogue(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: CommanWidgets.textheadingcolor,
          ),
          unselectedLabelStyle: GoogleFonts.epilogue(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: CommanWidgets.textheadingcolor,
          ),
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/search.png',
                  scale: 1.2,
                  color: CommanWidgets.textsubheadingcolor,
                ),
              ),
              label: 'Routine',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/persons.png',
                  color: CommanWidgets.textsubheadingcolor,
                  scale: 1.2,
                ),
              ),
              label: 'Streaks',
            ),
          ],
        ),
      ),
    );
  }
}
