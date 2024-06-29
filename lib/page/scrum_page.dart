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

                      // 스크럼 한줄 평 들어갈 곳
                      Text("스크럼 한줄평", style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        ),),

                      SizedBox(height: 8,),

                      // 이름과 작성일 들어가는 Row 위젯
                      Row(
                        children: [
                          Text('이시웅, 정재현', style: TextStyle(
                            fontSize: 16,
                          ),),
                          SizedBox(width: 20,),
                          Text("2024년 6월 29일")
                        ],
                      ),

                      SizedBox(height: 32,),

                      // 사용자가 첨부한 이미지를 담는 컨테이너
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0,5),
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: ClipRRect(
                          child: Image.network(
                            "https://i.etsystatic.com/27024673/r/il/9af965/3601476621/il_fullxfull.3601476621_nj57.jpg",
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          
                        ),
                      ),

                      SizedBox(height: 32,),


                      // 본 내용들이 들어가는 곳
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("어제까지 한 일", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),),

                          Text("어제까지 한 일 내용의 마크다운 형식이 표시될 부분", style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),),


                          SizedBox(height: 30,),
                          Text("오늘 할 일", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),),

                          Text("오늘 할 일 내용의 마크다운 형식이 표시될 부분", style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),),

                          SizedBox(height: 30,),


                          Text("궁금한/필요한/알아낸 것", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),),

                          Text("궁금한/필요한/알아낸 것 내용의 마크다운 형식이 표시될 부분", style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),),
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
