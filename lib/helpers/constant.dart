import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Warna {
  static Color hijau = HexColor("#133a1e");
  static Color merah = HexColor("#c13333");
  static Color kuning = HexColor("#FBC833");
  static Color putih = HexColor("#FFFFFF");
  static Color hitam = HexColor("#1b2535");
  static Color abumuda = HexColor("#dfe1e3");
  static Color abutua = HexColor("#585f6a");
}
