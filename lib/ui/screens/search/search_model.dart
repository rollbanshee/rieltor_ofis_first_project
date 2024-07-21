import 'package:flutter/material.dart';
import 'package:rieltor_ofis/domain/api_clients/api_client.dart';
import 'package:intl/intl.dart';
import 'package:rieltor_ofis/domain/entity/search/search.dart';

class GetAnnounces extends ChangeNotifier {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  int dataCount = 0;
  bool isLoading = true;
  final _apiclient = ApiClient();
  var formatter = NumberFormat('#,###,###');
  List floor = List.generate(30, growable: true, (index) => index + 1);

  getCount() async {
    isLoading = true;
    notifyListeners();
    dataCount = await _apiclient.getSearchCount();
    isLoading = false;
    notifyListeners();
    return dataCount;
  }

  checkSymbols(controller) {
    [".", ",", "-", " "].any(controller.text.contains)
        ? (
            controller.text = controller.text.replaceAll(".", ""),
            controller.text = controller.text.replaceAll(",", ""),
            controller.text = controller.text.replaceAll("-", ""),
            controller.text = controller.text.replaceAll(" ", "")
          )
        : null;
  }
}
