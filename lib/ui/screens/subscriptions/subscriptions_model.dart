import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rieltor_ofis/domain/api_clients/api_client.dart';
import 'package:intl/intl.dart';

class SubscriptionModel extends ChangeNotifier {
  ApiClient apiClient = ApiClient();
  String filterName = "";
  String errorText = "";
  int pageNumber = 1;
  int pageSize = 10;
  int sortType = 1;
  bool isLoading = false;
  bool hasMore = true;
  List? filters;
  List? announces = List.empty(growable: true);
  int? filterId;
  String? listFilterName;

  Future postSaveFilter() async {
    isLoading = true;
    notifyListeners();
    if (isLoading) {
      await apiClient.postSaveFilter();
      isLoading = false;
    }
    notifyListeners();
  }

  Future getFilters() async {
    isLoading = true;
    if (isLoading) {
      filters = await apiClient.getFilters();
      isLoading = false;
    }
    notifyListeners();
    return filters;
  }

  Future deleteFilter(filterId) async {
    isLoading = true;
    if (isLoading) {
      await apiClient.deleteFilter(filterId);
      await getFilters();
      isLoading = false;
    }
    notifyListeners();
  }

  Future getSubscriptionAnnounces(
      filterId, pageNumber, pageSize, sortType) async {
    await Future.delayed(Duration(milliseconds: 100));
    isLoading = true;
    notifyListeners();
    if (isLoading) {
      announces = await apiClient.getSubscriptionAnnounces(
          filterId, pageNumber, pageSize, sortType);
      isLoading = false;
    }
    notifyListeners();
  }

  Future getSubscriptionAnnouncesMore(
      filterId, pageNumber, pageSize, sortType) async {
    isLoading = true;
    if (isLoading) {
      final announces1 = await apiClient.getSubscriptionAnnounces(
          filterId, pageNumber, pageSize, sortType);
      if (announces1.isEmpty) {
        hasMore = false;
        notifyListeners();
      } else {
        hasMore = true;
      }
      announces?.addAll(announces1);
      isLoading = false;
    }
    notifyListeners();
  }

  void setFilterNameCheck() {
    if (filterName == "") {
      errorText = "Abunenin adi bosh ola bilmez.";
      notifyListeners();
    } else if (filters!.any((element) => element.filterName == filterName)) {
      errorText = "Bu ad artıq mövcuddur.";
      notifyListeners();
    } else {
      errorText = "";
      notifyListeners();
    }
  }

  void setSortType(int) {
    sortType = int;
    notifyListeners();
  }

  String formatDateTime(dateTimeString, String locale) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final dateTime = inputFormat.parse(dateTimeString);

    final outputFormat = DateFormat('dd MMMM y | HH:mm', locale);
    final formattedDateTime = outputFormat.format(dateTime);

    return formattedDateTime;
  }

  String formatDateTimePoints(dateTimeString, String locale) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final dateTime = inputFormat.parse(dateTimeString);

    final outputFormat = DateFormat('dd.MM.yyyy', locale);
    final formattedDateTime = outputFormat.format(dateTime);

    return formattedDateTime;
  }
}
