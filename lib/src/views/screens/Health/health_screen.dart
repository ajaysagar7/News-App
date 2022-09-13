import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/src/view_models/providers/health_provider.dart';
import 'package:news_app/src/views/Full%20Screen%20News/full_newsscreen.dart';
import 'package:news_app/src/views/widgets/News%20Tile/news_tile.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../api_constants.dart';
import '../../../view_models/providers/technology_provider.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTechnologyArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HealthProvider>(builder: (c, providerWatch, _) {
        if (providerWatch.healthState == HealthState.loaded) {
          return AnimationLimiter(
              child: SmartRefresher(
            enablePullUp: true,
            onRefresh: () => _onRefreshFunction(),
            enablePullDown: true,
            onLoading: () => _onLoading(context: c),
            controller: _refreshController,
            child: ListView.builder(
              itemCount: providerWatch.healthArticles.length,
              itemBuilder: (c, i) {
                var articles = providerWatch.healthArticles[i];
                return AnimationConfiguration.staggeredList(
                    position: i,
                    child: FadeInAnimation(
                      child: SlideAnimation(
                        verticalOffset: 10,
                        child: CustomNewsTile(
                          articles: articles,
                          callback: () => articles.url!.isNotEmpty
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => FullNewsScreen(
                                            url: articles.url!,
                                            articles: articles,
                                          )))
                              : Fluttertoast.showToast(
                                  msg:
                                      "Sorry, no url found for this news article😶😶😶😶😶😶....."),
                        ),
                      ),
                    ));
              },
            ),
          ));
        } else if (providerWatch.healthState == HealthState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (providerWatch.healthState == HealthState.error) {
          return Center(
            child: Text(providerWatch.errorMessage.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
      }),
    );
  }

  void getTechnologyArticles() async {
    await context
        .read<HealthProvider>()
        .getArticles(category: Endpoints.health, isRefreshed: false);
  }

  void _onLoading({required BuildContext context}) async {
    await context
        .read<HealthProvider>()
        .getArticles(category: Endpoints.health, isRefreshed: true)
        .then((value) => _refreshController.loadComplete());
  }

  void _onRefreshFunction() async {
    await context
        .read<HealthProvider>()
        .getArticles(category: Endpoints.health, isRefreshed: false)
        .then((value) => _refreshController.refreshCompleted());
  }
}
