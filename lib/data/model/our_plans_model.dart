import 'package:flutter_zjy/generated/json/base/json_convert_content.dart';
import 'package:flutter_zjy/generated/json/base/json_filed.dart';

class OurPlansModel with JsonConvert<OurPlansModel> {
	int code;
	String msg;
	OurPlansData data;
}

class OurPlansData with JsonConvert<OurPlansData> {
	List<OurPlansDataPlan> plans;
	int count;
}

class OurPlansDataPlan with JsonConvert<OurPlansDataPlan> {
	String id;
	@JSONField(name: "user_id")
	int userId;
	@JSONField(name: "user_name")
	String userName;
	@JSONField(name: "user_img")
	String userImg;
	String title;
	String content;
	List<OurPlansDataPlansItem> items;
	int view;
	String tag;
	String type;
	int price;
	int time;
}

class OurPlansDataPlansItem with JsonConvert<OurPlansDataPlansItem> {
	@JSONField(name: "sku_id")
	int skuId;
	@JSONField(name: "sku_name")
	String skuName;
	@JSONField(name: "sku_img")
	String skuImg;
	int price;
}
