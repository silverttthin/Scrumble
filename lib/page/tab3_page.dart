import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:madcamp_week1_mission/widget/real_time_trend.dart';
import 'package:madcamp_week1_mission/widget/trend_page.dart';
import 'package:word_cloud/word_cloud.dart';

import '../constants/colors.dart';

class Tab3Page extends StatefulWidget {
  const Tab3Page({super.key});

  @override
  State<Tab3Page> createState() => _Tab3PageState();
}

class _Tab3PageState extends State<Tab3Page> with SingleTickerProviderStateMixin  {
  int count = 0;
  String wordstring = '';


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Image(
                  //   width: 40,
                  //   image: AssetImage(
                  //       'assets/icons/26.png'),
                  // ),
                  Container(
                    width: 20,
                    color: MadColor.mainColor,
                    height: 4,
                  ),
                  Icon(
                    Icons.emoji_objects_outlined,
                    size: 40,
                    color:  MadColor.mainColor,
                  ),
                  SizedBox(width: 5,),
                  Text('몰캠 트렌드',
                    style: TextStyle(
                      color: MadColor.mainColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 25
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Container(
                      color: MadColor.mainColor,
                      height: 4,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0, 5),
                    blurRadius: 5)
                  ]),
                child: ClipRRect(
                  child: trend_page(),
                  borderRadius: BorderRadius.circular(25),
              ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Image(
                  //   width: 40,
                  //   image: AssetImage(
                  //       'assets/icons/26.png'),
                  // ),
                  Expanded(
                    child: Container(
                      color: MadColor.mainColor,
                      height: 4,
                    ),
                  ),
                  SizedBox(width: 3,),
                  Icon(
                    Icons.query_stats_outlined,
                    size: 40,
                    color:  MadColor.mainColor,
                  ),
                  SizedBox(width: 5,),
                  Text('실시간 트렌드',
                    style: TextStyle(
                        color: MadColor.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 25
                    ),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    width: 20,
                    color: MadColor.mainColor,
                    height: 4,
                  )
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left:15.0, right:5),
                child: RealTimeTrend(),
              ),
            ]
        ),
      ),
    );
  }
}
