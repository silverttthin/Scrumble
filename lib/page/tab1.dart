import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
import 'package:madcamp_week1_mission/page/scrum_add_page.dart';
import 'package:madcamp_week1_mission/page/scrum_page.dart';

class tab1 extends StatefulWidget {
  const tab1({super.key});
  @override
  State<tab1> createState() => _tab1State();
}

class _tab1State extends State<tab1> {
  final List<Map<String, String>> posts = [
    {
      'title': '스크럼 한줄평',
      'author': '이시웅, 정재현',
      'content': '동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세 남산',
      'image': 'https://github.com/RGLie/TodayI/blob/master/todayi/assets/icons/10.png?raw=true',
    },
    {
      'title': '스크럼 한줄평',
      'author': '호날두, 메시',
      'content': "상처를 치료해 줄 사람 어디 없나 가만히 놔두다간 끊임없이 덧나 사랑도 사람도 너무나도 겁나 혼자인게 무서워 난 잊혀질까 두려워",
      'image': 'https://github.com/RGLie/TodayI/blob/master/todayi/assets/icons/17.png?raw=true',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MadColor.mainColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
        ),
        child: Icon(Icons.add_outlined, color: Colors.white,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScrumAddPage()));
        },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: posts.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              Card(
                // margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 3, // 카드 하단 그림자 크기
                shadowColor: Colors.black.withOpacity(0.7),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScrumPage()));
                  },
                  child: ListTile(
                    leading: Image.network(posts[index]['image']!, width: 60, height: 60,), // 팀 대표 아이콘

                    title: Padding(
                      padding: const EdgeInsets.only(top: 16, left: 4),
                        child: Text(posts[index]['author']!, style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF8E8989).withOpacity(0.8),
                        )),
                    ),

                    subtitle: Transform.translate(
                      offset: const Offset(0, -4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(posts[index]['title']!,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight : FontWeight.bold,
                            ),),


                            Text(posts[index]['content']!, maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.7),
                            ),),
                            const SizedBox(height: 16,)
                          ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          );
        },
      ),
    );
  }
}
