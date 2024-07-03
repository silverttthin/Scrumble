import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madcamp_week1_mission/widget/trend_page.dart';
import 'package:madcamp_week1_mission/widget/trend_page_2.dart';
import 'package:provider/provider.dart';
import 'package:word_cloud/word_cloud.dart';

import '../Model/Trend.dart';
import '../constants/colors.dart';

class RealTimeTrend extends StatefulWidget {
  const RealTimeTrend({super.key});

  @override
  State<RealTimeTrend> createState() => _RealTimeTrendState();
}

class _RealTimeTrendState extends State<RealTimeTrend> {
  final _trendController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final trendData = Provider.of<List<Trend>>(context);
    List<Map> convertedList = [{'word': "하이", "value": 10},{'word': "하이2", "value": 10}];
    WordCloudData wcdata = WordCloudData(data: convertedList);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(0, 5),
                      blurRadius: 5)
                ]),
            child: ClipRRect(
              child: TrendPage2(),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          SizedBox(height: 15,),

          Text('지금 무엇이 생각나시나요?',
            style: TextStyle(color: MadColor.mainColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          Container(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: TextFormField(
                    controller: _trendController,
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    cursorColor: MadColor.mainColor,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                    maxLength: 5,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.show_chart_outlined),
                        // icon: Icon(Icons.note_add_outlined),
                        fillColor: MadColor.mainLight,
                        isDense: true,
                        contentPadding: EdgeInsets.all(15),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide:
                          BorderSide(color: MadColor.mainLight, width: 0),
                        ),
                        // helperText: '',
                        hintText: '5자 이내로 입력해주세요.',
                        floatingLabelStyle: TextStyle(color: MadColor.mainColor),
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        labelText: '생각나는 단어를 입력해주세요',
                        labelStyle: TextStyle(fontSize: 12,  color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                              color: MadColor.mainColor, width: 3),
                        ),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "내용을 입력해주세요";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: MadColor.mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: IconButton(
                      highlightColor: MadColor.secondColor,
                      onPressed: (){
                        FocusScope.of(context).requestFocus(new FocusNode());

                        if (_formKey.currentState!.validate()) {
                          Trend newTrend = Trend(
                              word: _trendController.text,

                          );
                          CollectionReference contents = FirebaseFirestore.instance
                              .collection('trend');
                          contents.add(newTrend.toJson());

                          _trendController.clear();

                          Fluttertoast.showToast(
                              msg: "완료!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: MadColor.mainColor,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                          // Navigator.pop(context);

                        }
                      },
                      icon: Icon(Icons.arrow_upward_outlined, color: Colors.white,),
                    ),
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
  int parsing_timeToint() {
    // 현재 시간 가져오기
    DateTime now = DateTime.now();

    // 연도, 월, 일, 시, 분을 각각 문자열로 변환하고 필요한 자리수를 맞춤
    String year = now.year.toString();
    String month = now.month.toString().padLeft(2, '0');
    String day = now.day.toString().padLeft(2, '0');
    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');

    // 문자열을 결합하여 원하는 형식으로 변환
    String formattedDateTime = year + month + day + hour + minute;

    // 문자열을 정수로 변환
    int dateTimeInt = int.parse(formattedDateTime);

    // 결과 출력
    return dateTimeInt; // 예: 202406291524
  }
}
