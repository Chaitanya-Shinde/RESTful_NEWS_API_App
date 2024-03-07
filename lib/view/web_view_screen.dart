import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/providers/view_article_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    final viewArticleProvider = Provider.of<ViewArticleProvider>(context);
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(
          Uri.parse(viewArticleProvider.selectedArticle.url.toString()));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web View"),
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
