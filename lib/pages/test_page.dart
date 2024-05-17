import 'package:flutter/material.dart';
import 'package:project/components/app_bar_menu.dart';
import 'package:project/models/test_info.dart';
import 'package:project/pages/result_page.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.testInfo});
  final TestInfo testInfo;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<bool> answers = [];
  int answerNum = 0;

  void nextQuestion(bool answer) {
    setState(() {
      answers.add(answer);
      if (answerNum == widget.testInfo.answers.keys.toList().length - 1) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ResultPage(
                      answers: answers,
                      testName: widget.testInfo.testName,
                    )),
            (route) => false);
        return;
      }

      answerNum += 1;
    });
  }

  void prevQuestion() {
    if (answerNum == 0) {
      return;
    }
    setState(() {
      answerNum -= 1;
      answers.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.testInfo.testName),
        actions: const [AppBarMenu()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).hoverColor),
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: const Icon(
                    Icons.question_mark,
                    size: 100,
                  ),
                ),
              ),
              LinearProgressIndicator(
                value: (answerNum + 1) /
                    widget.testInfo.answers.keys.toList().length,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Text(
                  "Вопрос ${answerNum + 1}/${widget.testInfo.answers.keys.toList().length}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.testInfo.answers.keys.toList()[answerNum],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Column(
                children: List.generate(
                    widget
                        .testInfo
                        .answers[widget.testInfo.answers.keys.toList()[0]]
                        .keys
                        .length, (index) {
                  String answer = widget
                      .testInfo
                      .answers[widget.testInfo.answers.keys.toList()[answerNum]]
                      .keys
                      .toList()[index];
                  bool isCorrect = widget
                      .testInfo
                      .answers[widget.testInfo.answers.keys.toList()[answerNum]]
                      .values
                      .toList()[index];
                  return GestureDetector(
                    onTap: () => nextQuestion(isCorrect),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    softWrap: true,
                                    "${index + 1}) $answer",
                                    overflow: TextOverflow.clip,
                                    maxLines: 5,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                        const Divider()
                      ],
                    ),
                  );
                }),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 50),
                  child: ElevatedButton(
                    onPressed: prevQuestion,
                    child: const Text("Предыдущий вопрос"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
