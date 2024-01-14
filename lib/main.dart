import 'package:flutter/material.dart';
import 'package:hotel_test_task/screen/hotel_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'SF-Pro-Display'
    ),
    home: const HotelScreen(),
  ));
}

