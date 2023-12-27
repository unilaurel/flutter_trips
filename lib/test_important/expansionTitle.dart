import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

const CITY_NAMES={
  'bj':['dcq','xcq','cyq'],
  'sh':['hp','xh','cn']
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
     title: "列表展开与收起",
      home: Scaffold(
        appBar: AppBar(
          title: Text("列表展开与收起--"),
        ),
        body: Container(
          child: ListView(
            children:
              _buildList()
            ,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildList(){
    List<Widget> widgets=[];
    CITY_NAMES.keys.forEach((key) {
      widgets.add(_item(key,CITY_NAMES[key]!));
    });
    return widgets;
  }

  Widget _item(String city,List<String> subCities){
    return ExpansionTile(title:
    Text(city,style:TextStyle(color: Colors.black54,fontSize: 20),),
      children: subCities.map((subcity) => _buildSub(subcity)).toList(),
    );
  }

  Widget _buildSub(String subCity){
    return FractionallySizedBox(//FractionallySizedBox 是 Flutter 中的一个小部件，用于将其子部件调整为相对于父部件大小的一部分。这个小部件根据其 widthFactor 和 heightFactor 属性来确定子部件的宽度和高度。
      widthFactor: 0.8,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.blueAccent
        ),
        child: Text(subCity),
      ),

    );
  }
}
