import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thesurvey/models/questionModel.dart';

class QuestionController extends GetxController {
  List<QuestionModel> questions;
  TextEditingController textController = TextEditingController();

  QuestionController({required this.questions});
  Map<String, dynamic> selectedOptions = {};
  // method to initialize selectedOptions keys
  void initList() {
    selectedOptions = {
      for (var item in List.generate(questions.length, (i) => i))
        item.toString(): []
    };
    print(selectedOptions);
  }

  void initMap() {
    for (var i = 0; i < questions.length; i++) {
      if (questions[i].ansertype == '1') {
        selectedOptions[i.toString()] = '';
      } else if (questions[i].ansertype == '2') {
        selectedOptions[i.toString()] = 'Select option';
      } else if (questions[i].ansertype == '3') {
        selectedOptions[i.toString()] = '';
      } else if (questions[i].ansertype == '4') {
        selectedOptions[i.toString()] = [];
      } else if (questions[i].ansertype == '5') {
        selectedOptions[i.toString()] = '';
      }
    }
    print(selectedOptions);
  }

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
     initList();
     initMap();
  }
}
