import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thesurvey/controllers/questionController.dart';
import 'package:thesurvey/models/questionModel.dart';

class ViewResultScreen extends StatelessWidget {
  List<QuestionModel> questions;
  ViewResultScreen({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(builder: (questionController) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text('View Result')),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question Title: ${questions[index].questiontitle}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Text("Answer:"),
                    Text(
                        "${questionController.selectedOptions[index.toString()]}"),
                  ],
                );
              }),
        ),
      );
    });
  }
}
