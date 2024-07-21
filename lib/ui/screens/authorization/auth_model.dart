import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rieltor_ofis/domain/api_clients/api_client.dart';

class AuthModel {
  final phone = TextEditingController();
  final name = TextEditingController();
  TextEditingController code = TextEditingController(text: "1950");
  String userId = "";

  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  void authCheck(auth) async {
    secureStorage.write(key: "auth", value: auth.toString());
  }

  Future<String> postPhone(phone) async {
    secureStorage.write(key: "phone", value: phone.text);
    final code = await ApiClient()
        .postPhone(phone: phone.text.replaceAll(RegExp('[^A-Za-z0-9]'), ''));

    // this.code = code.text;
    return code;
  }

  Future<String> postPhoneCode() async {
    final userId = await ApiClient().postPhoneCode(
        phone: phone.text.replaceAll(RegExp('[^A-Za-z0-9]'), ''),
        code: code.text);
    this.userId = userId;
    // this.code = code.text;

    return userId;
  }

  Future<String> postName(name) async {
    secureStorage.write(key: "name", value: name);
    final token = await ApiClient().postNameID(name: name, userId: userId);
    // this.code = code.text;

    return token;
  }
}
