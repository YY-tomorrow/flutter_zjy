import 'package:flutter_zjy/data/model/spider_plans_model.dart';

spiderPlansModelFromJson(SpiderPlansModel data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['data'] != null) {
		data.data = new SpiderPlansData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> spiderPlansModelToJson(SpiderPlansModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

spiderPlansDataFromJson(SpiderPlansData data, Map<String, dynamic> json) {
	if (json['plans'] != null) {
		data.plans = new List<SpiderPlansDataPlan>();
		(json['plans'] as List).forEach((v) {
			data.plans.add(new SpiderPlansDataPlan().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> spiderPlansDataToJson(SpiderPlansData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.plans != null) {
		data['plans'] =  entity.plans.map((v) => v.toJson()).toList();
	}
	return data;
}

spiderPlansDataPlanFromJson(SpiderPlansDataPlan data, Map<String, dynamic> json) {
	if (json['user_name'] != null) {
		data.userName = json['user_name']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['time'] != null) {
		data.time = json['time']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toString();
	}
	if (json['elements'] != null) {
		data.elements = new List<SpiderPlansDataPlansElemants>();
		(json['elements'] as List).forEach((v) {
			data.elements.add(new SpiderPlansDataPlansElemants().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> spiderPlansDataPlanToJson(SpiderPlansDataPlan entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['user_name'] = entity.userName;
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['time'] = entity.time;
	data['type'] = entity.type;
	data['price'] = entity.price;
	if (entity.elements != null) {
		data['elements'] =  entity.elements.map((v) => v.toJson()).toList();
	}
	return data;
}

spiderPlansDataPlansElemantsFromJson(SpiderPlansDataPlansElemants data, Map<String, dynamic> json) {
	if (json['image'] != null) {
		data.image = json['image']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	return data;
}

Map<String, dynamic> spiderPlansDataPlansElemantsToJson(SpiderPlansDataPlansElemants entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['image'] = entity.image;
	data['name'] = entity.name;
	return data;
}