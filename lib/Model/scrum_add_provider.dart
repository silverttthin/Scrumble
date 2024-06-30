

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';


class ScrumAddProvideer extends ChangeNotifier {
  XFile? _image;
  XFile? get image => _image;


  String _name = "";
  String get name => _name;

  int _name_id = -1;
  int get name_id => _name_id;




  final ImagePicker picker = ImagePicker();
  void initialize(){
    _image = null;
    _name = "";
    _name_id = -1;

    notifyListeners();
  }

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
    }
    notifyListeners();
  }

  void setPeople(String name, int id){
    _name = name;
    _name_id = id;
    notifyListeners();
  }


}