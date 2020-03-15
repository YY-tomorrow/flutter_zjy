import 'package:flutter_zjy/generated/json/base/json_convert_content.dart';

class TokenModel with JsonConvert<TokenModel> {
	int code;
	String msg;
	TokenData data;
}

class TokenData with JsonConvert<TokenData> {
	String token;
}
