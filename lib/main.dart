import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/firebase_options.dart';
import 'package:project/pages/auth_page.dart';
import 'package:project/services/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool lightTheme = true;
  late ThemeData currentTheme;

  @override
  void initState() {
    super.initState();
    initThemeData();
    print(lightTheme);
  }

  Future initThemeData() async {
    lightTheme = await getThemeMode();
    setState(() {
      currentTheme = lightTheme
          ? ThemeData(
              brightness: Brightness.light,
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xff48680E)),
              useMaterial3: true,
              textTheme: GoogleFonts.latoTextTheme(),
            )
          : ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xff48680E),
                  brightness: Brightness.dark),
            );
    });
  }

  Future<bool> getThemeMode() async {
    var prefs = await SharedPreferences.getInstance();
    print(prefs.getBool("lightTheme"));
    return prefs.getBool("lightTheme") ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Colors.lightGreen[900]!
      themeMode: Provider.of<ThemeProvider>(context).lightThemeMode
          ? ThemeMode.light
          : ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff48680E)),
        useMaterial3: true,
        // textTheme: GoogleFonts.latoTextTheme(),
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff48680E), brightness: Brightness.dark)),

      home: const AuthPage(),
    );
  }
}
