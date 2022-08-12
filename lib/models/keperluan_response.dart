import 'dart:convert';

class KeperluanResponse {
  String? id;
  String? nama;

  KeperluanResponse({this.id, this.nama});

  factory KeperluanResponse.fromJson(Map<String, dynamic> json) =>
      KeperluanResponse(id: json["id"], nama: json["nama"]);
}

List<KeperluanResponse> keperluanResponseFromJson(String jsonData) {
  final data = json.decode(jsonData);

  return List<KeperluanResponse>.from(
      data["data"].map((item) => KeperluanResponse.fromJson(item)));
}
