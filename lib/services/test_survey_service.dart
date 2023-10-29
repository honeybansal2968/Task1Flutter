import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thesurvey/constants/values.dart';
import 'package:http/http.dart' as http;
import 'package:thesurvey/controllers/questionController.dart';
import 'package:thesurvey/models/questionModel.dart';

class TestSurveyService {
  // fetch question
  static Future<List<QuestionModel>> fetchQuestions() async {
    Uri url = Uri.parse(apiEndPoint + questionApi);
    http.Response response = await http.post(url, body: {
      'category': 40.toString(),
    });
    List<QuestionModel> questions = [];
    // print(
    //     "jsonDecode(response.body) ${QuestionModel.fromJson(jsonDecode(response.body))}");
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        questions.add(QuestionModel.fromJson(data[i]));
      }
      return questions;
    } else {
      return [];
    }
  }

  // Method to save selected options using shared preferences
  static Future<void> saveSelectedOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedOptions',
        Get.find<QuestionController>().selectedOptions.toString());
  }

  // Method to retrieve selected options from shared preferences
  static Future<void> getSelectedOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedOptionsString = prefs.getString('selectedOptions');
    if (selectedOptionsString != null) {
      Map<String, dynamic> selectedOptionsMap = Map.from(
          Map<String, dynamic>.from(jsonDecode(selectedOptionsString)));
      Get.find<QuestionController>().selectedOptions.addAll(selectedOptionsMap);
    }
  }
}
