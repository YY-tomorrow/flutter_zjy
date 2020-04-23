import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/router.dart';
import 'package:flutter_zjy/ui/plan_widget.dart';
import 'package:flutter_zjy/ui/reportcard_widget.dart';

import 'home_widget.dart';
import 'my_widget.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0; // 当前选中的索引

  /// tabs的名字
  final bottomBarTitles = ["资讯", "方案", "排行", "我的"];

  final bottomBarIcons = [
    Icons.art_track,
    Icons.videogame_asset,
    Icons.assessment,
    Icons.account_box
  ];

  var pages = <Widget>[
    HomeScreen(),
    PlanWidget(),
    ReportCardWidget(),
    MyWidget()
  ];

  Text getTabTitle(int curIndex) {
    if (curIndex == _selectedIndex) {
      return new Text(bottomBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: Colors.lightBlue));
    } else {
      return new Text(bottomBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }

  Widget getTabIcon(int curIndex) {
    if (curIndex == _selectedIndex) {
      return Icon(bottomBarIcons[curIndex], color: Color(0xff1296db));
    } else {
      return Icon(bottomBarIcons[curIndex], color: Color(0xff515151));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        bottomNavigationBar:
//        BottomAppBar(
//          color: Colors.white,
//          shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
//          child:
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            mainAxisSize: MainAxisSize.max,
//            children: [
//              getTabIcon(0),
//              getTabIcon(1),
//              SizedBox(), //中间位置空出
//              getTabIcon(2),
//              getTabIcon(3),
//            ],
//          ),
//        ),
            BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed, // 设置显示模式
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
            BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
            BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
            BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3))
          ],
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
//        floatingActionButton: FloatingActionButton(
//            onPressed: () => Navigator.pushNamed(context, RouterName.make_plan),
//            child: Icon(
//              Icons.add,
//              color: Colors.white,
//            )),
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
