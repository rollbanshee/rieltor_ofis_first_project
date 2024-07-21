import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rieltor_ofis/domain/api_clients/api_client.dart';

import 'package:intl/intl.dart';

class SearchAnnouncesModel extends ChangeNotifier {
  final api = ApiClient();
  var data1 = List.empty(growable: true);
  bool isLoading = false;
  bool hasMore = true;
  Future<dynamic> getSearchAnnounces(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });
    final data = await api.getSearchAnnounces();
    data1 = data;
    Navigator.pop(context);
    notifyListeners();
    return data;
  }

  Future<dynamic> getSearchAnnouncesForFolders() async {
    final data = await api.getSearchAnnounces();
    data1 = data;
    notifyListeners();

    return data;
  }

  Future<dynamic> getSearchAnnounces1() async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();

      final data = await api.getSearchAnnounces();
      if (data.isEmpty) {
        hasMore = false;
        notifyListeners();
      } else {
        hasMore = true;
      }
      data1.addAll(data);
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
    return data1;
  }

  Future<dynamic> getSearchAnnounces2() async {
    data1.clear();
    notifyListeners();

    if (isLoading == false) {
      isLoading = true;
      notifyListeners();

      final data = await api.getSearchAnnounces();
      if (data.isEmpty) {
        hasMore = false;
        notifyListeners();
      } else {
        hasMore = true;
      }
      data1.addAll(data);
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();

    return data1;
  }

  String formatDateTime(dateTimeString, String locale) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final dateTime = inputFormat.parse(dateTimeString);

    final outputFormat = DateFormat("dd MMMM y | HH:mm", locale);
    final formattedDateTime = outputFormat.format(dateTime);

    return formattedDateTime;
  }
}
