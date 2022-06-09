// To parse this JSON data, do
//
//     final getProductDetail = getProductDetailFromJson(jsonString);

import 'dart:convert';

GetProductDetail getProductDetailFromJson(String str) => GetProductDetail.fromJson(json.decode(str));

String getProductDetailToJson(GetProductDetail data) => json.encode(data.toJson());

class GetProductDetail {
  GetProductDetail({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetProductDetail.fromJson(Map<String, dynamic> json) => GetProductDetail(
    code: json["Code"],
    message: json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Message": message,
    "Data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.productId,
    required this.productName,
    required this.productIntro,
    required this.productPrice,
    this.productReamrk,
    required this.productState,
  });

  int productId;
  String productName;
  String productIntro;
  double productPrice;
  dynamic productReamrk;
  int productState;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productId: json["ProductID"],
    productName: json["ProductName"],
    productIntro: json["ProductIntro"],
    productPrice: json["ProductPrice"],
    productReamrk: json["ProductReamrk"],
    productState: json["ProductState"]
  );

  Map<String, dynamic> toJson() => {
    "ProductID": productId,
    "ProductName": productName,
    "ProductIntro": productIntro,
    "ProductPrice": productPrice,
    "ProductReamrk": productReamrk,
    "ProductState": productState,
  };
}