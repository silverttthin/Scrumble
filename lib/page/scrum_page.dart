import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_network/image_network.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:madcamp_week1_mission/Model/scrum.dart';

class ScrumPage extends StatefulWidget {
  final int index;
  final List<String> tags;

  const ScrumPage({super.key, required this.index, required this.tags});

  @override
  State<ScrumPage> createState() => _ScrumPageState();
}

class _ScrumPageState extends State<ScrumPage> {

  @override
  Widget build(BuildContext context) {
    final scrumData = Provider.of<List<Scrum>>(context);
    int index = widget.index;
    final tags = widget.tags;

    print(tags);

    return Scaffold(
        backgroundColor: MadColor.backgroudColor,
        appBar: AppBar(
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('스크럼블',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MadColor.mainColor

                ),
              ),
              SizedBox(width: 10,),

              SvgPicture.asset(
                'assets/logo.svg',
                height: 24.0,
              ),
            ],
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('people')
                .doc('team_to_people')
                .snapshots(),
            builder: (context, snapshot) {
              // 아직 스냅샷 데이터 못가져 올 때 붉은 에러창 나타나는 것을 로딩 상태로 보이게 함
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var teamData = snapshot.data!.data() as Map<String, dynamic>;

              return Card.filled(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28)),
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
                              Image.asset(
                                'assets/icons/${scrumData[index].icon}.png',
                                width: 80,
                                height: 80,
                              ),

                              SizedBox(
                                height: 8,
                              ),

                              // 스크럼 한줄 평 들어갈 곳
                              Text(
                                scrumData[index].summary,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(
                                height: 8,
                              ),

                              // 이름과 작성일 들어가는 Row 위젯
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    teamData[scrumData[index].team.toString()],
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),

                                  Text(formatDateTime(scrumData[index].date),
                                  style: TextStyle(
                                    fontSize: 14
                                  ),)
                                ],
                              ),

                              SizedBox(height: 20,),
                              Wrap(
                                spacing : 8,
                                runSpacing: 8,
                                children: tags.map((tag) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xffeeeeee),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text(
                                      tag,
                                      style: TextStyle(
                                          fontSize: 15.0, color: MadColor.mainColor),
                                    ),
                                  );
                                }).toList(),
                              ),

                              SizedBox(
                                height: 32,
                              ),

                              // 사용자가 첨부한 이미지를 담는 컨테이너
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: ClipRRect(
                                  // child: Image.network(
                                  //   (scrumData[index].url),
                                  //   fit: BoxFit.fill,
                                  // ),
                                  child: Image.network(scrumData[index].url,
                                    width: double.infinity,
                                    fit: BoxFit.cover,),

                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),

                              SizedBox(
                                height: 32,
                              ),

                              // 본 내용들이 들어가는 곳
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "어제까지 한 일",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  MarkdownBody(
                                    data: scrumData[index].yesterday.replaceAll('\n', "  \n"),
                                    selectable: true,
                                    // styleSheet: MarkdsownStyleSheet(
                                    //
                                    // ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "오늘 할 일",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  MarkdownBody(
                                    data: scrumData[index].today.replaceAll('\n', "  \n"),
                                    selectable: true,
                                    // styleSheet: MarkdsownStyleSheet(
                                    //
                                    // ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "궁금한/필요한/알아낸 것",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  MarkdownBody(
                                    data: scrumData[index].learned.replaceAll('\n', "  \n"),
                                    selectable: true,
                                    // styleSheet: MarkdsownStyleSheet(
                                    //
                                    // ),
                                  ),


                                  SizedBox(height: 100,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  String formatDateTime(int dateTimeInt) => "${dateTimeInt.toString().substring(0, 4)}년 ${dateTimeInt.toString().substring(4, 6)}월 ${dateTimeInt.toString().substring(6, 8)}일 ${dateTimeInt.toString().substring(8, 10)}시 ${dateTimeInt.toString().substring(10, 12)}분";
}
