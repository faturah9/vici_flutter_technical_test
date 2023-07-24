// import 'package:shared_preferences/shared_preferences.dart';
//
// class SessionManager {
//   final String auth_token = "auth_token";
//   final String auth_login = "auth_login";
//   final String show_intro = "show_intro";
//
// //set data into shared preferences like this
//   Future<void> setAuthToken(String authToken) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString(auth_token, authToken);
//   }
//
// //get value from shared preferences
//   Future<String?> getAuthToken() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     String? authToken;
//     authToken = pref.getString(auth_token);
//     return authToken;
//   }
//
//   Future<void> setAuthLogin(bool isLogin) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool(auth_login, isLogin);
//   }
//
//   Future<void> setAuthIntro(bool showIntro) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool(show_intro, showIntro);
//   }
//
//   Future<bool?> getAuthLogin() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     bool? isLogin;
//     isLogin = pref.getBool(auth_login);
//     return isLogin;
//   }
// }

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../features/register/domain/datas/models/user_model.dart';
import '../injection_container.dart';

abstract class AppSharedPreferences {
  String? getUserId();

  Future<bool> setUserId(final String userId);

  UserModel? getUser(final String userId);

  Future<bool> setUser(final String userId, UserModel user);
}

class AppSharedPreferencesImpl implements AppSharedPreferences {
  final SharedPreferences _prefs = sl<SharedPreferences>();

  AppSharedPreferencesImpl();

  @override
  String? getUserId() {
    return _prefs.getString('user_id') ?? _prefs.getString('userid');
  }

  @override
  Future<bool> setUserId(final String userId) {
    return _prefs.setString('user_id', userId);
  }

  @override
  UserModel? getUser(final String userId) {
    final string = _prefs.getString(userId);
    if (string == null) throw CacheException('Data User kosong');
    final map = jsonDecode(string);
    return UserModel.fromJson(map);
  }

  @override
  Future<bool> setUser(final String userId, UserModel user) {
    final map = user.toJson();
    final string = jsonEncode(map);
    return _prefs.setString(userId, string);
  }
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = '']);

  @override
  String toString() {
    return message;
  }
}
