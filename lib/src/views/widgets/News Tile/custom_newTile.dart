import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/news_articles/news_articles.dart';

class NewsTile extends StatelessWidget {
  final NewsArticles article;
  final VoidCallback callback;
  const NewsTile({
    Key? key,
    required this.article,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Card(
        elevation: 10.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.010,
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: () => callback,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      article.urlToImage ??
                          "https://upload.wikimedia.org/wikipedia/commons/9/9b/Google_news_logo.png",
                      fit: BoxFit.cover,
                      height: size.height * 0.200,
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 5,
                  child: Card(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    elevation: 7,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        article.source!.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.blueAccent],
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          DateFormat.MMMEd()
                              .format(DateTime.parse(article.publishedAt!)),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
