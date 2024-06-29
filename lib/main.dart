import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
import 'package:madcamp_week1_mission/page/scrum_add_page.dart';
import 'package:madcamp_week1_mission/page/tab1.dart';
import 'package:madcamp_week1_mission/page/tab2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(scaffoldBackgroundColor: MadColor.backgroudColor),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List _pages = [
    tab1(),
    tab2(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      appBar: AppBar(
        title: Text('SCRUMBLE'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        enableFeedback: false,
        onTap: (int index){
          setState((){
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.call_outlined), label: '연락처'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_library_outlined), label: '갤러리'),
        ],
      ),
    );
  }


}


