
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madcamp_week1_mission/Model/scrum.dart';

class ScrumProvider extends ChangeNotifier{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Scrum>> getNotes() {
    return FirebaseFirestore.instance.collection('scrums').snapshots()
        .map((list) =>
        list.docs.map((doc) => Scrum.fromJson(doc.data())).toList());
  }
}