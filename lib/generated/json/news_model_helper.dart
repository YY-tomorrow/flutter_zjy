import 'package:flutter_zjy/data/model/news_model.dart';

newsModelFromJson(NewsModel data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['data'] != null) {
		data.data = new NewsData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> newsModelToJson(NewsModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

newsDataFromJson(NewsData data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<NewsDataData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new NewsDataData().fromJson(v));
		});
	}
	if (json['count'] != null) {
		data.count = json['count']?.toInt();
	}
	if (json['cursor'] != null) {
		data.cursor = json['cursor']?.toString();
	}
	return data;
}

Map<String, dynamic> newsDataToJson(NewsData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['count'] = entity.count;
	data['cursor'] = entity.cursor;
	return data;
}

newsDataDataFromJson(NewsDataData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['havePic'] != null) {
		data.havePic = json['havePic'];
	}
	if (json['pubDate'] != null) {
		data.pubDate = json['pubDate']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['html'] != null) {
		data.html = json['html']?.toString();
	}
	return data;
}

Map<String, dynamic> newsDataDataToJson(NewsDataData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['havePic'] = entity.havePic;
	data['pubDate'] = entity.pubDate;
	data['title'] = entity.title;
	data['img'] = entity.img;
	data['html'] = entity.html;
	return data;
}