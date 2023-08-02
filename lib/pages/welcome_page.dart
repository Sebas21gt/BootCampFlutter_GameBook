import 'package:flutter/material.dart';
import 'package:game_book/auth.dart';
import 'package:game_book/constants.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    String? errorMessage = '';
    bool isLogin = false;

    Future<void> login() async {
      setState(() {
        isLogin = true;
      });
      try {
        await Auth().signInWithGoogle();
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, 'HomePage');
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
          
        });
      } finally {
        setState(() {
          isLogin = false;
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Column(
            children: [
              Stack(
                alignment: const Alignment(0, 1),
                children: [
                  Image.asset(
                    "assets/img/welcome.png",
                    height: height * 0.60,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/img/logo-horizontal.png",
                    height: height * 0.1,
                    width: width * 0.8,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(Style.padding),
                child: const Text(
                  'Bienvenid@ a la mejor aplicación sobre juegos, enterate de todos los juegos que estan haciendo tendencia en el mundo y diviertete',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Style.textColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                ),
                onPressed: () {
                  login();
                },
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image.asset('assets/icon/google-svgrepo-com 1.png',
                        width: 40),
                    const SizedBox(width: 40),
                    const Text(
                      'Iniciar sesión con Google',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
