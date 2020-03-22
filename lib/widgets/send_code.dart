import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendCodeWidget extends StatefulWidget {
  TextEditingController mController;
  bool isStartTimer = false;
  Function callBack;

  SendCodeWidget(
      this.mController,
      this.callBack(
    String phone,
  ));

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SendCodeWidgetState();
  }
}

class SendCodeWidgetState extends State<SendCodeWidget> {
  bool isButtonEnable = true; //按钮状态  是否可点击
  String buttonText = '发送验证码'; //初始文本
  int count = 60; //初始倒计时时间
  Timer timer; //倒计时的计时器
  TextEditingController _codeController;

  void _buttonClickListen() {
    setState(() {
      if (isButtonEnable) {
        //当按钮可点击时
        isButtonEnable = false; //按钮状态标记
        _initTimer();

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
  Widget build(BuildContext context) {
    // TODO: implement build

    _codeController = widget.mController;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: <Widget>[
          Text(
            '验证码',
            style: TextStyle(fontSize: 13, color: Color(0xff333333)),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
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
                  contentPadding: EdgeInsets.only(top: -5, bottom: 0),
                  hintStyle: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 13,
                  ),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
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
              textColor:
                  isButtonEnable ? Colors.white : Colors.black.withOpacity(0.2),
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
    );
  }
}
