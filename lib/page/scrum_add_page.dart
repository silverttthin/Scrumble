import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madcamp_week1_mission/Model/human.dart';
import 'package:madcamp_week1_mission/Model/human_provider.dart';
import 'package:madcamp_week1_mission/constants/colors.dart';
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

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('스크럼 추가하기'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text('2024년 6월 28일',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 15,),
                          Text('작성자',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
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
                                          "선택",
                                          style:
                                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    content: SizedBox(
                                      height: 250,
                                      width: 300,
                                      child:
                                        ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          // padding: EdgeInsets.all(8),
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
                                                subtitle: Text(humanData.humanList[index].call, style: TextStyle(color: Color(0xff444444)),),
                                                onTap: (){},
                                              ),
                                            );

                                            return Row(
                                              children: [
                                                Image(
                                                  width: 30,
                                                  image: AssetImage(
                                                      'assets/icons/${humanData.humanList[index].id}.png'),
                                                ),
                                              ],
                                            );
                                          },
                                          // separatorBuilder: (BuildContext context, int index) => const Divider(),
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
                          icon: Icon(Icons.person_add_outlined, color: MadColor.mainColor,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DottedBorder(
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
                            onTap: (){},
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
                              ),
                            ),
                          ),
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
                      child: InkWell(
                        onTap: () {},
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
}
