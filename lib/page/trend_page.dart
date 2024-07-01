import 'package:flutter/material.dart';
import 'package:text_analysis/text_analysis.dart';
import 'package:provider/provider.dart';

import '../Model/scrum.dart';

class trend_page extends StatefulWidget {
  const trend_page({super.key});

  @override
  State<trend_page> createState() => _trend_pageState();
}

class _trend_pageState extends State<trend_page> {
  Future<Map<String, int>> collectFrequentWords(
      List<String> texts, int minFrequency) async {
    final Map<String, int> wordFrequencies = {};

    for (String text in texts) {
      final textDoc = await TextDocument.analyze(
          sourceText: text,
          analyzer: English.analyzer,
          nGramRange: NGramRange(1, 1));
      // 단어 빈도수 계산
      textDoc.tokens.forEach((token) {
        final word = token.term.replaceAll(RegExp(r'[^\w\s]'), ''); // 특수기호 제거
        if (word.isNotEmpty) {
          wordFrequencies[word] = (wordFrequencies[word] ?? 0) + 1;
        }
      });
    }
    // 최소 빈도 조건에 맞는 단어들만 남김 => 1번도 체크해버리면 요상한 단어들도 구름에 들어갈 수 있음.
    wordFrequencies.removeWhere((key, value) => value < minFrequency);
    return wordFrequencies;
  }

  @override
  Widget build(BuildContext context) {
    final scrumData = Provider.of<List<Scrum>>(context);

    final allScrumTexts = scrumData
        .map((scrum) => '${scrum.yesterday}. ${scrum.today}. ${scrum.learned}.')
        .toList();

    return FutureBuilder(
        future: collectFrequentWords(allScrumTexts, 2),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          else if(snapshot.hasData){
            final wordFrequencies = snapshot.data!;
            print(wordFrequencies);

            return Text(wordFrequencies.toString());
          }
          else{
            return Center(child: Text('업 없 업 없 업 없'),);
          }
        });
  }
}
