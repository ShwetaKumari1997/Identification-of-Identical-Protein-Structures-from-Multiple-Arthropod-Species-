import 'package:flutter/material.dart';

import '../models/data_model.dart';

class AllDataProvider extends ChangeNotifier {
  List<DataModel> allData = [];


  void changeData(List<DataModel> data){
    allData = data;
    notifyListeners();
  }

}