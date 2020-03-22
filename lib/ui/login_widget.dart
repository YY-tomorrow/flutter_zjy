import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zjy/common/application.dart';
import 'package:flutter_zjy/common/common.dart';
import 'package:flutter_zjy/data/api/api_services.dart';
import 'package:flutter_zjy/data/model/token_model.dart';
import 'package:flutter_zjy/data/model/empty_response_model.dart';
import 'package:flutter_zjy/event/login_event.dart';
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

  bool _passwordLogin = false;

  bool isButtonEnable = true; //按钮状态  是否可点击
  String buttonText = '发送验证码'; //初始文本
  int count = 60; //初始倒计时时间
  Timer timer; //倒计时的计时器
  TextEditingController _codeController = TextEditingController();

  void _buttonClickListen() {
    setState(() {
      if (isButtonEnable && _unameController.text != "") {
        apiService.getCode((EmptyResponseModel data) {
          if (data.code == Constants.STATUS_SUCCESS) {
            Fluttertoast.showToast(
                msg: "发送成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                // 消息框弹出的位置
                timeInSecForIos: 1,
                // 消息框持续的时间（目前的版本只有ios有效）
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 13.0);
            //当按钮可点击时
            isButtonEnable = false; //按钮状态标记
            _initTimer();
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
        }, _unameController.text);

        return null; //返回null按钮禁止点击
      } else {
        //当按钮不可点击时
//        debugPrint('false');
        return null; //返回null按钮禁止点击
      }
    });
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isButtonEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '重新发送($count)'; //更新文本内容
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    _codeController?.dispose();
    super.dispose();
  }

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
    var password = "";
    var code = "";
    if (_passwordLogin) {
      password = _pwdController.text;
    } else {
      code = _codeController.text;
    }
    apiService.login((TokenModel data) {
      if (data.code == Constants.STATUS_SUCCESS) {
        SPUtil.putBool(Constants.LOGIN_KEY, true);
        SPUtil.putString(Constants.TOKEN_KEY, data.data.token);
        Application.eventBus.fire(new LoginEvent());
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
    }, phone, password: password, code: code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("登录")),
        body: Container(
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
                        hintText: "请输入手机号",
                        prefixIcon: Icon(Icons.person),
                      ),
                      // 校验用户名（不能为空）
                      validator: (v) {
                        return v.trim().isNotEmpty ? null : "请输入手机号";
                      }),
                  Stack(
                    children: <Widget>[
                      Offstage(
                        offstage: !_passwordLogin,
                        child: TextFormField(
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
                      ),
                      Offstage(
                        offstage: _passwordLogin,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: <Widget>[
                              Text(
                                '验证码',
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xff333333)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: TextFormField(
                                    maxLines: 1,
                                    onSaved: (value) {},
                                    controller: _codeController,
                                    textAlign: TextAlign.left,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(6)
                                    ],
                                    decoration: InputDecoration(
                                      hintText: ('填写验证码'),
                                      contentPadding:
                                          EdgeInsets.only(top: -5, bottom: 0),
                                      hintStyle: TextStyle(
                                        color: Color(0xff999999),
                                        fontSize: 13,
                                      ),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                child: FlatButton(
                                  disabledColor: Colors.grey.withOpacity(0.1),
                                  //按钮禁用时的颜色
                                  disabledTextColor: Colors.white,
                                  //按钮禁用时的文本颜色
                                  textColor: isButtonEnable
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.2),
                                  //文本颜色
                                  color: isButtonEnable
                                      ? Color(0xff44c5fe)
                                      : Colors.grey.withOpacity(0.1),
                                  //按钮的颜色
                                  splashColor: isButtonEnable
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.transparent,
                                  shape: StadiumBorder(side: BorderSide.none),
                                  onPressed: () => _buttonClickListen(),

//                        child: Text('重新发送 (${secondSy})'),
                                  child: Text(
                                    '$buttonText',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          _passwordLogin = !_passwordLogin;
                          setState(() {});
                        },
                        child: Text(_passwordLogin ? "使用验证码登录" : "使用密码登录",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.red)),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
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
