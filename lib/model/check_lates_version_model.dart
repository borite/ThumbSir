// To parse this JSON data, do
//
//     final checkLatestVersion = checkLatestVersionFromJson(jsonString);

import 'dart:convert';

CheckLatestVersion checkLatestVersionFromJson(String str) => CheckLatestVersion.fromJson(json.decode(str));

String checkLatestVersionToJson(CheckLatestVersion data) => json.encode(data.toJson());

class CheckLatestVersion {
  CheckLatestVersion({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory CheckLatestVersion.fromJson(Map<String, dynamic> json) => CheckLatestVersion(
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
    required this.id,
    required this.version,
    required this.versionDes,
    this.link,
  });

  int id;
  String version;
  String versionDes;
  dynamic link;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    version: json["Version"],
    versionDes: json["VersionDes"],
    link: json["Link"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Version": version,
    "VersionDes": versionDes,
    "Link": link,
  };
}