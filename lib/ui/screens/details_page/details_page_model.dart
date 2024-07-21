import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:rieltor_ofis/domain/api_clients/api_client.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entity/announces_id/announces_id.dart';

class DetailsPageModel extends ChangeNotifier {
  final apiClient = ApiClient();
  AnnouncesId? detailspageData;
  late ValueNotifier<int> kakoytoIndex;
  Set<Marker> markers = {};

  Future<void> getdetailspageData(id, context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });
    kakoytoIndex = ValueNotifier(0);
    final detailspagedataResponse = await apiClient.getAnnouncesId(id);
    detailspageData = detailspagedataResponse;
    Navigator.pop(context);
    notifyListeners();
  }

  String formatDateTime(dateTimeString, String locale) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final dateTime = inputFormat.parse(dateTimeString);

    final outputFormat = DateFormat("dd MMMM y", locale);
    final formattedDateTime = outputFormat.format(dateTime);

    return formattedDateTime;
  }

  void setmarkerlabel() async {
    await markers.addLabelMarker(LabelMarker(
      textStyle: TextStyle(fontSize: 40.sp),
      icon: BitmapDescriptor.defaultMarker,
      label:
          "${detailspageData!.price} AZN ${detailspageData!.roomCount} otaqli - ${detailspageData!.space} m²",
      markerId: MarkerId("idString"),
      position: LatLng(detailspageData!.location!.latitude!,
          detailspageData!.location!.longitude!),
      backgroundColor: Colors.green,
    ));
    notifyListeners();
  }

  launchURL(url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

class DetailsPageModelX extends GetxController {
  var controller = PageController(initialPage: 0);
  var currentIndex = 0;

  changeIndex(currentIndex) {
    this.currentIndex = currentIndex;
  }
}
