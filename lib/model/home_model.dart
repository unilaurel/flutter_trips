import 'package:flutter_trip/http.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/sales_box.dart';

import 'common_model.dart';
import 'grid_nav_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel(
      {required this.subNavList,
      required this.salesBox,
      required this.gridNav,
      required this.bannerList,
      required this.localNavList,
      required this.config});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson  = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((e) => CommonModel.fromJson(e)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    return HomeModel(
        subNavList: subNavList,
        salesBox: SalesBoxModel.fromJson(json['salesBox']) ,
        gridNav: GridNavModel.fromJson(json['gridNav']) ,
        bannerList: bannerList,
        localNavList: localNavList,
        config: ConfigModel.fromJson(json['config'])
    );
  }
}
