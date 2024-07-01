import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/Model/scrum.dart';
import 'package:madcamp_week1_mission/Model/scrum_add_provider.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
import 'package:madcamp_week1_mission/page/scrum_add_page.dart';
import 'package:madcamp_week1_mission/page/scrum_page.dart';
import 'package:provider/provider.dart';

import 'package:translator/translator.dart';
import 'package:text_analysis/text_analysis.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final scrumAddProvider = Provider.of<ScrumAddProvideer>(context);
    final scrumData = Provider.of<List<Scrum>>(context);
    final translator = GoogleTranslator();

    // 스크럼 내용 영어로 번역
    Future<Translation> trans(input) async =>
        await translator.translate(input, from: 'ko', to: 'en');

    // 영어 내용을 단어 단위로 분석해 특수기호 전처리 후 상위 num개의 빈출 단어 리턴
    Future<List<String>> most_common(input, num) async {
      final textDoc = await TextDocument.analyze(
          sourceText: input,
          analyzer: English.analyzer,
          nGramRange: NGramRange(1, 1));

      // 단어 빈도수 계산
      final wordFrequencies =
          textDoc.tokens.fold<Map<String, int>>({}, (map, token) {
        final word = token.term.replaceAll(RegExp(r'[^\w\s]'), ''); // 특수기호 제거
        if (word.isNotEmpty) {
          map[word] = (map[word] ?? 0) + 1;
        }
        return map;
      });

      final topWords = (wordFrequencies.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value)))
          .take(num)
          .map((e) => e.key)
          .toList();
      return topWords;
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: MadColor.mainColor,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      //   child: Icon(
      //     Icons.add_outlined,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     scrumAddProvider.initialize();
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => ScrumAddPage()));
      //   },
      // ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15, bottom: 45),
        itemCount: scrumData.length,
        itemBuilder: (context, index) {

          // 미리 index번째 스크럼의 빈출 단어 변수 만들어두기
           var tags = most_common(
              scrumData[index].learned +
                  scrumData[index].today +
                  scrumData[index].yesterday, 3);



          return FutureBuilder(
            future: tags,
            builder: (context, snapshot) {

            final arrived_tags = snapshot.data!;

            return Column(
              children: [
                Card(
                  // margin: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 3, // 카드 하단 그림자 크기
                  shadowColor: Colors.black.withOpacity(0.7),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScrumPage(index: index, tags : arrived_tags)));
                    },
                    child: ListTile(
                      leading: Image(
                        width: 60,
                        image: AssetImage (
                            'assets/icons/${scrumData[index].icon}.png'),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('people')
                                .doc('team_to_people')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: const Color(0xFF666666),
                                    ));
                              }
                              var teamData =
                                  snapshot.data!.data() as Map<String, dynamic>;

                              return Text(
                                  teamData[scrumData[index].team.toString()],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: const Color(0xFF666666),
                                  ));
                            }),
                      ),
                      subtitle: FutureBuilder<List<String>>(
                        future: tags,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              "Loading...",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            );
                          } else {
                            final tags = snapshot.data!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  scrumData[index].summary,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 7,),
                                Wrap(
                                  spacing : 8,

                                  children: tags.map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xffdddddd),
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      child: Text(
                                        tag,
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  height: 8,
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            );

            }


          );
        },
      ),
    );
  }
}
