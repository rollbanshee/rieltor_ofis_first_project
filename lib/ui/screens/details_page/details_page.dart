import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page_model.dart';
import 'package:rieltor_ofis/ui/screens/details_page/photos_screen.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/to_modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.index,
    required this.secGrid,
    required this.elanId,
  });
  final bool secGrid;
  final int index;
  final int elanId;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  bool _showGoogleMaps = false;
  void initState() {
    super.initState();
    // getdannie();
    final provider = context.read<FoldersModel>();
    provider.getWishlist(provider.pageNumber, provider.pageSize);
    initializeDateFormatting("az_AZ", null);
    Future.delayed(const Duration(milliseconds: 1), () {
      setState(() {
        _showGoogleMaps = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailsPageModel>();
    final provider1 = context.watch<FoldersModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16).h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // GestureDetector(
                    // onTap: () {
                    // Navigator.pop(context);
                    // },
                    // child:
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(34, 186, 104, 0.1),
                          shape: BoxShape.circle),
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          splashRadius: 20.r,
                          onPressed: () {
                            _showGoogleMaps = false;
                            provider.markers = {};
                            setState(() {});

                            Navigator.pop(context);
                          },
                          icon: SvgPicture.asset(
                            "assets/images/ArrowLeft.svg",
                            // fit: BoxFit.scaleDown,
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),

                    Text(
                      // provider.detailspageData.price,
                      provider.detailspageData!.propertyType == null
                          ? "${provider.detailspageData!.price.toString()}"
                          : "${provider.detailspageData!.propertyType}, ${provider.detailspageData!.price.toString()}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: Colors.black),
                    ),
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 230, 255, 1),
                          shape: BoxShape.circle),
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          splashRadius: 20.r,
                          onPressed: () {
                            _showGoogleMaps = false;
                            provider.markers = {};
                            setState(() {});
                            Share.share(provider.detailspageData!.parserSite!);
                          },
                          icon: SvgPicture.asset(
                            "assets/images/ShareNetwork.svg",
                            // fit: BoxFit.scaleDown,
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0).h,
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: 235.w,
                                  height: 190.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: ValueListenableBuilder(
                                      valueListenable: provider.kakoytoIndex,
                                      builder: (context, value, _) => ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        child: Container(
                                          width: 100.w,
                                          height: 60.h,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              // Image tapped
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://d2jcoi69vojtfw.cloudfront.net/' +
                                                        provider.detailspageData!
                                                                .logoImages![
                                                            provider
                                                                .kakoytoIndex
                                                                .value],
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        34,
                                                                        186,
                                                                        104,
                                                                        1))),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Photos()));
                                                    // Get.to(() => Photos(),
                                                    // transition: Transition
                                                    // .rightToLeft,
                                                    // duration: Duration(
                                                    // milliseconds: 800));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: GestureDetector(
                                      onTap: () async {
                                        provider1.announceId = widget.elanId;
                                        await provider1
                                            .postAddOrRemoveItemWishlist(
                                                widget.elanId);
                                        await provider1.getWishlist(
                                            provider1.pageNumber,
                                            provider1.pageSize);
                                        provider1.wishlist!.any((element) =>
                                                widget.elanId == element.id)
                                            ? provider1.wishlistCheck = true
                                            : provider1.wishlistCheck = false;
                                        await dotomodalbottomsheet();
                                      },
                                      child: provider1.wishlist == null
                                          ? SvgPicture.asset(
                                              "assets/images/HeartStraight1.svg",
                                              width: 30.w,
                                              height: 30.h,
                                            )
                                          : provider1.wishlist!.any((element) =>
                                                  widget.elanId == element.id)
                                              ? SvgPicture.asset(
                                                  "assets/images/HeartStraightRed.svg",
                                                  width: 30.w,
                                                  height: 30.h,
                                                )
                                              : SvgPicture.asset(
                                                  "assets/images/HeartStraight1.svg",
                                                  width: 30.w,
                                                  height: 30.h,
                                                )),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            ListViewPic()
                          ],
                        ),
                      ),
                      Price(),
                      Info1(),
                      Info2(),
                      if (provider.detailspageData!.announceCondition!
                          .toJson()
                          .values
                          .any((e) => e == true))
                        Info3(),
                      InfoText(),
                      ReadMoreText(
                        text: provider.detailspageData!.text.toString(),
                      ),
                      if (_showGoogleMaps &&
                          provider.detailspageData!.location != null)
                        GoogleMaps()
                      else
                        SizedBox.shrink(),
                      SizedBox(
                        height: 8.h,
                      ),
                      provider.detailspageData!.nearbyLocations!
                                  .theNearestPark ==
                              null
                          ? SizedBox.shrink()
                          : TheNearestPark(),
                      provider.detailspageData!.nearbyLocations!
                                  .theNearestSchool ==
                              null
                          ? SizedBox.shrink()
                          : TheNearestSchool(),
                      provider.detailspageData!.nearbyLocations!
                                  .theNearestStation ==
                              null
                          ? SizedBox.shrink()
                          : TheNearestStation(),
                      provider.detailspageData!.similarAds!.isEmpty
                          ? SizedBox.shrink()
                          : Ads(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/
class ListViewPic extends StatefulWidget {
  const ListViewPic({super.key});

  @override
  State<ListViewPic> createState() => _ListViewPicState();
}

class _ListViewPicState extends State<ListViewPic> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailsPageModel>();

    return Expanded(
        child: SizedBox(
      height: 190.h,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: provider.detailspageData?.logoImages!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom:
                      index != provider.detailspageData!.logoImages!.length - 1
                          ? 5
                          : 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 100.w,
                  height: 60.h,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image tapped
                      CachedNetworkImage(
                        imageUrl: 'https://d2jcoi69vojtfw.cloudfront.net/' +
                            provider.detailspageData!.logoImages![index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                                color: Color.fromRGBO(34, 186, 104, 1))),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: () {
                            provider.kakoytoIndex.value = index;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    ));
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/
class Price extends StatelessWidget {
  const Price({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailsPageModel>();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // height: 52.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(
          provider.detailspageData!.price.toString() + " AZN",
          style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),
      ),
    );
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/
class Info1 extends StatelessWidget {
  const Info1({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailsPageModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8).h,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            // height: 28.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).r,
                color: Color.fromRGBO(34, 186, 104, 1)),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),

            child: Text(
              "${provider.detailspageData!.roomCount.toString()} otaqli",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Container(
            alignment: Alignment.center,
            // height: 28.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).r,
                color: Color.fromRGBO(34, 186, 104, 1)),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            child: Text(
              "${provider.detailspageData!.space} m²",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              // height: 28.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color.fromRGBO(34, 186, 104, 1)),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              child: Text(
                "${provider.detailspageData!.currentFloor.toString()}/${provider.detailspageData!.floorCount.toString()} mərtəbə",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/
class Info2 extends StatelessWidget {
  const Info2({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailsPageModel>();

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          children: [
            if (provider.detailspageData!.complex == null)
              SizedBox.shrink()
            else
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Color.fromRGBO(255, 175, 60, 0.1)),
                padding: EdgeInsets.all(8).w,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/building_line.svg",
                      width: 16.w,
                      height: 16.h,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      provider.detailspageData!.complex!,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            SizedBox(
              height: 8.h,
            ),
            if (provider.detailspageData!.address == null)
              SizedBox.shrink()
            else
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/MapPin.svg",
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 6.w),
                  SizedBox(
                    width: 320.w,
                    child: Text(
                      provider.detailspageData!.address!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            SizedBox(
              height: 8.h,
            ),
            if (provider.detailspageData!.parserSite == null)
              SizedBox.shrink()
            else
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/Globe.svg",
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    provider.detailspageData!.parserSite.toString(),
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  )
                ],
              ),
            SizedBox(
              height: 8.h,
            ),
            if (provider.detailspageData!.announceDate == null)
              SizedBox.shrink()
            else
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/Clock.svg",
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    provider.formatDateTime(
                        provider.detailspageData!.announceDate, "az_AZ"),
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  )
                ],
              )
          ],
        ));
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/

class Info3 extends StatelessWidget {
  const Info3({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailsPageModel>();
    return Container(
      // alignment: Alignment.bottomLeft,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border:
              Border.all(color: Color.fromRGBO(238, 238, 238, 1), width: 1.w)),
      child: Wrap(
          // alignment: WrapAlignment.spaceEvenly,
          runSpacing: 17.h,
          spacing: 15.w,
          // runAlignment: WrapAlignment,
          // crossAxisAlignment: WrapCrossAlig,
          children: [
            if (provider.detailspageData!.announceCondition!.hasElevator ==
                false)
              Container(
                  width: 88.6.w,
                  // alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/elevator-lift-svgrepo-com 1.svg",
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Lift",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  )),
            if (provider.detailspageData!.announceCondition!.hasGarage == false)
              Container(
                  width: 88.6.w,
                  // height: 40.h,
                  // alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/garage-svgrepo-com 1.svg",
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Qaraj",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  )),
            if (provider.detailspageData!.announceCondition!.hasGas == true)
              Container(
                  width: 88.6.w,

                  // alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/Fire.svg",
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Qaz",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  )),
            if (provider.detailspageData!.announceCondition!.hasHeatingSystem ==
                false)
              Container(
                  width: 88.6.w,
                  // height: 40.h,

                  // alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/heating-svgrepo-com 1.svg",
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "İstilik sistemi",
                        // textAlign: TextAlign.just,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  )),
            if (provider.detailspageData!.announceCondition!.hasSecurity ==
                false)
              Container(
                  width: 88.6.w,

                  // alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/VideoCamera.svg",
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Kamera",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  )),
            if (provider.detailspageData!.announceCondition!.hasStation ==
                false)
              Container(
                  width: 88.6.w,

                  // alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/WifiHigh.svg",
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "İnternet",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  ))
          ]),
    );
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/
class InfoText extends StatefulWidget {
  const InfoText({super.key});

  @override
  State<InfoText> createState() => _InfoTextState();
}

class _InfoTextState extends State<InfoText> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailsPageModel>();

    return Container(
      // alignment: Alignment.bottomLeft,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border:
              Border.all(color: Color.fromRGBO(238, 238, 238, 1), width: 1.w)),
      child: Row(
        children: [
          Container(
            // alignment: Alignment.center,
            height: 50.h,
            // width: 50.w,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(253, 181, 41, 0.1),
            ),
            child: Text(
              provider.detailspageData!.owner![0],
              style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(253, 181, 41, 1)),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 185.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.detailspageData!.owner!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  provider.detailspageData!.ownerType ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 19.w,
          ),
          InkWell(
            radius: 28.r,
            borderRadius: BorderRadius.circular(28.r),
            onTap: () {
              launch('tel://${provider.detailspageData!.mobile}');
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(41, 114, 253, 0.05)),
              child: SvgPicture.asset(
                "assets/images/Phone.svg",
                width: 24.w,
                height: 24.h,
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/

class ReadMoreText extends StatefulWidget {
  const ReadMoreText({super.key, required this.text});
  final String text;

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText>
    with TickerProviderStateMixin {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.w),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(233, 233, 233, 1)),
            borderRadius: BorderRadius.circular(10.r)),
        child: Text(
          widget.text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ));
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/
class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  void initState() {
    super.initState();

    final provider = context.read<DetailsPageModel>();
    if (provider.detailspageData!.location!.latitude != null) {
      provider.setmarkerlabel();
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsPageModel>();

    return Container(
      height: 160.h,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(233, 233, 233, 1)),
          borderRadius: BorderRadius.circular(10.r)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: GoogleMap(
          mapType: MapType.normal,
          markers: provider.markers,
          initialCameraPosition: CameraPosition(
              zoom: 16,
              target: LatLng(provider.detailspageData!.location!.latitude!,
                  provider.detailspageData!.location!.longitude!)),
        ),
      ),
    );
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/

class TheNearestPark extends StatelessWidget {
  const TheNearestPark({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsPageModel>();

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: Color.fromRGBO(34, 186, 104, 0.14),
            borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ən yaxın park",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    provider.detailspageData!.nearbyLocations!.theNearestPark!
                            .name ??
                        "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
            Text(
              provider.detailspageData!.nearbyLocations!.theNearestPark!
                          .distance
                          .toString() +
                      "m" ??
                  "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/

class TheNearestSchool extends StatelessWidget {
  const TheNearestSchool({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsPageModel>();

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: Color.fromRGBO(34, 186, 104, 0.14),
            borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Ən yaxın məktəb",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    provider.detailspageData!.nearbyLocations!.theNearestSchool!
                            .name ??
                        "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
            Text(
              provider.detailspageData!.nearbyLocations!.theNearestSchool!
                          .distance
                          .toString() +
                      "m" ??
                  "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/

class TheNearestStation extends StatelessWidget {
  const TheNearestStation({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsPageModel>();

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: Color.fromRGBO(34, 186, 104, 0.14),
            borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Ən yaxın stansiya",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    provider.detailspageData!.nearbyLocations!
                            .theNearestStation!.name ??
                        "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
            Text(
              provider.detailspageData!.nearbyLocations!.theNearestStation!
                          .distance
                          .toString() +
                      "m" ??
                  "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
/*
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/

class Ads extends StatelessWidget {
  const Ads({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsPageModel>();

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8.h, 0, 16.h),
      child:

          // height: MediaQuery.of(context).size.height,
          Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Color.fromRGBO(238, 238, 238, 1))),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Dərc olunma :",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Qimət:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Mənbə :",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 8.h),
              width: MediaQuery.of(context).size.width,
              height: 110.h,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  provider.detailspageData!.similarAds!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 16.h),
                                  child: Text(
                                    "${provider.formatDateTime(provider.detailspageData!.similarAds![index].announceDate, "az_AZ")}",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  provider.detailspageData!.similarAds!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 16.h),
                                  child: Text(
                                    "${provider.detailspageData!.similarAds![index].price} AZN",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  provider.detailspageData!.similarAds!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 16.h),
                                  child: InkWell(
                                    onTap: () {
                                      provider.launchURL(provider
                                          .detailspageData!
                                          .similarAds![index]
                                          .originalLink);
                                    },
                                    child: Text(
                                      "${provider.detailspageData!.similarAds![index].site}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.blue),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
