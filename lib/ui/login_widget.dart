import 'package:flutter/material.dart';
import 'package:flutter_zjy/common/application.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/data/model/token_model.dart';
import 'package:flutter_zjy/event/refresh_user_event.dart';
import 'package:flutter_zjy/utils/sp_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginWidgetState();
  }
}

class LoginWidgetState extends State<LoginWidget> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = "";
    if (_unameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  Future _onLogin() async {
    var phone = _unameController.text;
    var password = _pwdController.text;
    apiService.login((TokenModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        SPUtil.putBool(Constants.LOGIN_KEY, true);
        SPUtil.putString(Constants.TOKEN_KEY, data.data.token);
        Application.eventBus.fire(new RefreshUserEvent());
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: data.msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            // 消息框弹出的位置
            timeInSecForIos: 1,
            // 消息框持续的时间（目前的版本只有ios有效）
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 13.0);
      }
    }, phone, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("登录")),
        body: Container(
          constraints: BoxConstraints.tightFor(height: 300.0),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  TextFormField(
                      autofocus: _nameAutoFocus,
                      controller: _unameController,
                      decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "请输入用户名",
                        prefixIcon: Icon(Icons.person),
                      ),
                      // 校验用户名（不能为空）
                      validator: (v) {
                        return v.trim().isNotEmpty ? null : "请输入用户名";
                      }),
                  TextFormField(
                    controller: _pwdController,
                    autofocus: !_nameAutoFocus,
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "请输入密码",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(pwdShow
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              pwdShow = !pwdShow;
                            });
                          },
                        )),
                    obscureText: !pwdShow,
                    //校验密码（不能为空）
                    validator: (v) {
                      return v.trim().isNotEmpty ? null : "请输入密码";
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(height: 45.0),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () => _onLogin(),
                        textColor: Colors.white,
                        child: Text("登录"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
