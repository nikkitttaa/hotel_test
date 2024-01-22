import 'package:flutter/material.dart';

class ErrorWriteAllDataSnackBar {
  static void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Заполните все данные!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(1000, 235, 87, 87),
      ),
    );
  }
}
