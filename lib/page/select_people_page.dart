import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/human_provider.dart';
import '../Model/scrum_add_provider.dart';

class SelectPeoplePage extends StatefulWidget {
  const SelectPeoplePage({super.key});

  @override
  State<SelectPeoplePage> createState() => _SelectPeoplePageState();
}

class _SelectPeoplePageState extends State<SelectPeoplePage> {
  @override
  Widget build(BuildContext context) {
    final humanData = Provider.of<HumanModel>(context);
    final scrumAddProvider = Provider.of<ScrumAddProvideer>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('작성자'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(15),
        itemCount: humanData.humanList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              leading: Image(
                width: 30,
                image: AssetImage(
                    'assets/icons/${humanData.humanList[index].id}.png'),
              ),
              title: Text(humanData.humanList[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(humanData.humanList[index].call, style: TextStyle(fontSize:12, color: Color(0xff444444)),),
                  Text(humanData.humanList[index].introduction, style: TextStyle(color: Color(0xff444444), overflow: TextOverflow.ellipsis),),
                ],
              ),
              onTap: (){
                scrumAddProvider.setPeople(humanData.humanList[index].name, humanData.humanList[index].id);
                Navigator.pop(context);
              },
            ),
          );
        },
        // separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
