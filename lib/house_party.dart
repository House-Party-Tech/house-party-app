import 'package:flutter/material.dart';
import 'package:house_party/pages/home/home_page.dart';

class HouseParty extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House Party',
      home: HomePage()
    );
  }
}