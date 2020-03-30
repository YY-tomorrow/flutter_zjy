import 'package:flutter_zjy/generated/json/base/json_convert_content.dart';
import 'package:flutter_zjy/generated/json/base/json_filed.dart';

class ProductsModel with JsonConvert<ProductsModel> {
	int code;
	String msg;
	List<ProductsData> data;
}

class ProductsData with JsonConvert<ProductsData> {
	@JSONField(name: "SkuID")
	int skuID;
	@JSONField(name: "InOrderCount30Days")
	int inOrderCount30Days;
	@JSONField(name: "IsZY")
	int isZY;
	@JSONField(name: "SkuName")
	String skuName;
	@JSONField(name: "MaterialURL")
	String materialURL;
	@JSONField(name: "ShopName")
	String shopName;
	@JSONField(name: "ShopID")
	int shopID;
	@JSONField(name: "Price")
	int price;
}
