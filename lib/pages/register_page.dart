import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    final emailController = TextEditingController();

    final passwordController = TextEditingController();

    String getErrorDescription(String errorCode) {
      switch (errorCode) {
        case 'too-many-requests':
          return '*Превышено количество запросов.';
        case 'email-already-in-use':
          return '*Уже зарегистрированный email';
        case 'network-request-failed':
          return '*Ошибка сети.';
        case 'invalid-email':
          return '*Неправильный адрес электронной почты.';
        case 'weak-password':
          return '*Слабый пароль.';
        case 'channel-error':
          return '*Есть незаполненные поля';
        case 'invalid-credential':
          return '*Данные введены неверно';
        default:
          return '*Неизвестная ошибка.';
      }
    }

    void wrongData(String data, BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getErrorDescription(data)),
          action: SnackBarAction(
            label: "Войти",
            onPressed: () {},
          )));
    }

    void signUserUp(BuildContext context) async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await FirebaseAuth.instance.currentUser!
            .updateDisplayName(nameController.text);
      } on FirebaseAuthException catch (e) {
        wrongData(e.code, context);
      }
    }

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
                    onTap: togglePages,
                    child: Text(
                      "Войти",
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  "Создать аккаунт",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  labelText: "Имя",
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
                          onPressed: () => signUserUp(context),
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
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  "Нажимая кнопку зарегистрироваться вы соглашаетесь с правилами использования приложения",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
