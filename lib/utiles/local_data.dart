import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  SharedPreferences? prefs;

  String todoData = "todoData";

  setObject(String key, dynamic val) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(key, val);
  }

  Future getObject(String key) async {
    prefs = await SharedPreferences.getInstance();
    var data = prefs!.getString(key)!;
    return jsonDecode(data);
  }

  setString(String key, String val) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setString(key, val);
  }

  Future<String> getString(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(key)!;
  }

  setDouble(String key, double val) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setDouble(key, val);
  }

  Future<double> getDouble(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getDouble(key)!;
  }

  setBool(String key, bool val) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setBool(key, val);
  }

  Future<bool> getBool(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(key)!;
  }

  setStringList(String key, List<String> val) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setStringList(key, val);
  }

  Future<List<String>> getStringList(String key) async {
    prefs = await SharedPreferences.getInstance();

    return prefs!.getStringList(key)!;
  }

  Future<bool> containData(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.containsKey(key);
  }

  removeData(String key) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.remove(key);
  }
}
