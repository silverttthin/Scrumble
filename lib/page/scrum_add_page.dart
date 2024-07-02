import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madcamp_week1_mission/Model/human.dart';
import 'package:madcamp_week1_mission/Model/human_provider.dart';
import 'package:madcamp_week1_mission/Model/scrum.dart';
import 'package:madcamp_week1_mission/Model/scrum_add_provider.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
import 'package:madcamp_week1_mission/page/select_people_page.dart';
import 'package:provider/provider.dart';

class ScrumAddPage extends StatefulWidget {
  const ScrumAddPage({super.key});

  @override
  State<ScrumAddPage> createState() => _ScrumAddPageState();
}

class _ScrumAddPageState extends State<ScrumAddPage> {
  final _yesterdayController = TextEditingController();
  final _todayController = TextEditingController();
  final _learnedController = TextEditingController();
  final _summaryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final humanData = Provider.of<HumanModel>(context);
    final scrumAddProvider = Provider.of<ScrumAddProvideer>(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('SCRUMBLE'),
    // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left:15, right: 15, bottom: 45.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text('${DateTime.now().year.toString()}년 ${DateTime.now().month.toString()}월 ${DateTime.now().day.toString()}일',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 15,),
                          scrumAddProvider.name == ""?
                          Text('작성자',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                          ):
                          Text(scrumAddProvider.name,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MadColor.mainColor),
                          )
                          ,
                          SizedBox(width: 7,),
                          Text('님의 스크럼',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        height: 40,
                        child: IconButton(
                          onPressed: (){
                            // scrumAddProvider.initialize();
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => SelectPeoplePage()));


                            // showDialog(
                            //     context: context,
                            //     barrierDismissible: true,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(10.0)),
                            //         //Dialog Main Title
                            //         title: Column(
                            //           children: <Widget>[
                            //             new Text(
                            //               "선택",
                            //               style:
                            //               TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            //             ),
                            //           ],
                            //         ),
                            //         content: SizedBox(
                            //           height: 250,
                            //           width: 300,
                            //           child:
                            //             ListView.builder(
                            //               scrollDirection: Axis.vertical,
                            //               // padding: EdgeInsets.all(8),
                            //               itemCount: humanData.humanList.length,
                            //               itemBuilder: (context, index){
                            //                 return Card(
                            //                   child: ListTile(
                            //                     leading: Image(
                            //                       width: 30,
                            //                       image: AssetImage(
                            //                           'assets/icons/${humanData.humanList[index].id}.png'),
                            //                     ),
                            //                     title: Text(humanData.humanList[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                            //                     subtitle: Text(humanData.humanList[index].call, style: TextStyle(color: Color(0xff444444)),),
                            //                     onTap: (){
                            //                       scrumAddProvider.setPeople(humanData.humanList[index].name, humanData.humanList[index].id);
                            //                       Navigator.pop(context);
                            //                     },
                            //                   ),
                            //                 );
                            //               },
                            //               // separatorBuilder: (BuildContext context, int index) => const Divider(),
                            //             )
                            //         ),
                            //         actions: <Widget>[
                            //           new ElevatedButton(
                            //             child: new Text("닫기", style: TextStyle(color: Colors.white),),
                            //             style: ElevatedButton.styleFrom(
                            //                 backgroundColor: MadColor.mainColor),
                            //             onPressed: () {
                            //               Navigator.pop(context);
                            //             },
                            //           ),
                            //         ],
                            //       );
                            //     });
                          },
                          icon: Icon(Icons.person_add_outlined, color: MadColor.mainColor,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: scrumAddProvider.url == ""?
                    DottedBorder(
                      color: MadColor.mainColor,
                      dashPattern: [19],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(20),
                      strokeWidth: 4,
                      child: Container(
                        width: double.maxFinite,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: MadColor.mainLight
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              // scrumAddProvider.getImage(ImageSource.gallery);
                              humanData.shuffleImage();


                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    //Dialog Main Title
                                    title: Column(
                                      children: <Widget>[
                                        new Text(
                                          "이미지 선택",
                                          style:
                                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      ],
                                    ),
                                    content: SizedBox(
                                        height: 250,
                                        width: 300,
                                        child:
                                        GridView.builder(
                                          itemCount: humanData.imageList.length, //item 개수
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                                            mainAxisSpacing: 5, //수평 Padding
                                          crossAxisSpacing: 5, //수직 Padding

                                        ),
                                        itemBuilder: (context, index){
                                          return InkWell(
                                            onTap: (){
                                              scrumAddProvider.setImage(humanData.imageList[index].url);
                                              Navigator.pop(context);
                                            },
                                            child: Image.network(
                                              humanData.imageList[index].url,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      )
                                    ),
                                    actions: <Widget>[
                                      new ElevatedButton(
                                        child: new Text("닫기", style: TextStyle(color: Colors.white),),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: MadColor.mainColor),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo_library_outlined,
                                  ),
                                  Text(
                                    '사진을 추가하세요.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xffaaaaaa)
                                    ),
                                  )
                                ],
                              )
                            )
                          ),
                        ),
                      ),
                    ):
                    InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                //Dialog Main Title
                                title: Column(
                                  children: <Widget>[
                                    new Text(
                                      "이미지 선택",
                                      style:
                                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                content: SizedBox(
                                    height: 250,
                                    width: 300,
                                    child:
                                    GridView.builder(
                                      itemCount: humanData.imageList.length, //item 개수
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                                        mainAxisSpacing: 5, //수평 Padding
                                        crossAxisSpacing: 5, //수직 Padding

                                      ),
                                      itemBuilder: (context, index){
                                        return InkWell(
                                          onTap: (){
                                            scrumAddProvider.setImage(humanData.imageList[index].url);
                                            Navigator.pop(context);
                                          },
                                          child: Image.network(
                                            humanData.imageList[index].url,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    )
                                ),
                                actions: <Widget>[
                                  new ElevatedButton(
                                    child: new Text("닫기", style: TextStyle(color: Colors.white),),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MadColor.mainColor),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });

                      },
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 5),
                                  blurRadius: 5)
                            ]),
                        child: ClipRRect(
                          child: Image.network(scrumAddProvider.url, fit: BoxFit.fill,),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.check_outlined, color: MadColor.mainColor,),
                      SizedBox(width: 5,),
                      Text('어제 무엇을 하셨나요?',
                        style: TextStyle(color: MadColor.mainColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _yesterdayController,
                    minLines: 4,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    cursorColor: MadColor.mainColor,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.checklist_outlined),
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
                        hintText: '텍스트를 입력하세요. (마크다운)',
                        floatingLabelStyle: TextStyle(color: MadColor.mainColor),
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        labelText: '어제 한 일',
                        labelStyle: TextStyle(fontSize: 12,  color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                              color: MadColor.mainColor, width: 3),
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "내용을 입력해주세요";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15,),

                  Row(
                    children: [
                      Icon(Icons.check_outlined, color: MadColor.mainColor,),
                      SizedBox(width: 5,),
                      Text('오늘 무엇을 할 예정인가요?',
                        style: TextStyle(color: MadColor.mainColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _todayController,
                    minLines: 4,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    cursorColor: MadColor.mainColor,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit_outlined),
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
                        hintText: '텍스트를 입력하세요. (마크다운)',
                        floatingLabelStyle: TextStyle(color: MadColor.mainColor),
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        labelText: '오늘 할 일',
                        labelStyle: TextStyle(fontSize: 12,  color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                              color: MadColor.mainColor, width: 3),
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "내용을 입력해주세요";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15,),

                  Row(
                    children: [
                      Icon(Icons.check_outlined, color: MadColor.mainColor,),
                      SizedBox(width: 5,),
                      Text('무엇을 느꼈나요?',
                        style: TextStyle(color: MadColor.mainColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _learnedController,
                    minLines: 4,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    cursorColor: MadColor.mainColor,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.local_library_outlined),
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
                        hintText: '텍스트를 입력하세요. (마크다운)',
                        floatingLabelStyle: TextStyle(color: MadColor.mainColor),
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        labelText: '궁금한, 필요한, 알아낸 것',
                        labelStyle: TextStyle(fontSize: 12,  color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                              color: MadColor.mainColor, width: 3),
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "내용을 입력해주세요";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15,),

                  Row(
                    children: [
                      Icon(Icons.check_outlined, color: MadColor.mainColor,),
                      SizedBox(width: 5,),
                      Text('오늘의 한 마디?',
                        style: TextStyle(color: MadColor.mainColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _summaryController,
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    cursorColor: MadColor.mainColor,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.format_quote_outlined),
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
                        hintText: '텍스트를 입력하세요. (마크다운)',
                        floatingLabelStyle: TextStyle(color: MadColor.mainColor),
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        labelText: '한 줄 평',
                        labelStyle: TextStyle(fontSize: 12,  color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                              color: MadColor.mainColor, width: 3),
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "내용을 입력해주세요";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15,),

                  Container(
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                      color: MadColor.mainColor,
                      borderRadius: BorderRadius.circular(15),
                      //boxShadow: boxShadows,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('people')
                            .doc('people_to_team')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // print('32400000');
                            return Container(
                              width: double.maxFinite,
                              height: 50,
                              child: Center(
                                  child: Text(
                                    '완료',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  )),
                            );
                          }
                          var teamData = snapshot.data!.data() as Map<String, dynamic>;

                          return InkWell(
                            onTap: () async{
                              FocusScope.of(context).requestFocus(new FocusNode());
                              if(scrumAddProvider.name == ""){
                                Fluttertoast.showToast(
                                    msg: "작성자를 선택해 주세요",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                                return;

                              }

                              if(scrumAddProvider.url == ""){
                                Fluttertoast.showToast(
                                    msg: "이미지를 선택해 주세요",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                                return;

                              }

                              if (_formKey.currentState!.validate()) {
                                Scrum newScrum = Scrum(
                                    icon: scrumAddProvider.name_id.toString(),
                                    summary: _summaryController.text,
                                    yesterday: _yesterdayController.text,
                                    today: _todayController.text,
                                    learned: _learnedController.text,
                                    url: scrumAddProvider.url,
                                    team: teamData[scrumAddProvider.name],
                                    date: parsing_timeToint()
                                );
                                CollectionReference contents = FirebaseFirestore.instance
                                    .collection('scrums');
                                contents.add(newScrum.toJson());

                                _summaryController.clear();
                                _yesterdayController.clear();
                                _todayController.clear();
                                _learnedController.clear();

                                Fluttertoast.showToast(
                                    msg: "스크럼 작성이 완료 되었습니다!",
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
                            child: Container(
                              width: double.maxFinite,
                              height: 50,
                              child: Center(
                                child: Text(
                                  '완료',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                )),
                            ),
                          );
                        }
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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
