import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Catigory.dart';

void main() {
  runApp(const ChatGptApp());
}

class ChatGptApp extends StatelessWidget {
  final String botUrl = 'https://chatgpt.com/?model=auto';

  const ChatGptApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewScreen(url: botUrl),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() {
    return _WebViewScreenState();
  }
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const Category();
            }));
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: darkmode ? Colors.orange : Colors.black,
        ),
        backgroundColor: Colors.black45,
        title: const Center(
          child: Text(
            'Chat Gpt',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'lemon',
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'about:blank',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _webViewController = controller;
              _loadUrl();
            },
            onPageFinished: (url) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (error) {
              setState(() {
                _isLoading = false;
              });
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Failed to load web page.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _isLoading = true;
                          });
                          _loadUrl();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          if (_isLoading)
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _loadUrl() async {
    await _webViewController.loadUrl(widget.url);
  }

  @override
  void dispose() {
    // Clear cookies
    CookieManager().clearCookies();
    super.dispose();
  }
}
