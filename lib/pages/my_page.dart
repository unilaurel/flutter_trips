import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/web_view.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViews(
        url: 'https://m.ctrip.com/webapp/myctrip/?from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',

      )
    );
  }
}