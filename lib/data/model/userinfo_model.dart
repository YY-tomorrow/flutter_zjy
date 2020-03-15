import 'package:flutter_zjy/generated/json/base/json_convert_content.dart';
import 'package:flutter_zjy/generated/json/base/json_filed.dart';

class UserinfoModel with JsonConvert<UserinfoModel> {
	int code;
	String msg;
	UserinfoData data;
}

class UserinfoData with JsonConvert<UserinfoData> {
	int id;
	@JSONField(name: "UserName")
	String userName;
	@JSONField(name: "Phone")
	String phone;
	@JSONField(name: "Image")
	String image;
}
