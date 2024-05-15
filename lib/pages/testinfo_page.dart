import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/components/app_bar_menu.dart';
import 'package:project/models/test_info.dart';
import 'package:project/pages/test_page.dart';

class TestInfoPage extends StatelessWidget {
  const TestInfoPage({super.key, required this.testInfo});
  final TestInfo testInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(testInfo.testName),
        actions: const [AppBarMenu()],
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: Column(
            children: [
              Container(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Основные правила теста",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const Divider(),
              Text(
                "На тест дается неограниченное количество времени. Тестируемый получает зачет, только при ответе на 80% вопросов (12 из 15). Для контрольного зачета необходимо сдать все тесты.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.bottomLeft,
                  child: FilledButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TestPage(testInfo: testInfo))),
                      child: const Text("Начать тест")))
            ],
          ),
        ),
      ),
    );
  }
}
