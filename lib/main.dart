import 'package:flutter/material.dart';
import 'package:news_app/setup%20locatior/setup_locator.dart';
import 'package:news_app/src/view_models/providers/entertainment_provider.dart';
import 'package:news_app/src/view_models/providers/general_provider.dart';
import 'package:news_app/src/view_models/providers/health_provider.dart';
import 'package:news_app/src/view_models/providers/science_state.dart';
import 'package:news_app/src/view_models/providers/sports_provider.dart';
import 'package:news_app/src/view_models/providers/technology_provider.dart';
import 'package:news_app/src/views/Splash%20Screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => EnterainmentProvider()),
        ChangeNotifierProvider(create: (c) => GeneralProvider()),
        ChangeNotifierProvider(create: (c) => HealthProvider()),
        ChangeNotifierProvider(create: (c) => ScienceProvider()),
        ChangeNotifierProvider(create: (c) => SportsProvider()),
        ChangeNotifierProvider(create: (c) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News Clone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
