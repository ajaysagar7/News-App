import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/src/view_models/providers/entertainment_provider.dart';
import 'package:news_app/src/views/Full%20Screen%20News/full_newsscreen.dart';
import 'package:news_app/src/views/widgets/News%20Tile/news_tile.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../api_constants.dart';
import '../../../view_models/providers/technology_provider.dart';

class EntertainmentScreen extends StatefulWidget {
  const EntertainmentScreen({Key? key}) : super(key: key);

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTechnologyArticles();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EnterainmentProvider>(builder: (c, providerWatch, _) {
        if (providerWatch.entertainmentState == EnterainmentState.loaded) {
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
        } else if (providerWatch.entertainmentState ==
            EnterainmentState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (providerWatch.entertainmentState ==
            EnterainmentState.error) {
          return Center(
            child: Text(providerWatch.errorMessage.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
      }),
    );
  }

  void getTechnologyArticles() async {
    await context
        .read<EnterainmentProvider>()
        .getArticles(category: "entertainment", isRefreshed: false);
  }

  void _onLoading({required BuildContext context}) async {
    await context
        .read<NewsProvider>()
        .getArticles(category: Endpoints.technology, isRefreshed: true)
        .then((value) => _refreshController.loadComplete());

    // if (result.isNotEmpty) {
    //   _refreshController.loadComplete();
    // } else {
    //   _refreshController.loadFailed();
    // }
  }

  void _onRefreshFunction() async {
    await context
        .read<EnterainmentProvider>()
        .getArticles(category: Endpoints.entertainment, isRefreshed: false)
        .then((value) => _refreshController.refreshCompleted());
  }
}
