import 'package:flutter/material.dart';

class tab1 extends StatefulWidget {
  const tab1({super.key});

  @override
  State<tab1> createState() => _tab1State();
}

class _tab1State extends State<tab1> {

  List<Widget> contact = [
    Container(
      height: 50,
      child: Center(child: Text('010-1234-5678'),),
    ),
    Container(
      height: 50,
      child: Center(child: Text('010-6490-2661'),),
    ),
    Container(
      height: 50,
      child: Center(child: Text('010-1232-1111'),),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: contact,
    );
  }
}
