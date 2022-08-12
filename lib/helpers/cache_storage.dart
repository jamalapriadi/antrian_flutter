import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static getCache({@required dynamic key}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    final data = prefs.getString('$key');

    return data;
  }

  static Future<bool> setCache(
      {@required dynamic key, @required dynamic data}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences pref = await _prefs;
    return await pref.setString('$key', data.toString());
  }

  static Future<bool> removeCache({@required dynamic key}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return await prefs.setString('$key', '');
  }
}
