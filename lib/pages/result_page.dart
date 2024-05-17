import 'package:flutter/material.dart';
import 'package:project/components/app_bar_menu.dart';
import 'package:project/pages/home.dart';
import 'package:project/services/firebase_database.dart';

class ResultPage extends StatefulWidget {
  final List<bool> answers;
  final String testName;
  const ResultPage({super.key, required this.answers, required this.testName});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    double result = widget.answers.where((element) => element == true).length /
        widget.answers.length;
    if (result >= 0.8) {
      FirebaseDatabase().markTestComplete(widget.testName);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Результат"),
        actions: const [AppBarMenu()],
        leading: const Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).hoverColor),
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: Icon(
                  result >= 0.8
                      ? Icons.verified_rounded
                      : Icons.not_interested_rounded,
                  color: result >= 0.8
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onError,
                  size: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "${widget.answers.where((element) => element == true).length}/${widget.answers.length}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
              result >= 0.8
                  ? "Поздравляю, вы успешно сдали тест!"
                  : "К сожалению, вы не набрали минимальное количество балов, изучите материал лучшие и повторите попытку",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 30),
                child: Divider()),
            ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false),
                child: const Text("На главную"))
          ],
        ),
      ),
    );
  }
}
