import 'package:flutter_zjy/data/model/products_model.dart';

productsModelFromJson(ProductsModel data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['data'] != null) {
		data.data = new List<ProductsData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new ProductsData().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> productsModelToJson(ProductsModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	return data;
}

productsDataFromJson(ProductsData data, Map<String, dynamic> json) {
	if (json['SkuID'] != null) {
		data.skuID = json['SkuID']?.toInt();
	}
	if (json['InOrderCount30Days'] != null) {
		data.inOrderCount30Days = json['InOrderCount30Days']?.toInt();
	}
	if (json['IsZY'] != null) {
		data.isZY = json['IsZY']?.toInt();
	}
	if (json['SkuName'] != null) {
		data.skuName = json['SkuName']?.toString();
	}
	if (json['MaterialURL'] != null) {
		data.materialURL = json['MaterialURL']?.toString();
	}
	if (json['ShopName'] != null) {
		data.shopName = json['ShopName']?.toString();
	}
	if (json['ShopID'] != null) {
		data.shopID = json['ShopID']?.toInt();
	}
	if (json['Price'] != null) {
		data.price = json['Price']?.toInt();
	}
	return data;
}

Map<String, dynamic> productsDataToJson(ProductsData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['SkuID'] = entity.skuID;
	data['InOrderCount30Days'] = entity.inOrderCount30Days;
	data['IsZY'] = entity.isZY;
	data['SkuName'] = entity.skuName;
	data['MaterialURL'] = entity.materialURL;
	data['ShopName'] = entity.shopName;
	data['ShopID'] = entity.shopID;
	data['Price'] = entity.price;
	return data;
}