import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../model/login_response.dart';
import '../model/previousDraw/previous_draw_response.dart';
import '../model/user_model.dart';
import '../notifier/login_notifier.dart';

//API Service Provider
final apiProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  String baseUrl = 'https://reqres.in/api/users';

  Future<List<UserModel>> getUsers() async {
    Response response = await get(Uri.parse(baseUrl));
    debugPrint("getUsers response: ${jsonDecode(response.body).toString()}");

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<UserModel> getUserDetail(int id) async {
    // var body = {"id": id};
    // Response response = await post(Uri.parse(baseUrl), body: jsonEncode(body));
    Response response = await get(Uri.parse('$baseUrl?id=$id'));
    debugPrint(
        "getUserDetail response: ${jsonDecode(response.body).toString()}");

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)['data'];
      return UserModel.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  /*Future<AsyncValue<LoginResponse>> login(
      LoginRequestModel requestModel) async {
    String url = "https://reqres.in/api/login";

    final response = await post(Uri.parse(url), body: requestModel.toJson());
    debugPrint("login response: ${jsonDecode(response.body).toString()}");

    if (response.statusCode == 200) {
      return AsyncData(LoginResponse.fromJson(jsonDecode(response.body)));
    } else {
      // throw Exception('Failed to load data!');
      return AsyncError('Failed to load data!', StackTrace.current);
    }
  }*/

  Future<LoginData> login(LoginRequestModel requestModel) async {
    String url = "https://reqres.in/api/login";

    final response = await post(Uri.parse(url), body: requestModel.toJson());
    debugPrint("login response: ${jsonDecode(response.body).toString()}");

    if (response.statusCode == 200) {
      return LoginData(LoginStatus.success,
          LoginResponse.fromJson(jsonDecode(response.body)));
    } else {
      // throw Exception('Failed to load data!');
      return LoginData(LoginStatus.failed, LoginResponse());
    }
  }

  Future<String> getNextDraw() async {
    String url = "https://cicwatch.com/api/v1/draws/next-draw";

    debugPrint("getNextDraw request");

    final response = await get(Uri.parse(url));
    debugPrint("getNextDraw response: ${jsonDecode(response.body).toString()}");

    String date = jsonDecode(response.body)["next-draw-date"];
    debugPrint('time: $date');

    if (response.statusCode == 200) {
      return date;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<String>> getDrawList() async {
    String url = "https://cicwatch.com/api/v1/draws/list";

    final response = await get(Uri.parse(url));
    debugPrint("getDrawList response: ${response.body}");

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>).cast<String>();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  /*Future<AsyncValue<DropDownData>> getDrawListNew() async {
    String url = "https://cicwatch.com/api/v1/draws/list";

    final response = await get(Uri.parse(url));
    debugPrint("getDrawList response: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint(
          "getDrawList resData: ${(jsonDecode(response.body) as List<dynamic>).cast<String>()}");
      return AsyncData(DropDownData.fromJson(null, jsonDecode(response.body)));
    } else {
      // throw Exception('Failed to load data!');
      return AsyncError('Failed to load data!', StackTrace.current);
    }
  }*/

  Future<PreviousDrawResponse> getDrawItemList(String? newValue) async {
    String url =
        "https://cicwatch.com/api/v1/draws?filter[immigration_program]=$newValue";

    debugPrint('requestURL: $url');

    final response = await get(Uri.parse(url));

    PreviousDrawResponse previousDrawResponse =
        PreviousDrawResponse.fromJson(jsonDecode(response.body));

    if (response.statusCode == 200) {
      debugPrint("getDrawItemListNew response: ${jsonDecode(response.body)}");
      return previousDrawResponse;
    } else {
      debugPrint("getDrawItemListNew Error");
      throw Exception('Failed to load data!');
      // return AsyncError('Failed to load data!', StackTrace.current);
    }
  }
}
