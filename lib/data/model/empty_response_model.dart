import 'package:flutter_zjy/generated/json/base/json_convert_content.dart';

class EmptyResponseModel with JsonConvert<EmptyResponseModel> {
	int code;
	String msg;
	dynamic data;
}
