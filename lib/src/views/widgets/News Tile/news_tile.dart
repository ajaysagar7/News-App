import 'package:flutter/material.dart';

import 'package:news_app/src/models/news_articles/news_articles.dart';

class CustomNewsTile extends StatelessWidget {
  final NewsArticles articles;
  final VoidCallback callback;
  const CustomNewsTile({
    Key? key,
    required this.articles,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: callback,
        child: Card(
          elevation: 10.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        child: SizedBox(
                          height: 120,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.0),
                            child: Image.network(
                              articles.urlToImage ??
                                  "https://upload.wikimedia.org/wikipedia/commons/9/9b/Google_news_logo.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(articles.source!.name ?? "Local News"),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          articles.title ?? "Google News",
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          articles.description ?? "",
                          maxLines: 4,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
