import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{

  static saveString(String key,String? value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value!);
  }
  static saveInt(String key,int value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }
  static saveBool(String key,bool? value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value!);
  }

  static Future<String?> getValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getString(key);
      return value;
    } catch (error) {
      return null;
    }
  }
  static Future<int?> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getInt(key);
      return value;
    } catch (error) {
      return null;
    }
  }
  static Future<bool?> isPresent(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getBool(key);
      return value;
    } catch (error) {
      return null;
    }
  }

  static deleteKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}