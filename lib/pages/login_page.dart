import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? togglePages;
  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String getErrorDescription(String errorCode) {
    switch (errorCode) {
      case 'too-many-requests':
        return '*Превышено количество запросов.';
      case 'wrong-password':
        return '*Неправильный пароль.';
      case 'network-request-failed':
        return '*Ошибка сети.';
      case 'invalid-email':
        return '*Неправильный адрес электронной почты.';
      case 'user-disabled':
        return '*Пользователь заблокирован.';
      case 'user-not-found':
        return '*Пользователь не найден.';
      case 'channel-error':
        return '*Есть незаполненные поля';
      case 'invalid-credential':
        return '*Данные введены неверно';
      default:
        return '*Неизвестная ошибка.';
    }
  }

  void wrongData(String data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getErrorDescription(data)),
        action: SnackBarAction(
          label: "Войти",
          onPressed: signUserIn,
        )));
  }

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      wrongData(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 30, horizontal: MediaQuery.sizeOf(context).width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: widget.togglePages,
                    child: Text(
                      "Создать аккаунт",
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  "Войти",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: "Почта",
                  ),
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  labelText: "Пароль",
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: FilledButton(
                          onPressed: signUserIn,
                          style: FilledButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20)),
                          child: const Text("Войти"),
                        )),
                  )
                ],
              ),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Или")),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              OutlinedButton(
                  onPressed: () => AuthService().signInWithGoogle(),
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30)),
                  child: Row(
                    children: [
                      Image.asset(
                        "lib/assets/img/google.png",
                        width: 20,
                        height: 20,
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text("Войти через Google"))
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
