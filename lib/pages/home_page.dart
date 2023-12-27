import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/speak_page.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loadding_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box_page.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/web_view.dart';

import '../model/grid_nav_model.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List _imageUrls = [
  //   'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
  //   'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
  //   'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  // ];

  double appBarAlpha = 0;
  String resultString = '';
  List<CommonModel> localNavList = [];
  GridNavModel? gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel? salesBoxModel;
  bool _loading = true;
  List<CommonModel> bannerList = [];




  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET; //滚动距离/滚动最大值
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      //滚动大于100就完全变成白色
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(offset);
    print(appBarAlpha);
  }

  Future<Null> _handleRefresh() async {
    HomeModel model = await HomeDao.fetch();
    setState(() {
      // resultString = json.encode(model.bannerList);
      localNavList = model.localNavList;
      gridNavModel = model.gridNav;
      subNavList = model.subNavList;
      salesBoxModel = model.salesBox;
      bannerList = model.bannerList;
      _loading = false;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(children: [
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: NotificationListener(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0) {
                        //==0表示只监听第0个子元素ListView的变化，否则swiper轮播图变化也被监听到
                        _onScroll(scrollNotification
                            .metrics.pixels); //pixels，表示当前滚动的位置
                        // return true;
                      }
                      return false;
                    },
                    child: _listView,
                  ),
                )),
            _appBar,
          ]),
        ));
  }

  Widget get _listView {
    return ListView(
      children: [
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(
            subNavList: subNavList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  Widget get _appBar {
    // return Opacity(
    //   opacity: appBarAlpha, //设置透明度
    //   child: Container(
    //       height: 80,
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //       ),
    //       child: Center(
    //         child: Padding(
    //           padding: EdgeInsets.only(top: 20),
    //           child: Text('首页'),
    //         ),
    //       )),
    // );

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0x66000000), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 80,
              decoration: BoxDecoration(
                color:
                    Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
              ),
              child: SearchBar_(
                searchBarType: appBarAlpha > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
                inputBoxClick: _jumpToSearch,
                speakClick: _jumpToSpeak,
                defaultText: SEARCH_BAR_DEFAULT_TEXT,
                leafButtonClick: () {},
              ),
            )),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  Widget get _banner {
    return Container(
        height: 160,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                CommonModel model = bannerList[index];
                NavigatorUtil.push(context, WebViews(
                  url: model.url,
                  title: model.title,
                  hideAppBar: model.hideAppBar,
                ));
              },
              child: Image.network(
                bannerList[index].icon,
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: bannerList.length,
          autoplay: true,
          pagination: SwiperPagination(), //显示轮播图分页指示器的配置项
        ));
  }

  _jumpToSearch() {
    NavigatorUtil.push(context, SearchPage(
      hint: SEARCH_BAR_DEFAULT_TEXT,
    ));
  }

  _jumpToSpeak() {
    NavigatorUtil.push(context, SpeakPage());
  }
}
