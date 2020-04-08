import 'package:flutter_zjy/data/model/our_plans_model.dart';

ourPlansModelFromJson(OurPlansModel data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['data'] != null) {
		data.data = new OurPlansData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> ourPlansModelToJson(OurPlansModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

ourPlansDataFromJson(OurPlansData data, Map<String, dynamic> json) {
	if (json['plans'] != null) {
		data.plans = new List<OurPlansDataPlan>();
		(json['plans'] as List).forEach((v) {
			data.plans.add(new OurPlansDataPlan().fromJson(v));
		});
	}
	if (json['count'] != null) {
		data.count = json['count']?.toInt();
	}
	return data;
}

Map<String, dynamic> ourPlansDataToJson(OurPlansData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.plans != null) {
		data['plans'] =  entity.plans.map((v) => v.toJson()).toList();
	}
	data['count'] = entity.count;
	return data;
}

ourPlansDataPlanFromJson(OurPlansDataPlan data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toInt();
	}
	if (json['user_name'] != null) {
		data.userName = json['user_name']?.toString();
	}
	if (json['user_img'] != null) {
		data.userImg = json['user_img']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['content'] != null) {
		data.content = json['content']?.toString();
	}
	if (json['items'] != null) {
		data.items = new List<OurPlansDataPlansItem>();
		(json['items'] as List).forEach((v) {
			data.items.add(new OurPlansDataPlansItem().fromJson(v));
		});
	}
	if (json['view'] != null) {
		data.view = json['view']?.toInt();
	}
	if (json['tag'] != null) {
		data.tag = json['tag']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toInt();
	}
	if (json['time'] != null) {
		data.time = json['time']?.toInt();
	}
	return data;
}

Map<String, dynamic> ourPlansDataPlanToJson(OurPlansDataPlan entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['user_id'] = entity.userId;
	data['user_name'] = entity.userName;
	data['user_img'] = entity.userImg;
	data['title'] = entity.title;
	data['content'] = entity.content;
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	data['view'] = entity.view;
	data['tag'] = entity.tag;
	data['type'] = entity.type;
	data['price'] = entity.price;
	data['time'] = entity.time;
	return data;
}

ourPlansDataPlansItemFromJson(OurPlansDataPlansItem data, Map<String, dynamic> json) {
	if (json['sku_id'] != null) {
		data.skuId = json['sku_id']?.toInt();
	}
	if (json['sku_name'] != null) {
		data.skuName = json['sku_name']?.toString();
	}
	if (json['sku_img'] != null) {
		data.skuImg = json['sku_img']?.toString();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toInt();
	}
	return data;
}

Map<String, dynamic> ourPlansDataPlansItemToJson(OurPlansDataPlansItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sku_id'] = entity.skuId;
	data['sku_name'] = entity.skuName;
	data['sku_img'] = entity.skuImg;
	data['price'] = entity.price;
	return data;
}