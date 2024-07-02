
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/Model/Trend.dart';

class TrendProvider extends ChangeNotifier{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Trend>> getTrend() {
    return FirebaseFirestore.instance.collection('trend').snapshots()
        .map((list) =>
        list.docs.map((doc) => Trend.fromJson(doc.data())).toList());
  }
}