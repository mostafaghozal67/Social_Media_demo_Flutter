import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(//Light Mode
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle( // 3shan a8ir lon al status bar
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold)
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed, 
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
  ),
  textTheme:  TextTheme(
    bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
    titleLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.black
    )

  ),
  fontFamily: 'Jannah'
);

ThemeData darkTheme = ThemeData(
  primaryColor: Colors.blue,
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.dark
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: HexColor('333739'),
      titleTextStyle: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold)
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),
      titleMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white
      )

  ),
  fontFamily: 'Jannah'
);
