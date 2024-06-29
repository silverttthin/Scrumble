import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madcamp_week1_mission/Model/human.dart';

class HumanModel extends ChangeNotifier {
  List<dynamic> _humanList = [];

  List<dynamic> get humanList => _humanList;

  Future<void> getHuman() async {
    final routeFromJsonFile = await rootBundle.loadString('assets/people.json');
    _humanList = json.decode(routeFromJsonFile).map((ppl) => human.fromJson(ppl)).toList();
    notifyListeners();
  }

  void loadHuman() {
    getHuman();
    notifyListeners();
  }

}
