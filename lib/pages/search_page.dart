import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/pages/speak_page.dart';
import '../widget/search_bar.dart';
import '../res/listData.dart';

// const URL= 'https: //m.ctrip.com/restapi/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';
const URL = 'https://m.ctrip.com/html5/';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {super.key,
      this.hideLeft = false,
      this.searchUrl = URL,
      this.keyword = '',
      this.hint = ''});

  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchModel? searchModel;
  late String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _appBar(),
        // Expanded(
        //     child: ListView.builder(
        //         itemCount: searchModel?.data?.length ?? 0,
        //         itemBuilder: (BuildContext context, int position) {
        //           return _item(position);
        //         }))

        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
                child: ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      return Image.network(listData[index]['imageUrl']);
                    })))
      ],
    ));
  }

  _onTextChange(String text) {
    setState(() {
      keyword = text;
    });
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + text;
    SearchDao.fetch(url).then((SearchModel model) {
      setState(() {
        searchModel = model;
      });
    });
  }

  _appBar() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar_(
                hideLeft: widget.hideLeft,
                defaultText: widget.keyword,
                hint: widget.hint,
                speakClick: _jumpToSpeak,
                leafButtonClick: () {
                  Navigator.pop(context);
                },
                onChanged: _onTextChange),
          ),
        )
      ],
    );
  }

  _jumpToSpeak(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SpeakPage()));
  }
  _item(int position) {
    if (searchModel == null || searchModel?.data == null) return null;
    SearchItem? item = searchModel?.data[position];
    return Text(item!.word);
  }

  @override
  void initState() {
    searchModel = SearchModel();
  }
}
