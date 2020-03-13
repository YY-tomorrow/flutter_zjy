import 'package:flutter_zjy/generated/json/base/json_convert_content.dart';
import 'package:flutter_zjy/generated/json/base/json_filed.dart';

class SpiderPlansModel with JsonConvert<SpiderPlansModel> {
	int code;
	String msg;
	SpiderPlansData data;
}

class SpiderPlansData with JsonConvert<SpiderPlansData> {
	List<SpiderPlansDataPlan> plans;
}

class SpiderPlansDataPlan with JsonConvert<SpiderPlansDataPlan> {
	@JSONField(name: "user_name")
	String userName;
	String id;
	String title;
	String time;
	String type;
	String price;
	List<SpiderPlansDataPlansElemants> elements;
}

class SpiderPlansDataPlansElemants with JsonConvert<SpiderPlansDataPlansElemants> {
	String image;
	String name;
}
