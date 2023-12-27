import 'dart:convert';
import 'dart:async';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;
import '../model/home_model.dart';

//旅拍页的接口
 Map<String, dynamic> Params = {
  "districtId": -1,
  "groupChannelCode": "tourphoto_global1",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 2,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {},
  "contentType": "json"
};
//彩蛋，固定参数里更改某些参数，可以用这种方式
class TravelDao {
  static Future<TravelItemModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Map<String,dynamic> paramsMap = Params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    Params['groupChannelCode'] = groupChannelCode;

    final response = await http.post(Uri.parse(url), body: jsonEncode(Params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //zhongwen
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {

      throw Exception('Failed to load travel_dao_page.json');
    }
  }
}
