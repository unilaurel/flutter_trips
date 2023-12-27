import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/dao/travel_tab_dao.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/widget/loadding_container.dart';
import 'package:flutter_trip/widget/web_view.dart';

const PAGE_SIZE = 20;
const TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelTabPage extends StatefulWidget {
  final String? travelUrl;
  final String? groupChannelCode;

  const TravelTabPage(
      {super.key, this.travelUrl = '', this.groupChannelCode = ''});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool _loading=true;
  ScrollController _scrollController=ScrollController();


  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        _loadData(loadMore: true);
      }
    });
    super.initState();

  }

  _loadData({loadMore=false}) {
    if(loadMore){
      pageIndex++;
    }else{
      pageIndex=1;
    }
    TravelDao.fetch(widget.travelUrl ?? TRAVEL_URL, widget.groupChannelCode!,
            pageIndex, PAGE_SIZE)
        .then((TravelItemModel model) {
          _loading=false;
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);

        travelItems.addAll(items);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //     body: ListView(
        //   children: [
        //     StaggeredGrid.count(
        //       crossAxisCount: 2,
        //       // mainAxisSpacing: 2,
        //       children: travelItems.isNotEmpty
        //           ? travelItems
        //               .map((e) => StaggeredGridTile.count(
        //                   crossAxisCellCount: 1,
        //                   mainAxisCellCount: 1,
        //                   child: _TravelItem(item: e, index: e.article!.articleId)))
        //               .toList()
        //           : [CircularProgressIndicator()],
        //     )
        //   ],
        // )

        body: LoadingContainer(
          isLoading: _loading,
          child: RefreshIndicator(
            onRefresh: _handRefresh,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: MasonryGridView.count(
                controller: _scrollController ,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 2,
                itemBuilder: (context, index) {
                  if (index < travelItems.length) {
                    return _TravelItem(item: travelItems[index], index: index);
                  } else {
                    return SizedBox.shrink(); // 或者其他处理无效 index 的逻辑
                  }
                },
              ),
            ),
            
          ),

        )
    );
    ;
  }

  List<TravelItem> _filterItems(List<TravelItem>? resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    resultList.forEach((item) {
      //移除article为空的模型
      if (item.article != null) {
        filterItems.add(item);
      }
    });
    return filterItems;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<Null> _handRefresh() async{
    _loadData();
    return null;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _TravelItem extends StatelessWidget {
  final TravelItem item;
  final int? index;

  const _TravelItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.article!.urls != null && item.article!.urls!.length != 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViews(
                        url: item.article!.urls![1].h5Url!,
                        title: '详情',
                      )));
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemImage(),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article!.articleTitle!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText()
            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: [
        Image.network(item.article!.images![0].dynamicUrl!),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _poiName(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  String _poiName() {
    return item.article?.pois == null || item.article?.pois?.length == 0
        ? '未知'
        : item.article?.pois![0].poiName ?? '未知2';
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(

            children: [
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article!.author!.coverImage!.dynamicUrl!,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item.article!.author!.nickName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article!.likeCount!.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
