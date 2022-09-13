import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/src/view_models/providers/science_state.dart';
import 'package:news_app/src/views/Full%20Screen%20News/full_newsscreen.dart';
import 'package:news_app/src/views/widgets/News%20Tile/news_tile.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../api_constants.dart';
import '../../../view_models/providers/technology_provider.dart';

class ScienceScreen extends StatefulWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  State<ScienceScreen> createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {
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
      body: Consumer<ScienceProvider>(builder: (c, providerWatch, _) {
        if (providerWatch.scienceState == ScienceState.loaded) {
          return AnimationLimiter(
              child: SmartRefresher(
            enablePullUp: true,
            onRefresh: () => _onRefreshFunction(),
            enablePullDown: true,
            onLoading: () => _onLoading(context: c),
            controller: _refreshController,
            child: ListView.builder(
              itemCount: providerWatch.scienceArticlesList.length,
              itemBuilder: (c, i) {
                var articles = providerWatch.scienceArticlesList[i];
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
        } else if (providerWatch.scienceState == ScienceState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (providerWatch.scienceState == ScienceState.error) {
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
        .read<ScienceProvider>()
        .getScienceArticels(category: Endpoints.science, isRefreshed: false);
  }

  void _onLoading({required BuildContext context}) async {
    await context
        .read<ScienceProvider>()
        .getScienceArticels(category: Endpoints.science, isRefreshed: true)
        .then((value) => _refreshController.loadComplete());

    // if (result.isNotEmpty) {
    //   _refreshController.loadComplete();
    // } else {
    //   _refreshController.loadFailed();
    // }
  }

  void _onRefreshFunction() async {
    await context
        .read<ScienceProvider>()
        .getScienceArticels(category: Endpoints.science, isRefreshed: false)
        .then((value) => _refreshController.refreshCompleted());
  }
}
