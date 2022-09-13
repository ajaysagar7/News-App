import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/constants/app_strings.dart';
import 'package:news_app/src/views/screens/Entertainment/entertainment_screen.dart';
import 'package:news_app/src/views/screens/General/general_screen.dart';
import 'package:news_app/src/views/screens/Health/health_screen.dart';
import 'package:news_app/src/views/screens/Science/science_screen.dart';
import 'package:news_app/src/views/screens/Sports/sports_screen.dart';
import 'package:news_app/src/views/screens/Technology/technology_screen.dart';
import 'package:news_app/src/views/widgets/Drawer/custom_drawer.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppString.homeTitle),
          centerTitle: true,
          bottom: TabBar(
            automaticIndicatorColorAdjustment: true,
            dragStartBehavior: DragStartBehavior.start,
            controller: tabController,
            enableFeedback: true,
            isScrollable: true,
            tabs: const [
              Tab(
                child: Text("Technology"),
              ),
              Tab(
                child: Text("Entertainment"),
              ),
              Tab(
                child: Text("Sports"),
              ),
              Tab(
                child: Text("Science"),
              ),
              Tab(
                child: Text("Health"),
              ),
              Tab(
                child: Text("Business"),
              ),
            ],
          ),
        ),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text("Tap again to exit the app"),
          ),
          child: TabBarView(controller: tabController, children: const [
            TechnologyScreen(),
            EntertainmentScreen(),
            SportsScreen(),
            ScienceScreen(),
            HealthScreen(),
            BusinessScreen(),
          ]),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
