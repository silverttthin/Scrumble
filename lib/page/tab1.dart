import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/Model/scrum.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
import 'package:madcamp_week1_mission/page/scrum_add_page.dart';
import 'package:madcamp_week1_mission/page/scrum_page.dart';
import 'package:provider/provider.dart';

class tab1 extends StatefulWidget {
  const tab1({super.key});

  @override
  State<tab1> createState() => _tab1State();
}

class _tab1State extends State<tab1> {
  @override
  Widget build(BuildContext context) {
    final scrumData = Provider.of<List<Scrum>>(context);
    print(scrumData.length);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MadColor.mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScrumAddPage()));
        },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: scrumData.length,
        itemBuilder: (context, index) {
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScrumPage(index: index)));
                  },
                  child: ListTile(
                    leading: Image(
                      width: 60,
                      image: AssetImage(
                          'assets/icons/${scrumData[index].icon}.png'),
                    ), // 팀 대표 아이콘

                    title: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 3),
                      child: Text(scrumData[index].team.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF8E8989).withOpacity(0.8),
                          )),
                    ),

                    subtitle: Transform.translate(
                      offset: const Offset(0, -4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            scrumData[index].summary,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            scrumData[index].learned,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          )
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
