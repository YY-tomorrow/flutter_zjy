import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/model/userinfo_model.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
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
        _userName = SPUtil.getString(Constants.USERNAME_KEY, defValue: "请登录");
        _userID = SPUtil.getInt(Constants.ID_KEY).toString();
        _userImg = data.data.image;
        _userPhone = data.data.phone;
      }
      setState(() {});
    });
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
                return Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text("用户名"),
                    Spacer(
                      flex: 1,
                    ),
                    Text(_userName),
                  ],
                );
              case 1:
                return Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text("ID"),
                    Spacer(
                      flex: 1,
                    ),
                    Text(_userID),
                  ],
                );
              case 2:
                return Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text("电话"),
                    Spacer(
                      flex: 1,
                    ),
                    Text(_userPhone),
                  ],
                );
            }
            return ListTile(
              title: Text("$index"),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.blue);
          },
          itemCount: 3),
    );
  }
}
