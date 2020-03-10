import 'package:flutter_zjy/generated/json/base/json_convert_content.dart';

class NewsModel with JsonConvert<NewsModel> {
	int code;
	String msg;
	NewsData data;
}

class NewsData with JsonConvert<NewsData> {
	List<NewsDataData> data;
	int count;
	String cursor;
}

class NewsDataData with JsonConvert<NewsDataData> {
	String id;
	bool havePic;
	String pubDate;
	String title;
	String img;
	String html;



}
