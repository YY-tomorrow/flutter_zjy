import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zjy/common/application.dart';
import 'package:flutter_zjy/common/router.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/event/login_event.dart';
import 'package:flutter_zjy/event/refresh_user_event.dart';
import 'package:flutter_zjy/utils/sp_util.dart';
import 'package:flutter_zjy/data/model/userinfo_model.dart';

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyWidgetState();
  }
}

class MyWidgetState extends State<MyWidget> {
  var _userName = "请登录";
  var _userID = "";
  var _userImg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerLoginEvent();
    registerRefreshEvent();
    if (SPUtil.getBool(Constants.LOGIN_KEY)) {
      _userName = SPUtil.getString(Constants.USERNAME_KEY, defValue: "请登录");
      if (SPUtil.getInt(Constants.ID_KEY) > 0) {
        _userID = SPUtil.getInt(Constants.ID_KEY).toString();
      }
      _userImg = SPUtil.getString(Constants.USER_IMAGE_KEY,
          defValue: "https://www.zujiying.top/demo.jpg");
    }
  }

  Future _userInfo() async {
    if (SPUtil.getBool(Constants.LOGIN_KEY)) {
      Navigator.pushNamed(context, RouterName.user_info);
    } else {
      Navigator.pushNamed(context, RouterName.login);
    }
  }

  Future _getUserInfo() async {
    apiService.getUserInfo((UserinfoModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        SPUtil.putString(Constants.USERNAME_KEY, data.data.userName);
        SPUtil.putInt(Constants.ID_KEY, data.data.id);
        _userName = SPUtil.getString(Constants.USERNAME_KEY, defValue: "请登录");
        if (SPUtil.getInt(Constants.ID_KEY) > 0) {
          _userID = SPUtil.getInt(Constants.ID_KEY).toString();
        }
        _userImg = data.data.image;
      }
    });
  }

  void registerLoginEvent() {
    Application.eventBus.on<LoginEvent>().listen((event) {
      _getUserInfo();
      setState(() {});
    });
  }

  void registerRefreshEvent() {
    Application.eventBus.on<RefreshUserEvent>().listen((event) {
      _userName = SPUtil.getString(Constants.USERNAME_KEY);
      _userID = SPUtil.getInt(Constants.ID_KEY).toString();
      _userImg = SPUtil.getString(Constants.USER_IMAGE_KEY);
      Application.eventBus.fire(new RefreshUserEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
          constraints: BoxConstraints.tightFor(height: 200.0),
          //卡片大小
          decoration: BoxDecoration(
              //背景装饰
              gradient: RadialGradient(
                  //背景径向渐变
                  colors: [Colors.blue, Colors.lightBlue],
                  center: Alignment.topLeft,
                  radius: .9),
              boxShadow: [
                //卡片阴影
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ]),
          alignment: Alignment.center,
          //卡片内文字居中
          child: Container(
            margin: EdgeInsets.all(16.0),
            constraints: BoxConstraints.tightFor(height: 70.0),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                InkWell(
                  onTap: () => _userInfo(),
                  child: ClipOval(
                    child: Image(
                      image: NetworkImage(_userImg),
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Align(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    _userName,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text("id : " + _userID),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.separated(
                  itemCount: 1,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(color: Colors.blue);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouterName.about,
                        );
                      },
                      child: Container(
                        color: Colors.white12,
                        padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                        child: Text(
                          "关于",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 45,
                margin:
                    EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
                child: RaisedButton(
                  onPressed: () {
                    SPUtil.putString(Constants.USERNAME_KEY, "请登录");
                    SPUtil.putInt(Constants.ID_KEY, 0);
                    SPUtil.putString(Constants.USER_IMAGE_KEY,
                        "https://www.zujiying.top/demo.jpg");
                    SPUtil.putBool(Constants.LOGIN_KEY, false);
                    setState(() {});
                  },
                  shape: StadiumBorder(side: BorderSide.none),
                  color: Colors.redAccent,
                  child: Text(
                    '退出登录',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
