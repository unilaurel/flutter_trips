import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/common_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String showResult = '';

  Future<CommonModel> fetchPost() async {
    final respose = await http.get(Uri.parse(
        'http://www.devio.org/io/flutter_app/json/test_common_model.json'));
    final result = json.decode(respose.body);
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('http'),
          ),
          body: FutureBuilder<CommonModel>(
            future: fetchPost(),
            builder:
                (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("input a url to start");
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  return Text('');
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return Column(
                      children: [
                        Text('icon:${snapshot.data?.icon}'),
                        Text('statusBarColor:${snapshot.data?.statusBarColor}'),
                        Text('title:${snapshot.data?.title}'),
                        Text('url:${snapshot.data?.url}'),
                      ],
                    );
                  }
              }
            },
          )),
    );
  }
}

// class CommonModel {
//   final String icon;
//   final String title;
//   final String url;
//   final String statusBarColor;
//   final bool hideAppBar;
//
//   CommonModel(
//       {this.icon = '',
//       this.title = '',
//       this.url = '',
//       this.statusBarColor = '',
//       this.hideAppBar = false});
//
//   factory CommonModel.fromJson(Map<String, dynamic> json) {
//     return CommonModel(
//       icon: json['icon'] ?? '',
//       title: json['title'] ?? '',
//       url: json['url'] ?? '',
//       statusBarColor: json['statusBarColor'] ?? '',
//       hideAppBar: json['hideAppBar'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'icon': icon,
//       'title': title,
//       'url': url,
//       'statusBarColor': statusBarColor,
//       'hideAppBar': hideAppBar
//     };
//   }
// }
