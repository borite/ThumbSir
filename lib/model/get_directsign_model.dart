// To parse this JSON data, do
//
//     final getSignResult = getSignResultFromJson(jsonString);

import 'dart:convert';

GetSignResult getSignResultFromJson(String str) => GetSignResult.fromJson(json.decode(str));

String getSignResultToJson(GetSignResult data) => json.encode(data.toJson());

class GetSignResult {
  GetSignResult({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory GetSignResult.fromJson(Map<String, dynamic> json) => GetSignResult(
    code: json["Code"] == null ? null : json["Code"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Message": message == null ? null : message,
    "Data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.accessId,
    this.policy,
    this.signature,
    this.dir,
    this.endPoint,
    this.expire,
    this.ossHost,
    this.finalUrl,
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
    accessId: json["AccessID"] == null ? null : json["AccessID"],
    policy: json["Policy"] == null ? null : json["Policy"],
    signature: json["Signature"] == null ? null : json["Signature"],
    dir: json["Dir"] == null ? null : json["Dir"],
    endPoint: json["EndPoint"] == null ? null : json["EndPoint"],
    expire: json["Expire"] == null ? null : json["Expire"],
    ossHost: json["OSSHost"] == null ? null : json["OSSHost"],
    finalUrl: json["FinalUrl"] == null ? null : json["FinalUrl"],
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
