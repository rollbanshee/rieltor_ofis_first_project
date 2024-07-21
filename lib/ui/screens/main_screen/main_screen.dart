import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:rieltor_ofis/domain/api_clients/api_client.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:rieltor_ofis/ui/screens/details_page/details_page.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page_model.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_model.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/to_modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/subscriptions/subscriptions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // latesnapshot.dataIndexsnapshot.data;
  ApiClient apiClient = ApiClient();
  // Future<void> getdannie() async {
  //  snapshot.data = await apiClient.getHomeIndex();
  //   setState(() {});
  // }

  // String dateTimeString =

  String formatDateTime(dateTimeString, String locale) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final dateTime = inputFormat.parse(dateTimeString);

    final outputFormat = DateFormat("dd MMMM y | HH:mm", locale);
    final formattedDateTime = outputFormat.format(dateTime);

    return formattedDateTime;
  }

  @override
  void initState() {
    super.initState();

    final provider = context.read<FoldersModel>();
    provider.getWishlist(provider.pageNumber, provider.pageSize);

    initializeDateFormatting("az_AZ", null);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailsPageModel>();
    final provider1 = context.watch<FoldersModel>();

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(30.r),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubscriotionScreen()));
                      },
                      child: Container(
                        // padding: EdgeInsets.all(8.0),
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(235, 155, 0, 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8.0.w, 8.h, 8.w, 8.h),
                          child: SvgPicture.asset(
                            "assets/images/Bell.svg",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Elanlar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(51, 51, 51, 1)),
                ),
                SizedBox(
                  width: 40.w,
                )
              ],
            ),
          ),
          FutureBuilder(
              future: apiClient.getHomeIndex(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: RefreshIndicator(
                      color: Colors.green,
                      onRefresh: () async {
                        return setState(() {});
                      },
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.w, top: 0.h),
                              child: Text(
                                "Satılan Son Elanlar",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(51, 51, 51, 1)),
                              ),
                            ),
                            GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 8.h),
                                itemCount: 4,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.45),
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15),
                                itemBuilder: (context, index) => InkWell(
                                      borderRadius: BorderRadius.circular(10.r),
                                      onTap: () {
                                        provider
                                            .getdetailspageData(
                                                snapshot.data!
                                                    .announcesForSale[index].id,
                                                context)
                                            .then((_) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(
                                                    index: index,
                                                    secGrid: false,
                                                    elanId: snapshot
                                                        .data!
                                                        .announcesForSale[index]
                                                        .id,
                                                  ),
                                                )));
                                      },
                                      child: Container(
                                        // padding: EdgeInsets.only(bottom: 10.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    233, 233, 233, 1))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              10.r)),
                                                  child: Image.network(
                                                    'https://d2jcoi69vojtfw.cloudfront.net/' +
                                                        snapshot
                                                            .data!
                                                            .announcesForSale[
                                                                index]
                                                            .cover
                                                            .toString(),
                                                    width: double.infinity,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            6,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        SizedBox(
                                                      width: double.infinity,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              6,
                                                      child: Center(
                                                          child: Padding(
                                                        padding: EdgeInsets.all(
                                                            36.w),
                                                        child: Text(
                                                          "the image was not uploaded",
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    provider1.announceId =
                                                        snapshot
                                                            .data!
                                                            .announcesForSale[
                                                                index]
                                                            .id;
                                                    await provider1
                                                        .postAddOrRemoveItemWishlist(
                                                            provider1
                                                                .announceId);
                                                    await provider1.getWishlist(
                                                        provider1.pageNumber,
                                                        provider1.pageSize);
                                                    provider1.wishlist!.any(
                                                            (element) =>
                                                                provider1
                                                                    .announceId ==
                                                                element.id)
                                                        ? provider1
                                                                .wishlistCheck =
                                                            true
                                                        : provider1
                                                                .wishlistCheck =
                                                            false;

                                                    await dotomodalbottomsheet();
                                                  },
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                                  10)
                                                              .w,
                                                      child: provider1
                                                                  .wishlist ==
                                                              null
                                                          ? SvgPicture.asset(
                                                              "assets/images/HeartStraight1.svg",
                                                              width: 30.w,
                                                              height: 30.h,
                                                            )
                                                          : provider1.wishlist!
                                                                  .any((element) =>
                                                                      snapshot
                                                                          .data!
                                                                          .announcesForSale[
                                                                              index]
                                                                          .id ==
                                                                      element
                                                                          .id)
                                                              ? SvgPicture
                                                                  .asset(
                                                                  "assets/images/HeartStraightRed.svg",
                                                                  width: 30.w,
                                                                  height: 30.h,
                                                                )
                                                              : SvgPicture
                                                                  .asset(
                                                                  "assets/images/HeartStraight1.svg",
                                                                  width: 30.w,
                                                                  height: 30.h,
                                                                )),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    snapshot
                                                            .data!
                                                            .announcesForSale[
                                                                index]
                                                            .price
                                                            .toString() +
                                                        " AZN",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        // fontFamily: 'SFProText-Regular',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Color.fromRGBO(
                                                            51, 51, 51, 1)),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .announcesForSale[index]
                                                        .address!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        // fontFamily: "SFProText-Regular",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            51, 51, 51, 1)),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    snapshot
                                                            .data!
                                                            .announcesForSale[
                                                                index]
                                                            .roomCount
                                                            .toString() +
                                                        " otaqlı - " +
                                                        snapshot
                                                            .data!
                                                            .announcesForSale[
                                                                index]
                                                            .space
                                                            .toString() +
                                                        " m²",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            51, 51, 51, 1)),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    "Baki, " +
                                                        formatDateTime(
                                                            snapshot
                                                                .data!
                                                                .announcesForSale[
                                                                    index]
                                                                .announceDate,
                                                            "az_AZ"),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        // fontFamily: "SFProText-Regular",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: const Color
                                                            .fromRGBO(
                                                            119, 119, 119, 1)),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w, top: 8.h),
                              child: Text(
                                "Kirayə Verilən Elanlar",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(51, 51, 51, 1)),
                              ),
                            ),
                            GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 8),
                                itemCount: 4,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.45),
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15),
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        provider
                                            .getdetailspageData(
                                                snapshot.data!
                                                    .announcesForRent[index].id,
                                                context)
                                            .then((_) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(
                                                    index: index,
                                                    secGrid: false,
                                                    elanId: snapshot
                                                        .data!
                                                        .announcesForRent[index]
                                                        .id,
                                                  ),
                                                )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    233, 233, 233, 1))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              10.r)),
                                                  child: Image.network(
                                                    'https://d2jcoi69vojtfw.cloudfront.net/' +
                                                        snapshot
                                                            .data!
                                                            .announcesForRent[
                                                                index]
                                                            .cover
                                                            .toString(),
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        SizedBox(
                                                      width: double.infinity,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              6,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        10.r)),
                                                        child: Center(
                                                          child: Text(
                                                              "the image was not uploaded"),
                                                        ),
                                                      ),
                                                    ),
                                                    width: double.infinity,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            6,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    provider1.announceId =
                                                        snapshot
                                                            .data!
                                                            .announcesForRent[
                                                                index]
                                                            .id;
                                                    await provider1
                                                        .postAddOrRemoveItemWishlist(
                                                            provider1
                                                                .announceId);
                                                    await provider1.getWishlist(
                                                        provider1.pageNumber,
                                                        provider1.pageSize);
                                                    provider1.wishlist!.any(
                                                            (element) =>
                                                                provider1
                                                                    .announceId ==
                                                                element.id)
                                                        ? provider1
                                                                .wishlistCheck =
                                                            true
                                                        : provider1
                                                                .wishlistCheck =
                                                            false;

                                                    await dotomodalbottomsheet();
                                                  },
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                                  10)
                                                              .w,
                                                      child: provider1
                                                                  .wishlist ==
                                                              null
                                                          ? SvgPicture.asset(
                                                              "assets/images/HeartStraight1.svg",
                                                              width: 30.w,
                                                              height: 30.h,
                                                            )
                                                          : provider1.wishlist!
                                                                  .any((element) =>
                                                                      snapshot
                                                                          .data!
                                                                          .announcesForRent[
                                                                              index]
                                                                          .id ==
                                                                      element
                                                                          .id)
                                                              ? SvgPicture
                                                                  .asset(
                                                                  "assets/images/HeartStraightRed.svg",
                                                                  width: 30.w,
                                                                  height: 30.h,
                                                                )
                                                              : SvgPicture
                                                                  .asset(
                                                                  "assets/images/HeartStraight1.svg",
                                                                  width: 30.w,
                                                                  height: 30.h,
                                                                )),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    "${snapshot.data!.announcesForRent[index].price} AZN",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        // fontFamily: 'SFProText-Regular',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: const Color
                                                            .fromRGBO(
                                                            51, 51, 51, 1)),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .announcesForRent[index]
                                                        .address!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        // fontFamily: "SFProText-Regular",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color
                                                            .fromRGBO(
                                                            51, 51, 51, 1)),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    "${snapshot.data!.announcesForRent[index].roomCount} otaqlı - ${snapshot.data!.announcesForRent[index].space}m²",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color
                                                            .fromRGBO(
                                                            51, 51, 51, 1)),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    "Baki, " +
                                                        formatDateTime(
                                                            snapshot
                                                                .data!
                                                                .announcesForSale[
                                                                    index]
                                                                .announceDate,
                                                            "az_AZ"),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        // fontFamily: "SFProText-Regular",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: const Color
                                                            .fromRGBO(
                                                            119, 119, 119, 1)),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(34, 186, 104, 1))));
                }
              }),
        ],
      ),
    ));
  }
}
