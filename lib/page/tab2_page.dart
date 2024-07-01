import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
import 'package:madcamp_week1_mission/page/gallery_page.dart';
import 'feed_page.dart';

class Tab2Page extends StatefulWidget {
  const Tab2Page({super.key});

  @override
  State<Tab2Page> createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> {
  int _tabbarNum = 1;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: MadColor.mainLight,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.grid_on, size: 20),
                color: _tabbarNum == 1
                    ? MadColor.mainColor
                    : MadColor.secondColor,
                onPressed: () {
                  setState(() {
                    _tabbarNum = 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.photo_library, size: 20,),
                color: _tabbarNum == 2
                    ? MadColor.mainColor
                    : MadColor.secondColor,
                onPressed: () {
                  setState(() {
                    _tabbarNum = 2;
                  });
                },
              ),
            ],
          ),
        ),

        _tabbarNum == 1
            ? SliverFillRemaining(
                child: FeedPage(),
              )
            : SliverFillRemaining(
                child: GalleryPage()
              ),
      ],
    );
  }
}
