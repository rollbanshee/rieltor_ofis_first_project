import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rieltor_ofis/domain/api_clients/api_client.dart';
import 'package:intl/intl.dart';

class FoldersModel extends ChangeNotifier {
  ApiClient apiClient = ApiClient();
  String? setFolderName;
  String errorText = "";
  String? listName;
  List? folders;
  List foldersByAnnounces = [];
  int? announceId;
  final String pageNumber = "1";
  final String pageSize = "10";
  List listId = List.empty(growable: true);
  List? singleFoldersAnnounces = [];
  List? wishlist;
  bool? wishlistCheck;
  bool? isInAnyFoldersCheck;

  Future postCreateFolder(listName) async {
    await apiClient.postCreateFolder(listName);
  }

  Future getFolders() async {
    await apiClient.getFolders().then((value) {
      folders = value;
    });
    notifyListeners();
  }

  Future getFoldersByAnnounces(announceId) async {
    await apiClient.getFoldersByAnnounces(announceId).then((value) {
      listId = value.map((e) => e.listId).toList();
      foldersByAnnounces = value;
      notifyListeners();
    });
  }

  Future postAddOrRemoveItemFolders(announceId, listId) async {
    await apiClient
        .postAddOrRemoveItemFolders(announceId, listId)
        .then((value) {
      notifyListeners();
    });
  }

  Future getSingleFolder(listId, pageNumber, pageSize) async {
    await apiClient.getSingleFolder(listId, pageNumber, pageSize).then((value) {
      singleFoldersAnnounces = value;
      notifyListeners();
    });
  }

  Future deleteFolder(listId) async {
    await apiClient.deleteFolder(listId);
  }

  Future postAddOrRemoveItemWishlist(announceId) async {
    await apiClient.postAddOrRemoveItemWishlist(announceId).then((value) {
      notifyListeners();
    });
  }

  Future getWishlist(pageNumber, pageSize) async {
    await apiClient.getWishlist(pageNumber, pageSize).then((value) {
      wishlist = value;

      notifyListeners();
    });
  }

  void setNameCheck() {
    if (folders!.any((element) => element.listName == setFolderName)) {
      errorText = "Bu adda qovluq movcuddur.";
      notifyListeners();
    } else if (setFolderName == "") {
      errorText = "Qovluqun adi bosh ola bilmez.";
      notifyListeners();
    } else {
      errorText = "";
      notifyListeners();
    }
  }

  String formatDateTime(dateTimeString, String locale) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final dateTime = inputFormat.parse(dateTimeString);

    final outputFormat = DateFormat("dd MMMM y | HH:mm", locale);
    final formattedDateTime = outputFormat.format(dateTime);

    return formattedDateTime;
  }

  void callback(setState) {
    return setState;
  }
}
