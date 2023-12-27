import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

List<String> CACHE_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5'
];

class WebViews extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebViews(
      {this.url = '',
      this.statusBarColor = '',
      this.title = '',
      this.hideAppBar = false,
      this.backForbid = false});

  @override
  State<WebViews> createState() => _WebViewsState();
}

class _WebViewsState extends State<WebViews> {
  late WebViewController _webViewController;
  bool exiting = false;

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebView(
              onWebViewCreated: (controller) {
                // 将创建的WebViewController赋给_webViewController
                _webViewController = controller;
              },
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (String url) async {
                // 页面开始加载时的回调
                if (_isToMain(url) && !exiting) {
                  if (widget.backForbid) {
                    // 使用WebViewController的loadUrl方法加载新的URL
                    await _webViewController.loadUrl(widget.url);
                  } else {
                    Navigator.pop(context);
                    exiting = true;
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isToMain(String url) {
    bool contain = false;
    for (final value in CACHE_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  Widget _appBar(Color? backgroundColor, Color? backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      height: 56, // 添加一个明确的高度，可以根据需要调整
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      color: backgroundColor,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  // color: Colors.black,
                  size: 26,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title+'biubiubiu' ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              )
            )
          ],
        ),
      )
    );
  }

}

