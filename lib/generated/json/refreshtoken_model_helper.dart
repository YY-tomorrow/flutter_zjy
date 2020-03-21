import 'package:flutter_zjy/data/model/refreshtoken_model.dart';

refreshtokenModelFromJson(RefreshtokenModel data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	return data;
}

Map<String, dynamic> refreshtokenModelToJson(RefreshtokenModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['token'] = entity.token;
	return data;
}