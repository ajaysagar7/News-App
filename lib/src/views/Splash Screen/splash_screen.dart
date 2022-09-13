import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/src/views/screens/news_homescreen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const NewsHomeScreen(),
              type: PageTransitionType.bottomToTop));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lib/assets/logo.json'),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "News App",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const CircularProgressIndicator(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
