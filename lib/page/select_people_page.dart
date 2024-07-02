import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
import 'package:provider/provider.dart';

import '../Model/human_provider.dart';
import '../Model/scrum_add_provider.dart';

class SelectPeoplePage extends StatefulWidget {
  const SelectPeoplePage({super.key});

  @override
  State<SelectPeoplePage> createState() => _SelectPeoplePageState();
}

class _SelectPeoplePageState extends State<SelectPeoplePage> {
  // String? inputText;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final humanData = Provider.of<HumanModel>(context);
    final scrumAddProvider = Provider.of<ScrumAddProvideer>(context);
    
    void _scrollToItem(String name){
      final int idx = humanData.humanList.indexWhere((elem) => elem.name == name);
      if(idx != -1){
        _scrollController.animateTo(
            idx * 80, duration: Duration(seconds: 1), curve: Curves.easeInOut);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('작성자'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
            child: SearchBar(
              leading: Icon(Icons.search),
              shadowColor: WidgetStatePropertyAll(MadColor.secondColor),
              constraints: BoxConstraints(minHeight: 49),
              hintText: "이름을 입력하세요.",
              hintStyle: WidgetStateProperty.all(TextStyle(color: Colors.grey.shade400)),
              onChanged: (value)
              {
                // setState(() => inputText = value);
                _scrollToItem(value);
              },


            ),
          ),

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(15),
              itemCount: humanData.humanList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('User Detail'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10,),
                                Image.asset(
                                    'assets/icons/${humanData.humanList[index].id}.png',
                                width: 80,),
            
                                Text(
                                  humanData.humanList[index].name,
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(height: 8,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text('\u{1F50E} ${humanData.humanList[index].mbti}', textAlign: TextAlign.center,),
                                ),
                                SizedBox(height: 3,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text('\u{1F4DE} ${humanData.humanList[index].call}'),
                                ),
                                SizedBox(height: 12,),
                                Text(humanData.humanList[index].introduction),
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'))
                            ],
                          );
                        });
                  },
                  child: Card(
                    child: ListTile(
                      leading: Image(
                        width: 30,
                        image: AssetImage(
                            'assets/icons/${humanData.humanList[index].id}.png'),
                      ),
                      title: Text(
                        humanData.humanList[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            humanData.humanList[index].call,
                            style: TextStyle(fontSize: 12, color: Color(0xff444444)),
                          ),
                          Text(
                            humanData.humanList[index].introduction,
                            style: TextStyle(
                                color: Color(0xff444444),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      onTap: () {
                        scrumAddProvider.setPeople(humanData.humanList[index].name,
                            humanData.humanList[index].id);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              // separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
