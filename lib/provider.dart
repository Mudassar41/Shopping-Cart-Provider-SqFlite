import 'package:flutter/material.dart';
import 'dbmanager.dart';

class provider extends ChangeNotifier{

  List<Student> _list=[];

  List<Student> get list => _list;

  void setlist(List<Student> value) {
    _list = value;
    notifyListeners();
  }}