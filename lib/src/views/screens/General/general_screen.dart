import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/src/view_models/providers/general_provider.dart';
import 'package:news_app/src/views/Full%20Screen%20News/full_newsscreen.dart';
import 'package:news_app/src/views/widgets/News%20Tile/news_tile.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../api_constants.dart';
import '../../../view_models/providers/technology_provider.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
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
      body: Consumer<GeneralProvider>(builder: (c, providerWatch, _) {
        if (providerWatch.generalState == GeneralState.loaded) {
          return AnimationLimiter(
              child: SmartRefresher(
            enablePullUp: true,
            onRefresh: () => _onRefreshFunction(),
            enablePullDown: true,
            onLoading: () => _onLoading(context: c),
            controller: _refreshController,
            child: ListView.builder(
              itemCount: providerWatch.generalArticles.length,
              itemBuilder: (c, i) {
                var articles = providerWatch.generalArticles[i];
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
        } else if (providerWatch.generalState == GeneralState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (providerWatch.generalState == GeneralState.error) {
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
        .read<GeneralProvider>()
        .getArticles(category: Endpoints.general, isRefreshed: false);
  }

  void _onLoading({required BuildContext context}) async {
    await context
        .read<GeneralProvider>()
        .getArticles(category: Endpoints.general, isRefreshed: true)
        .then((value) => _refreshController.loadComplete());

    // if (result.isNotEmpty) {
    //   _refreshController.loadComplete();
    // } else {
    //   _refreshController.loadFailed();
    // }
  }

  void _onRefreshFunction() async {
    await context
        .read<GeneralProvider>()
        .getArticles(category: Endpoints.general, isRefreshed: false)
        .then((value) => _refreshController.refreshCompleted());
  }
}
