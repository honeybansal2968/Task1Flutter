import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';
import 'package:get/get.dart';
import 'package:thesurvey/controllers/questionController.dart';
import 'package:thesurvey/pages/viewResult.dart';
import 'package:thesurvey/services/test_survey_service.dart';

import '../models/questionModel.dart';

class QuestionWidget extends StatefulWidget {
  final Map<String, dynamic> questionData;
  int index;
  final Function(String, String) onAnswerChanged;

  QuestionWidget(this.questionData, this.onAnswerChanged, this.index,
      {super.key});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? selectedOption;
  List<String> selectedOptions = [];
  QuestionController questionController = Get.find<QuestionController>();
  void saveAnswer() {
    String questionTitle = widget.questionData['questiontitle'];
    String answer = "";
    if (widget.questionData['ansertype'] == '1') {
      answer = questionController.textController.text;
    } else if (widget.questionData['ansertype'] == '2') {
      answer = selectedOption ?? '';
    } else if (widget.questionData['ansertype'] == '3') {
      answer = selectedOption ?? '';
    } else if (widget.questionData['ansertype'] == '4') {
      answer = selectedOptions.join(', ');
    } else if (widget.questionData['ansertype'] == '5') {
      answer = questionController.textController.text;
    }

    widget.onAnswerChanged(questionTitle, answer);
  }

  @override
  Widget build(BuildContext context) {
    String fieldType = 'Input Field (Text)';
    if (widget.questionData['ansertype'] == '1') {
      fieldType = 'Input Field (Text)';
    } else if (widget.questionData['ansertype'] == '2') {
      fieldType = 'Select Box (Dropdown)';
    } else if (widget.questionData['ansertype'] == '3') {
      fieldType = 'Radio Box';
    } else if (widget.questionData['ansertype'] == '4') {
      fieldType = 'Check Box (Multiple Select)';
    } else if (widget.questionData['ansertype'] == '5') {
      fieldType = 'Input Box (Date)';
    }

    List<String> options = widget.questionData['optionlist'].split(',');

    return GetBuilder<QuestionController>(builder: (questionController) {
      print("options $options");
      return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question Title: ${widget.questionData['questiontitle']}'),
            Text('Field Type: $fieldType'),
            const Text('Options:'),
            if (widget.questionData['ansertype'] == '2')
              DropdownButton<String>(
                // value:
                //     questionController.selectedOptions[widget.index.toString()],
                items: options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? value) {
                  questionController.selectedOptions[widget.index.toString()] =
                      value;
                  setState(() {});
                },
              )
            else if (widget.questionData['ansertype'] == '1')
              TextFormField(
                  initialValue: questionController
                      .selectedOptions[widget.index.toString()],
                  // controller: questionController.textController,
                  onSaved: (newValue) {
                    questionController
                        .selectedOptions[widget.index.toString()] = newValue;
                  },
                  onChanged: (value) => questionController
                      .selectedOptions[widget.index.toString()] = value)
            else if (widget.questionData['ansertype'] == '3')
              Column(
                children: options.map((String option) {
                  return ListTile(
                    title: Text(option),
                    leading: Radio(
                      value: option,
                      groupValue: questionController
                          .selectedOptions[widget.index.toString()],
                      onChanged: (value) {
                        questionController
                                .selectedOptions[widget.index.toString()] =
                            value.toString();
                        setState(() {
                          selectedOption = value as String;
                        });
                      },
                    ),
                  );
                }).toList(),
              )
            else if (widget.questionData['ansertype'] == '4')
              Column(
                children: options.map((String option) {
                  return ListTile(
                    title: Text(option),
                    leading: Checkbox(
                      value: selectedOptions.contains(option),
                      onChanged: (value) {
                        if (value != null && value) {
                          questionController
                              .selectedOptions[widget.index.toString()]
                              .add(option);
                        } else {
                          questionController
                              .selectedOptions[widget.index.toString()]
                              .remove(option);
                        }
                        setState(() {
                          if (value != null && value) {
                            questionController
                                .selectedOptions[widget.index.toString()]
                                .add(option);
                            selectedOptions.add(option);
                          } else {
                            questionController
                                .selectedOptions[widget.index.toString()]
                                .remove(option);

                            selectedOptions.remove(option);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              )
            else if (widget.questionData['ansertype'] == '5')
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  ).then((pickedDate) {
                    if (pickedDate != null && pickedDate != DateTime.now()) {
                      questionController
                              .selectedOptions[widget.index.toString()] =
                          '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                      setState(() {
                        questionController.textController.text =
                            pickedDate.toString();
                      });
                    }
                  });
                },
                child: Container(
                  height: 40,
                  color:
                      const Color.fromARGB(255, 237, 237, 237).withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(questionController
                          .selectedOptions[widget.index.toString()]),
                      const Icon(Icons.calendar_month)
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}

class QuestionPage extends StatefulWidget {
  List<QuestionModel> questions;
  QuestionPage({super.key, required this.questions});
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Map<String, String> answers = {};

  void onAnswerChanged(String questionTitle, String answer) {
    setState(() {
      answers[questionTitle] = answer;
    });
  }

  void submitAnswers() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Answers'),
          content: Column(
            children: [
              const Text("Response Submitted"),
              TextButton(
                  onPressed: () {
                    Get.to(() => ViewResultScreen(questions: widget.questions));
                  },
                  child: const Text("View Results"))
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.find<QuestionController>().initMap();
                Get.back();
                Get.back();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(questions: widget.questions),
        builder: (questionController) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Question Page'),
            ),
            body: ListView.builder(
              itemCount: widget.questions.length,
              itemBuilder: (context, index) {
                return QuestionWidget(
                    widget.questions[index].toJson(), onAnswerChanged, index);
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                TestSurveyService.saveSelectedOptions();
                submitAnswers();
              },
              child: const Icon(Icons.send),
            ),
          );
        });
  }
}
