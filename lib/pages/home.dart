import 'package:flutter/material.dart';
import 'package:project/pages/account_page.dart';
// import 'package:project/pages/home_page.dart';
import 'package:project/pages/tests_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.question_mark_rounded), label: "Тесты"),
          // NavigationDestination(
          //     icon: Icon(Icons.home_rounded), label: "Главная"),
          NavigationDestination(
              icon: Icon(Icons.account_circle_rounded), label: "Личный кабинет")
        ],
      ),
      body: const <Widget>[
        TestsPage(),
        // HomePage(),
        AccountPage()
      ][currentPageIndex],
    );
  }
}
