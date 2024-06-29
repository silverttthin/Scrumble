import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';

class ScrumPage extends StatefulWidget {
  const ScrumPage({super.key});

  @override
  State<ScrumPage> createState() => _ScrumPageState();
}

class _ScrumPageState extends State<ScrumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MadColor.backgroudColor,

      appBar: AppBar(
        title: Text('SCRUMBLE'),
      ),


      
      body: Card.filled(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        ),

        color: Colors.white,

        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/icons/1.png', width: 80, height: 80,),

                      SizedBox(height: 8,),

                      Text("스크럼 한줄평", style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        ),),

                      SizedBox(height: 8,),

                      Row(
                        children: [
                          Text('이시웅, 정재현', style: TextStyle(
                            fontSize: 16,
                          ),),
                          SizedBox(width: 20,),
                          Text("2024년 6월 29일")
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}
