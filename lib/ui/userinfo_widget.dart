import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/application.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/model/userinfo_model.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/event/refresh_user_event.dart';
import 'package:flutter_zjy/utils/sp_util.dart';

class UserInfoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserInfoWidgetState();
  }
}

class UserInfoWidgetState extends State<UserInfoWidget> {
  var _userName = "";
  var _userID = "";
  var _userImg = "";
  var _userPhone = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  Future _getUserInfo() async {
    apiService.getUserInfo((UserinfoModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        SPUtil.putString(Constants.USERNAME_KEY, data.data.userName);
        SPUtil.putInt(Constants.ID_KEY, data.data.id);
        SPUtil.putString(Constants.USER_IMAGE_KEY, data.data.image);
        _userName = SPUtil.getString(Constants.USERNAME_KEY, defValue: "请登录");
        _userID = SPUtil.getInt(Constants.ID_KEY).toString();
        _userImg = data.data.image;
        _userPhone = data.data.phone;
        Application.eventBus.fire(new RefreshUserEvent());
      }
      setState(() {});
    });
  }

  Widget userInfoLayout(int index, String name, content) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
        height: 35.0,
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Text(name),
            Spacer(
              flex: 1,
            ),
            Text(content),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(AppBarName.user_info)),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                    height: 50.0,
                    alignment: Alignment.centerLeft,
                    color: Colors.transparent,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Text("头像"),
                        Spacer(
                          flex: 1,
                        ),
                        Image(
                          image: NetworkImage(_userImg),
                          height: 40.0,
                          width: 40.0,
                        ),
                      ],
                    ),
                  ),
                );
              case 1:
                return userInfoLayout(index, "用户名", _userName);
              case 2:
                return userInfoLayout(index, "ID", _userID);
              case 3:
                return userInfoLayout(index, "电话", _userPhone);
            }
            return ListTile(
              title: Text("$index"),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.blue);
          },
          itemCount: 4),
    );
  }
}
