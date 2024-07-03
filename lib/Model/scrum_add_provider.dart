

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ScrumAddProvideer extends ChangeNotifier {
  File? _image;
  File? get image => _image;


  String _name = "";
  String get name => _name;

  String _url = "";
  String get url => _url;

  int _name_id = -1;
  int get name_id => _name_id;

  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  final ImagePicker picker = ImagePicker();
  void initialize(){
    _image = null;
    _name = "";
    _url = "";
    _name_id = -1;

    notifyListeners();
  }

  void setImage(String str){
    _url = str;
    notifyListeners();
  }




  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    notifyListeners();
  }

  Future<String> uploadImage() async {
    final now = DateTime.now();
    // var ref = storage.ref().child('Images/$now.jpg');
    // var uploadTask = ref.putFile(_image!);
    //
    // final snapshot = await uploadTask.whenComplete(() => {
    //   Fluttertoast.showToast(
    //   msg: "이미지 업로드 완료",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.CENTER,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: MadColor.mainColor,
    //   textColor: Colors.white,
    //   fontSize: 16.0
    //   )
    //
    // });
    // final url = await snapshot.ref.getDownloadURL();
    //
    // return url;


    Reference  ref = storage.ref().child("/$now.jpg");
    UploadTask  uploadTask = ref.putFile(_image!);

    var dowurl = await (await uploadTask).ref.getDownloadURL();
    String url = dowurl.toString();

    return url;
    // firebaseFirestore.collection('Images').doc().set({
    //   'url': url,
    // });
  }

  void setPeople(String name, int id){
    _name = name;
    _name_id = id;
    notifyListeners();
  }


}