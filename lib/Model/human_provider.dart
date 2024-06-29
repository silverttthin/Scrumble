import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/Model/human.dart';

class HumanProvider extends ChangeNotifier{
  List<human> _humanList = [];
  List<human>  get humanList => _humanList;


}