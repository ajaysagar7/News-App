import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:news_app/src/models/news_articles/news_articles.dart';

class FullNewsScreen extends StatefulWidget {
  final String url;
  final NewsArticles articles;
  const FullNewsScreen({
    Key? key,
    required this.url,
    required this.articles,
  }) : super(key: key);

  @override
  State<FullNewsScreen> createState() => _FullNewsScreenState();
}

class _FullNewsScreenState extends State<FullNewsScreen> {
   WebViewController? webViewController;

  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.articles.source!.name ?? "Full News"),
      ),
      body:  WebView(
        
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
