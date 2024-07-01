import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/Model/human_provider.dart';
import 'package:madcamp_week1_mission/Model/scrum.dart';
import 'package:madcamp_week1_mission/Model/scrum_add_provider.dart';
import 'package:madcamp_week1_mission/Model/scrum_provider.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
import 'package:madcamp_week1_mission/firebase_options.dart';
import 'package:madcamp_week1_mission/page/scrum_add_page.dart';
import 'package:madcamp_week1_mission/page/scrum_page.dart';
import 'package:madcamp_week1_mission/page/feed_page.dart';
import 'package:madcamp_week1_mission/page/tab2_page.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  ScrumProvider db = ScrumProvider();

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        StreamProvider<List<Scrum>>.value(
          value: db.getNotes(),
          initialData: [],
        ),
        ChangeNotifierProvider(
            create: (BuildContext context) => HumanModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => ScrumAddProvideer()
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
        theme: ThemeData(scaffoldBackgroundColor: MadColor.backgroudColor),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    //// Use normal tab controller
    // _tabController = TabController(
    //   initialIndex: 1,
    //   length: 4,
    //   vsync: this,
    // );

    //// use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final humanData = Provider.of<HumanModel>(context, listen: false);
      humanData.getHuman();
      humanData.getImage();
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
    _motionTabBarController!.dispose();
  }




  @override
  Widget build(BuildContext context) {
    // final humanData = Provider.of<HumanModel>(context);
    // humanData.getHuman();

    return Scaffold(
      // body: _pages[_selectedIndex],
      appBar: AppBar(
        title: Text('SCRUMBLE'),
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController, // ADD THIS if you need to change your tab programmatically
        initialSelectedTab: "피드",
        labels: const ["추가", "피드", "개요"],
        icons: const [Icons.add_outlined, Icons.dashboard_outlined, Icons.analytics_outlined],

        // optional badges, length must be same with labels

        tabSize: 45,
        tabBarHeight: 50,
        textStyle: const TextStyle(
          fontSize: 12,
          color: MadColor.mainColor,
          fontWeight: FontWeight.w800,
        ),
        tabIconColor: MadColor.mainColor,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: MadColor.mainColor,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            // _tabController!.index = value;
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        // controller: _tabController,
        controller: _motionTabBarController,
        children: [
          ScrumAddPage(),
          Tab2Page(),
          const Center(
            child: Text("개요"),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.blueAccent,
      //   selectedFontSize: 14.0,
      //   unselectedFontSize: 12.0,
      //   enableFeedback: false,
      //   onTap: (int index){
      //     setState((){
      //       _selectedIndex = index;
      //     });
      //   },
      //   currentIndex: _selectedIndex,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.call_outlined), label: '연락처'),
      //     BottomNavigationBarItem(icon: Icon(Icons.photo_library_outlined), label: '갤러리'),
      //   ],
      // ),
    );
  }


}


