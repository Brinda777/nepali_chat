import 'package:flutter/material.dart';
import 'package:nepali_chat/screen/login.dart';

class SplashPage extends StatefulWidget {
  static String route = "SplashPage";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // app open huda--> app initialize
  @override
  void initState() {
    print("App started--> init state");
    goToScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("App build method called");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Welcome to Nepali Chat",
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            Image.asset("images/chat.png"),
          ],
        ),
      ),
    );
  }

  void goToScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushNamed(context, LoginScreen.route);
  }
}
