import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/components/app_bar_menu.dart';
import 'package:project/models/test_info.dart';
import 'package:project/pages/testinfo_page.dart';
import 'package:project/services/firebase_database.dart';

class TestsPage extends StatefulWidget {
  const TestsPage({super.key});

  @override
  State<TestsPage> createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  late Future<Map<String, dynamic>> testsInfo;
  Map<String, dynamic>? testsData;
  List<String>? testNames;

  @override
  void initState() {
    testsInfo = FirebaseDatabase().getAllTestInfo();
    super.initState();
  }

  Widget _buildCard(BuildContext context, String testName, int questNum) {
    return Card.filled(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                padding: const EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  testName,
                  style: Theme.of(context).textTheme.headlineLarge,
                )),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 15),
              child: Text(
                "$questNum вопросов",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey[500]),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Тесты"),
        leading: const Icon(Icons.arrow_back),
        actions: const [AppBarMenu()],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: FutureBuilder(
                future: testsInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error ${snapshot.error}"),
                    );
                  }

                  testsData = snapshot.data;
                  testNames = snapshot.data?.keys.toList();

                  return Column(
                    children: List.generate(snapshot.data!.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TestInfoPage(
                                        testInfo: TestInfo(
                                            testName: testNames![index],
                                            answers: snapshot
                                                .data![testNames![index]]),
                                      )));
                        },
                        child: _buildCard(
                          context,
                          testNames![index],
                          snapshot.data![testNames![index]].keys.length,
                        ),
                      );
                    }),
                  );
                })),
      ),
    );
  }
}
