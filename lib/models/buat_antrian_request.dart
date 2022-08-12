class BuatAntrianRequest {
  String? type;
  String? keperluan;

  BuatAntrianRequest({this.type, this.keperluan});

  Map<String, dynamic> toJson() => {"type": type, "keperluan": keperluan};
}
