import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/ui/plan_widget.dart';
import 'package:flutter_zjy/ui/reportcard_widget.dart';

import 'home_widget.dart';
import 'my_widget.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget>
    with AutomaticKeepAliveClientMixin {
  PageController _pageController = PageController();
  int _selectedIndex = 0; // 当前选中的索引

  /// tabs的名字
  final bottomBarTitles = ["资讯", "方案", "排行", "我的"];

  var pages = <Widget>[
    HomeScreen(),
    PlanWidget(),
    ReportCardWidget(),
    MyWidget()
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // TODO: implement build
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageView.builder(
          itemBuilder: (context, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed, // 设置显示模式
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.art_track), title: Text(bottomBarTitles[0])),
            BottomNavigationBarItem(
                icon: Icon(Icons.videogame_asset),
                title: Text(bottomBarTitles[1])),
            BottomNavigationBarItem(
                icon: Icon(Icons.assessment), title: Text(bottomBarTitles[2])),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), title: Text(bottomBarTitles[3]))
          ],
          onTap: (int index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('提示'),
            content: new Text('确定退出应用吗？'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('再看一会', style: TextStyle(color: Colors.cyan)),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('退出', style: TextStyle(color: Colors.cyan)),
              ),
            ],
          ),
        ) ??
        false;
  }
}
