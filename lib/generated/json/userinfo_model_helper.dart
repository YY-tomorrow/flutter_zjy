import 'package:flutter_zjy/data/model/userinfo_model.dart';

userinfoModelFromJson(UserinfoModel data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['data'] != null) {
		data.data = new UserinfoData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> userinfoModelToJson(UserinfoModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

userinfoDataFromJson(UserinfoData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['UserName'] != null) {
		data.userName = json['UserName']?.toString();
	}
	if (json['Phone'] != null) {
		data.phone = json['Phone']?.toString();
	}
	if (json['Image'] != null) {
		data.image = json['Image']?.toString();
	}
	return data;
}

Map<String, dynamic> userinfoDataToJson(UserinfoData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['UserName'] = entity.userName;
	data['Phone'] = entity.phone;
	data['Image'] = entity.image;
	return data;
}