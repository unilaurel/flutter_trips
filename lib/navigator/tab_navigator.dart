import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/my_page.dart';
import '../pages/search_page.dart';
import '../pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(
            hideLeft: true,
          ),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: _defaultColor,
        selectedItemColor: _activeColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _bottomItem('首页', Icons.home),
          _bottomItem('搜索', Icons.search),
          _bottomItem('旅拍', Icons.camera_alt),
          _bottomItem('我的', Icons.account_circle),

          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.account_circle,
          //       color: _defaultColor,
          //     ),
          //     activeIcon: Icon(
          //       Icons.account_circle,
          //       color: _activeColor,
          //     ),
          //     label: "我的"),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
      label: title
    );
  }
}
