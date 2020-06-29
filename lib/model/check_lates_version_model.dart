// To parse this JSON data, do
//
//     final checkLatestVersion = checkLatestVersionFromJson(jsonString);

import 'dart:convert';

CheckLatestVersion checkLatestVersionFromJson(String str) => CheckLatestVersion.fromJson(json.decode(str));

String checkLatestVersionToJson(CheckLatestVersion data) => json.encode(data.toJson());

class CheckLatestVersion {
  CheckLatestVersion({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory CheckLatestVersion.fromJson(Map<String, dynamic> json) => CheckLatestVersion(
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
    this.id,
    this.version,
    this.versionDes,
    this.link,
  });

  int id;
  String version;
  String versionDes;
  dynamic link;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"] == null ? null : json["ID"],
    version: json["Version"] == null ? null : json["Version"],
    versionDes: json["VersionDes"] == null ? null : json["VersionDes"],
    link: json["Link"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "Version": version == null ? null : version,
    "VersionDes": versionDes == null ? null : versionDes,
    "Link": link,
  };
}