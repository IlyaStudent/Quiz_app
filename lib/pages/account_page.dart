import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/components/app_bar_menu.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Личный кабинет"),
        leading: const Icon(Icons.arrow_back),
        actions: const [AppBarMenu()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Icon(
                Icons.account_circle,
                size: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Здравствуйте, ${FirebaseAuth.instance.currentUser?.displayName}",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout),
                  Padding(
                      padding: EdgeInsets.only(left: 10), child: Text("Выйти")),
                ],
              ),
              // child: const Text("Выйти"),
            ),
          ],
        ),
      ),

      // Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       FirebaseAuth.instance.signOut();
      //     },
      //     child: const Text("Выйти"),
      //   ),
      // ),
    );
  }
}
