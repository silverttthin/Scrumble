import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/Model/Trend.dart';
import 'package:text_analysis/text_analysis.dart';
import 'package:provider/provider.dart';
import 'package:word_cloud/word_cloud.dart';

import '../Model/scrum.dart';
import '../constants/colors.dart';

class TrendPage2 extends StatefulWidget {
  const TrendPage2({super.key});

  @override
  State<TrendPage2> createState() => _TrendPage2State();
}

class _TrendPage2State extends State<TrendPage2> {

  @override
  Widget build(BuildContext context) {
    final scrumData = Provider.of<List<Scrum>>(context);

    Map<String, dynamic> frequency = {};




    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('trend').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        var data = snapshot.data!.docs;
        for(var i = 0; i<snapshot.data!.docs.length; i++){
          if(frequency.containsKey(data[i]['word'] )){
            frequency[data[i]['word'] ] = frequency[data[i]['word'] ] + 1;
          }
          else{
            frequency[data[i]['word'] ] = 1;
          }
        }
        List<Map> lst = [];
        frequency.forEach((key, value) {
          lst.add({'word': key, 'value':value});

        });
        WordCloudData wcdata = WordCloudData(data: lst);

        return WordCloudView(
          data: wcdata,
          maxtextsize: 50,
          mintextsize: 10,
          mapcolor: MadColor.mainLight,
          mapwidth: 300,
          mapheight: 350,
          fontWeight: FontWeight.bold,
          colorlist: [MadColor.mainColor, MadColor.secondColor, Colors.black],
        );
      }
    );

  }
}
