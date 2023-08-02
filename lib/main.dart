// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_book/constants.dart';
import 'package:game_book/firebase_options.dart';
import 'package:game_book/pages/home_page.dart';
import 'package:game_book/pages/info_page.dart';
import 'package:game_book/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';

// ...

// void main() => runApp(const MyApp());
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        scaffoldBackgroundColor: Style.backgroundColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Style.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            textStyle: const TextStyle(
              color: Style.textColor
            ),
          ),
        ),
      ),
      initialRoute: 'WelcomePage',
      routes: {
        'WelcomePage': (context) => const WelcomePage(),
        'HomePage': (context) => const HomePage(),
        'InfoGamePage': (context) => InfoGamePage( id: ModalRoute.of(context)?.settings.arguments as String),
        // 'WebViewPage': (context) => const WebViewPage(),
      },
    );
  }
}