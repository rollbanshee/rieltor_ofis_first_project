import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:rieltor_ofis/domain/entity/areamarks/metro.dart';
import 'package:rieltor_ofis/domain/entity/areamarks/region.dart';
import 'package:rieltor_ofis/domain/entity/favourites/get_folders.dart';
import 'package:rieltor_ofis/domain/entity/favourites/get_folders_by_announces.dart';
import 'package:rieltor_ofis/domain/entity/favourites/get_wishlist.dart';
import 'package:rieltor_ofis/domain/entity/favourites/single_folder.dart';
import 'package:rieltor_ofis/domain/entity/homeindex/homeindex.dart';
import 'package:rieltor_ofis/domain/entity/search/search.dart';
import 'package:rieltor_ofis/domain/entity/search/searchannounces.dart';
import 'package:rieltor_ofis/domain/entity/subscriptions/save_filter.dart';
import 'package:rieltor_ofis/domain/entity/subscriptions/subscription_announces.dart';
import 'package:rieltor_ofis/domain/entity/subscriptions/subscriptions.dart';

import '../entity/announces_id/announces_id.dart';
import '../entity/areamarks/marks.dart';
import '../entity/cities.dart';

class ApiClient {
  final dio = Dio();

  final client = HttpClient();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Future<List> getCities() async {
    final token = await secureStorage.read(key: "token");
    final url = Uri.parse('https://rieltorofisi.com/api/Area/cities');
    final request = await client.getUrl(url);
    request.headers.add('Authorization', "Bearer $token");
    final response = await request.close();
    var responseData = await response.transform(utf8.decoder).toList();
    var responseStrings = responseData.join();

    final data = jsonDecode(responseStrings) as List<dynamic>;

    return data
        .map((dynamic e) => Cities.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<HomeIndex> getHomeIndex() async {
    final token = await secureStorage.read(key: "token");
    final url = Uri.parse('https://rieltorofisi.com/api/Home/index');
    final request = await client.getUrl(url);
    request.headers.add('Authorization', "Bearer $token");
    final response = await request.close();
    var responseData = await response.transform(utf8.decoder).toList();
    var responseString = responseData.join();
    final Map<String, dynamic> data = jsonDecode(responseString);
    return HomeIndex.fromJson(data);
  }

  Future<List> getRegions() async {
    final token = await secureStorage.read(key: "token");
    final url =
        Uri.parse('https://rieltorofisi.com/api/Area/regions-and-settlements');
    final request = await client.getUrl(url);
    request.headers.add('Authorization', "Bearer $token");
    final response = await request.close();
    var responseData = await response.transform(utf8.decoder).toList();
    var responseStrings = responseData.join();

    final data = jsonDecode(responseStrings) as List<dynamic>;

    return data
        .map((dynamic e) => Region.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List> getMetro() async {
    final token = await secureStorage.read(key: "token");
    final url = Uri.parse('https://rieltorofisi.com/api/Area/metros');
    final request = await client.getUrl(url);
    request.headers.add('Authorization', "Bearer $token");

    final response = await request.close();
    var responseData = await response.transform(utf8.decoder).toList();
    var responseStrings = responseData.join();

    final data = jsonDecode(responseStrings) as List<dynamic>;

    return data
        .map((dynamic e) => Metro.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List> getMarks() async {
    final token = await secureStorage.read(key: "token");
    final url = Uri.parse('https://rieltorofisi.com/api/Area/marks');
    final request = await client.getUrl(url);
    request.headers.add('Authorization', "Bearer $token");
    final response = await request.close();
    var responseData = await response.transform(utf8.decoder).toList();
    var responseStrings = responseData.join();

    final data = jsonDecode(responseStrings) as List<dynamic>;

    return data
        .map((dynamic e) => Marks.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<String> postPhone({required String phone}) async {
    final url = Uri.parse('https://rieltorofisi.com/api/Authenticate/send-sms');

    final parameters = <String, dynamic>{"phone": phone};
    final request = await client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final code = json['code'] as String;
    return code;
  }

  Future<String> postPhoneCode(
      {required String phone, required String code}) async {
    final url = Uri.parse('https://rieltorofisi.com/api/Authenticate/verify');

    final parameters = <String, dynamic>{"phone": phone, "code": code};
    final request = await client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final userId = json['userId'] as String;
    return userId;
  }

  Future<String> postNameID(
      {required String name, required String userId}) async {
    final url = Uri.parse('https://rieltorofisi.com/api/Authenticate/register');

    final parameters = <String, dynamic>{
      "name": name,
      "userId": userId,
      "deviceToken": "string"
    };
    final request = await client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['token'] as String;
    await secureStorage.write(key: "token", value: token);
    return token;
  }

  Future<AnnouncesId> getAnnouncesId(int id) async {
    final token = await secureStorage.read(key: "token");
    final url =
        Uri.parse('https://rieltorofisi.com/api/Announce/announces?id=$id');
    print(token);
    final request = await client.getUrl(url);
    request.headers.contentType = ContentType.json;
    request.headers.add('Authorization', "Bearer $token");
    final response = await request.close();
    var responseData = await response.toBytes();
    var responseString = utf8.decode(responseData);
    final Map<String, dynamic> data = jsonDecode(responseString);
    final List<dynamic> data1 = jsonDecode(data["logoImages"]);
    print(token);
    data["logoImages"] = data1;
    return AnnouncesId.fromJson(data);
  }

  Future<dynamic> getSearchCount() async {
    final token = await secureStorage.read(key: "token");
    final url =
        Uri.parse('https://rieltorofisi.com/api/Announce/count-by-filter')
            .replace(queryParameters: parameters.toJson());

    final request = await client.getUrl(url);

    request.headers.contentType = ContentType.json;
    request.headers.add('Authorization', "Bearer $token");
    final response = await request.close();
    var responseData = await response.transform(utf8.decoder).toList();
    var responseString = responseData.join();
    final int data = jsonDecode(responseString);
    print(data);

    return data;
  }

  Future<dynamic> getSearchAnnounces() async {
    final token = await secureStorage.read(key: "token");
    final url =
        Uri.parse('https://rieltorofisi.com/api/Announce/filtered-announces')
            .replace(queryParameters: parameters.toJson());
    print(token);
    print(url);
    final request = await client.getUrl(url);
    request.headers.contentType = ContentType.json;
    request.headers.add('Authorization', "Bearer $token");
    try {
      final response = await request.close();
      var responseData = await response.transform(utf8.decoder).toList();
      var responseString = responseData.join();

      final json = await jsonDecode(responseString);
      final json1 = json["announcesDto"];
      final json2 = json["announcesCount"];
      final announces = json1
          .map((dynamic e) =>
              SearchAnnounces.fromJson(e as Map<String, dynamic>))
          .toList();
      return announces;
    } catch (e) {
      print('Error in getSearchAnnounces: $e');
    }
  }

  Future<dynamic> postCreateFolder(listName) async {
    final token = await secureStorage.read(key: "token");
    final url = 'https://rieltorofisi.com/api/Rieltor/create-list';
    try {
      final response = await dio.post(
        url,
        data: {"listName": listName},
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final responseData = response;
      final data = responseData.data;
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getFolders() async {
    final token = await secureStorage.read(key: "token");
    final url = 'https://rieltorofisi.com/api/Rieltor/lists';
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final responseData = response.data;
      final data = await responseData
          .map((e) => GetFolders.fromJson(e as Map<String, dynamic>))
          .toList();

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getFoldersByAnnounces(announceId) async {
    final token = await secureStorage.read(key: "token");
    final url = 'https://rieltorofisi.com/api/Rieltor/get-folders-by-announce';
    try {
      final response = await dio.get(url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
            },
          ),
          queryParameters: {"announceId": announceId});
      final responseData = response.data;
      final data = responseData
          .map((e) => GetFoldersByAnnounces.fromJson(e as Map<String, dynamic>))
          .toList();

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postAddOrRemoveItemFolders(announceId, listId) async {
    final token = await secureStorage.read(key: "token");
    final url = 'https://rieltorofisi.com/api/Rieltor/add-or-remove-item-list';
    try {
      final response = await dio.post(url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
            },
          ),
          data: jsonEncode({"announceId": announceId, "listId": listId}));
      final responseData = response.data;
      final data = responseData;

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getSingleFolder(listId, pageNumber, pageSize) async {
    final token = await secureStorage.read(key: "token");
    final url = 'https://rieltorofisi.com/api/Rieltor/single-list';
    try {
      final response = await dio.get(url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
            },
          ),
          queryParameters: {
            "ListId": listId,
            "PageNumber": pageNumber,
            "PageSize": pageSize,
          });
      final responseData = response.data;
      final data = responseData
          .map((e) => SingleFolder.fromJson(e as Map<String, dynamic>))
          .toList();

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteFolder(listId) async {
    final token = await secureStorage.read(key: "token");
    final url = 'https://rieltorofisi.com/api/Rieltor/remove-list';
    try {
      final response = await dio.delete(url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "listId": listId,
          });
      final responseData = response.data;
      final data = responseData;
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postAddOrRemoveItemWishlist(announceId) async {
    final token = await secureStorage.read(key: "token");
    final url =
        'https://rieltorofisi.com/api/Announce/add-or-remove-item-wishlist';
    try {
      final response = await dio.post(url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
            },
          ),
          data: jsonEncode({"announceId": announceId}));
      final responseData = response.data;
      final data = responseData;

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getWishlist(pageNumber, pageSize) async {
    final token = await secureStorage.read(key: "token");
    print(token);

    final url = 'https://rieltorofisi.com/api/Announce/wishlist';
    try {
      final response = await dio.get(url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
            },
          ),
          queryParameters: {
            "PageNumber": pageNumber,
            "PageSize": pageSize,
          });
      token;
      final responseData = response.data;
      final data = responseData
          .map((e) => Wishlist.fromJson(e as Map<String, dynamic>))
          .toList();

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postSaveFilter() async {
    final token = await secureStorage.read(key: "token");
    print(token);
    final jsonParameters = parameters.toJson();
    final changedParameters = jsonParameters.map((key, value) => MapEntry(
          key,
          (value is String || value is String?)
              ? (value == "false" || value == "true"
                  ? bool.parse(value)
                  : int.parse(value))
              : value,
        ));
    final url = 'https://rieltorofisi.com/api/Subscription/save-filter';
    try {
      // final List<Map<String, dynamic>> parametersList = parameters.map((param) => param.toJson()).toList();
      final response = await dio.post(url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "announceParameterPaging": changedParameters,
            "filterName": parameters1.filterName,
            "announceCount": parameters1.announceCount
          });

      token;
      final responseData = response.data;
      final data = responseData;

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getFilters() async {
    final token = await secureStorage.read(key: "token");
    final url = 'https://rieltorofisi.com/api/Subscription/filters';
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': 'Bearer $token',
          },
        ),
      );
      token;
      final responseData = response.data;
      final data = responseData
          .map((e) => Subscriptions.fromJson(e as Map<String, dynamic>))
          .toList();

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteFilter(filterId) async {
    final token = await secureStorage.read(key: "token");
    final url = 'https://rieltorofisi.com/api/Subscription/remove-filter';
    try {
      final response = await dio.delete(url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
            },
          ),
          data: {"filterId": filterId});

      token;
      final responseData = response.data;
      final data = responseData;

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getSubscriptionAnnounces(
      filterId, pageNumber, pageSize, sortType) async {
    final token = await secureStorage.read(key: "token");
    final url = 'https://rieltorofisi.com/api/Subscription/get-filter';
    try {
      final response = await dio.get(url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
            },
          ),
          queryParameters: {
            "FilterId": filterId,
            "SortType": sortType,
            "PageNumber": pageNumber,
            "PageSize": pageSize
          });
      token;
      final responseData = response.data;
      final data = responseData;

      return data.map((e) => SubscriptionAnnounces.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
  }
}
