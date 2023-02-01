import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  SharedPreferences? prefs;

  String todoData = "todoData";

  setObject({required String key, required dynamic val}) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(key, val);
  }

  Future getObject({required String key}) async {
    prefs = await SharedPreferences.getInstance();
    var data = prefs!.getString(key)!;
    return jsonDecode(data);
  }

  setString({required String key, required String val}) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setString(key, val);
  }

  Future<String> getString({required String key}) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(key)!;
  }

  setDouble({required String key, required double val}) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setDouble(key, val);
  }

  Future<double> getDouble({required String key}) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getDouble(key)!;
  }

  setBool({required String key, required bool val}) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setBool(key, val);
  }

  Future<bool> getBool({required String key}) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(key)!;
  }

  setStringList({required String key, required List<String> val}) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setStringList(key, val);
  }

  Future<List<String>> getStringList({required String key}) async {
    prefs = await SharedPreferences.getInstance();

    return prefs!.getStringList(key)!;
  }

  Future<bool> containData({required String key}) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.containsKey(key);
  }

  removeData({required String key}) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.remove(key);
  }
}
