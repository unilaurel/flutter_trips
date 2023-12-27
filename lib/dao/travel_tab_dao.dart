import 'dart:convert';
import 'dart:async';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;
import '../model/home_model.dart';



//旅拍大接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(Uri.parse('https://www.geekailab.com/io/flutter_app/json/travel_page.json'));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //zhongwen
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel__page.json');
    }
  }
}
