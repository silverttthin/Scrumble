import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madcamp_week1_mission/Model/human.dart';
import 'package:madcamp_week1_mission/Model/myimage.dart';

class HumanModel extends ChangeNotifier {
  List<dynamic> _humanList = [];

  List<dynamic> get humanList => _humanList;


  List<dynamic> _imageList = [];

  List<dynamic> get imageList => _imageList;

  Future<void> getHuman() async {
    final routeFromJsonFile = await rootBundle.loadString('assets/people.json');
    _humanList = json.decode(routeFromJsonFile).map((ppl) => human.fromJson(ppl)).toList();
    notifyListeners();
  }

  Future<void> getImage() async {
    final routeFromJsonFile = await rootBundle.loadString('assets/images.json');
    _imageList = json.decode(routeFromJsonFile).map((img) => MyImage.fromJson(img)).toList();
    notifyListeners();
  }

  void shuffleImage(){
    _humanList.shuffle();
    notifyListeners();
  }

  void loadHuman() {
    getHuman();
    notifyListeners();
  }

}
