//  import packages;
import 'package:CineInfo/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
  timeDilation = 1.5;
  return runApp(CineInfo());
}

class CineInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineInfo',
      theme: ThemeData(
        primaryColor: Color(0xff131C25),
        accentColor: Color(0xff1e2c3a),
      ),
      home: HomeScreen(),
    );
  }
}
