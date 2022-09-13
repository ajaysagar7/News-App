import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/src/views/Full%20Screen%20News/full_newsscreen.dart';
import 'package:news_app/src/views/widgets/News%20Tile/news_tile.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../services/api_constants.dart';
import '../../../view_models/providers/technology_provider.dart';

class TechnologyScreen extends StatefulWidget {
  const TechnologyScreen({Key? key}) : super(key: key);

  @override
  State<TechnologyScreen> createState() => _TechnologyScreenState();
}

class _TechnologyScreenState extends State<TechnologyScreen> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<NewsProvider>()
          .getArticles(category: Endpoints.technology, isRefreshed: false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var providerWatch = Provider.of<NewsProvider>(context);
    // var providerRead = Provider.of<NewsProvider>(context, listen: false);

    return Scaffold(
      body: Consumer<NewsProvider>(builder: (c, providerWatch, _) {
        if (providerWatch.technologyState == TechnologyState.loaded) {
          return AnimationLimiter(
              child: SmartRefresher(
            enablePullUp: true,
            onRefresh: () => _onRefreshFunction(),
            enablePullDown: true,
            onLoading: () => _onLoading(context: c),
            controller: _refreshController,
            child: ListView.builder(
              itemCount: providerWatch.articels!.length,
              itemBuilder: (c, i) {
                var articles = providerWatch.articels![i];
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
        } else if (providerWatch.technologyState == TechnologyState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (providerWatch.technologyState == TechnologyState.error) {
          return const Center(
            child: Text("something went wrong"),
          );
        } else {
          return const Center(
            child: Text("Initial state of the app"),
          );
        }
      }),
    );
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
        .read<NewsProvider>()
        .getArticles(category: Endpoints.technology, isRefreshed: false)
        .then((value) => _refreshController.refreshCompleted());
  }
}
