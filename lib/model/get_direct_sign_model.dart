// To parse this JSON data, do
//
//     final getSignResult = getSignResultFromJson(jsonString);

import 'dart:convert';

GetSignResult getSignResultFromJson(String str) => GetSignResult.fromJson(json.decode(str));

String getSignResultToJson(GetSignResult data) => json.encode(data.toJson());

class GetSignResult {
  GetSignResult({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory GetSignResult.fromJson(Map<String, dynamic> json) => GetSignResult(
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
    required this.accessId,
    required this.policy,
    required this.signature,
    required this.dir,
    required this.endPoint,
    required this.expire,
    required this.ossHost,
    required this.finalUrl,
  });

  String accessId;
  String policy;
  String signature;
  String dir;
  String endPoint;
  int expire;
  String ossHost;
  String finalUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessId: json["AccessID"],
    policy: json["Policy"],
    signature: json["Signature"],
    dir: json["Dir"],
    endPoint: json["EndPoint"],
    expire: json["Expire"],
    ossHost: json["OSSHost"],
    finalUrl: json["FinalUrl"],
  );

  Map<String, dynamic> toJson() => {
    "AccessID": accessId == null ? null : accessId,
    "Policy": policy == null ? null : policy,
    "Signature": signature == null ? null : signature,
    "Dir": dir == null ? null : dir,
    "EndPoint": endPoint == null ? null : endPoint,
    "Expire": expire == null ? null : expire,
    "OSSHost": ossHost == null ? null : ossHost,
    "FinalUrl": finalUrl == null ? null : finalUrl,
  };
}
