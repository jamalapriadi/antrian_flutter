import 'dart:convert';

class BuatAntrianResponse {
  bool? success;
  String? message;
  String? noantrian;
  String? keperluan;

  BuatAntrianResponse(
      {this.success, this.message, this.noantrian, this.keperluan});

  factory BuatAntrianResponse.fromJson(Map<String, dynamic> json) =>
      BuatAntrianResponse(
          success: json["success"],
          message: json["message"],
          noantrian: json["data"]["no_antrian"],
          keperluan: json["data"]["keperluan"]["nama"]);
}

BuatAntrianResponse buatAntrianResponseFromJson(String str) =>
    BuatAntrianResponse.fromJson(json.decode(str));
