import 'dart:io';

import 'package:engin/views/categoryPage.dart';
import 'package:engin/views/favouritesPage.dart';
import 'package:engin/views/homePage.dart';
import 'package:engin/views/profilePage.dart';
import 'package:engin/views/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 0;


  static final List<Widget> _navs = [
    const HomePage(),
    SearchPage(),
    FavouritesPage(),
    ProfilePage(),
  ];

  void iteamTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: _navs.elementAt(selectedIndex),
     bottomNavigationBar: BottomNavigationBar(
       items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(
           icon: Icon(Icons. home_filled, size: 30,color: selectedIndex == 0 ? Colors.black : Colors.grey,),
           label: 'Home',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.search_rounded , size: 30,color: selectedIndex == 1 ? Colors.black: Colors.grey ,),
           label: 'Search',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.library_add, size: 30,color: selectedIndex == 2 ? Colors.black : Colors.grey ,),
           label: 'Libary',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person_2_rounded, size: 30,color: selectedIndex == 3 ? Colors.black: Colors.grey,),
           label: 'Profile',
         ),
       ],

       currentIndex: selectedIndex,

       selectedLabelStyle:GoogleFonts.poppins(
           fontWeight: FontWeight.normal,color: Colors.orange
       ) ,
       unselectedLabelStyle: GoogleFonts.poppins(
           fontWeight: FontWeight.normal,color: Colors.grey
       ),
       backgroundColor: Colors.white,
       selectedItemColor: Colors.black,
       unselectedItemColor: Colors.black,
       onTap: iteamTapped,
       type: BottomNavigationBarType.fixed,
     ),
   );
  }
}
