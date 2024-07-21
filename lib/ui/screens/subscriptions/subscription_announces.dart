import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page_model.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_model.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/to_modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/subscriptions/subscriptions_model.dart';

class SubscriotionAnnounces extends StatelessWidget {
  const SubscriotionAnnounces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AppBarSubscription(),
          Expanded(child: SubscriotionAnnouncesGrid())
        ],
      )),
    );
  }
}

class AppBarSubscription extends StatelessWidget {
  const AppBarSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SubscriptionModel>();

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                  provider.pageNumber = 1;
                  provider.pageSize = 10;
                  provider.sortType = 1;
                  provider.announces = null;
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
            "${provider.listFilterName}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(51, 51, 51, 1)),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30).r,
            onTap: () {
              showGeneralDialog(
                barrierDismissible: true,
                barrierLabel: "",
                transitionDuration: Duration(milliseconds: 300),
                context: context,
                pageBuilder: (context, animation1, animation2) => Container(),
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                  position: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeIn,
                  ).drive(
                      Tween<Offset>(begin: Offset(0, 1.0), end: Offset.zero)),
                  child: FadeTransition(
                      opacity:
                          Tween<double>(begin: 0.5, end: 1).animate(animation),
                      child: SubscriptionSort()),
                ),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(253, 138, 2, 0.1),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: SvgPicture.asset(
                  "assets/images/SlidersHorizontal.svg",
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SubscriotionAnnouncesGrid extends StatefulWidget {
  const SubscriotionAnnouncesGrid({
    super.key,
  });

  @override
  State<SubscriotionAnnouncesGrid> createState() =>
      _SubscriotionAnnouncesGridState();
}

class _SubscriotionAnnouncesGridState extends State<SubscriotionAnnouncesGrid> {
  final controller = ScrollController();

  @override
  void initState() {
    final provider = context.read<SubscriptionModel>();
    final provider1 = context.read<FoldersModel>();
    provider1.getWishlist(provider.pageNumber, provider.pageSize);
    provider.getSubscriptionAnnounces(provider.filterId, provider.pageNumber,
        provider.pageSize, provider.sortType);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (provider.isLoading == false) {
          provider.pageNumber = provider.pageNumber + 1;
          provider.getSubscriptionAnnouncesMore(provider.filterId,
              provider.pageNumber, provider.pageSize, provider.sortType);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionModel>();
    final provider1 = context.watch<FoldersModel>();
    final provider2 = context.read<DetailsPageModel>();

    return provider.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(34, 186, 104, 1),
            ),
          )
        : provider.announces == null
            ? Center(
                child: Text(
                  ":(",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(
                    16.w, 0.h, 16.w, provider.hasMore ? 0.h : 16.h),
                child: CustomScrollView(
                  controller: controller,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  slivers: [
                    SliverGrid.builder(
                        // controller: controller,
                        // physics: BouncingScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount: provider.announces!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.55),
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                        itemBuilder: (context, index) => Material(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8.r),
                                onTap: () {
                                  provider2
                                      .getdetailspageData(
                                          provider.announces![index].id,
                                          context)
                                      .then(
                                        (value) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsPage(
                                                      index: 1,
                                                      secGrid: false,
                                                      elanId: provider
                                                          .announces![index].id,
                                                    ))),
                                      );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              233, 233, 233, 1))),
                                  child: Column(children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 128.h,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8.r),
                                                topRight: Radius.circular(8.r)),
                                            child: Image.network(
                                              'https://d2jcoi69vojtfw.cloudfront.net/' +
                                                  "${provider.announces![index].cover}",
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 128.h,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  8.r)),
                                                  child: Center(
                                                    child: Text(
                                                        "the image was not uploaded"),
                                                  ),
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 10.w,
                                          top: 10.h,
                                          child: GestureDetector(
                                              onTap: () async {
                                                provider1.announceId = provider
                                                    .announces![index].id;
                                                await provider1
                                                    .postAddOrRemoveItemWishlist(
                                                        provider1.announceId);
                                                await provider1.getWishlist(
                                                    provider1.pageNumber,
                                                    provider1.pageSize);
                                                provider1.wishlist!.any(
                                                        (element) =>
                                                            provider1
                                                                .announceId ==
                                                            element.id)
                                                    ? provider1.wishlistCheck =
                                                        true
                                                    : provider1.wishlistCheck =
                                                        false;
                                                await dotomodalbottomsheet();
                                              },
                                              child: provider1.wishlist == null
                                                  ? SvgPicture.asset(
                                                      "assets/images/HeartStraight1.svg",
                                                      width: 30.w,
                                                      height: 30.h,
                                                    )
                                                  : provider1.wishlist!.any(
                                                          (element) =>
                                                              provider
                                                                  .announces![
                                                                      index]
                                                                  .id ==
                                                              element.id)
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
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              "${provider.announces![index].price} AZN",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.sp,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "${provider.announces![index].address}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp),
                                            ),
                                            Text(
                                              "${provider.announces![index].roomCount} otaqlı - ${provider.announces![index].roomCount} m²",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp),
                                            ),
                                            Text(
                                              "Baki " +
                                                  provider.formatDateTime(
                                                      provider.announces![index]
                                                          .announceDate,
                                                      "az_AZ"),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color.fromRGBO(
                                                      119, 119, 119, 1)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            )),
                    if (provider.hasMore)
                      SliverToBoxAdapter(
                          child: Padding(
                        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Color.fromRGBO(34, 186, 104, 1),
                        )),
                      ))
                  ],
                ));
  }
}

class SubscriptionSort extends StatefulWidget {
  const SubscriptionSort({super.key});

  @override
  State<SubscriptionSort> createState() => _SubscriptionSortState();
}

class _SubscriptionSortState extends State<SubscriptionSort> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionModel>();
    return Theme(
      data: Theme.of(context).copyWith(useMaterial3: false),
      child: Dialog(
        backgroundColor: Colors.white,

        // contentPadding: EdgeInsets.all(20.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Siralama",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  provider.setSortType(1);
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                      border:
                          Border.all(color: Color.fromRGBO(239, 239, 239, 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dərc olunma - əvvəlcə yeniləri",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      provider.sortType == 1
                          ? SvgPicture.asset(
                              "assets/images/CheckCircleBlue.svg",
                              width: 24.w,
                              height: 24.h,
                              // fit: BoxFit.fill,
                            )
                          : Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color.fromRGBO(239, 239, 239, 1),
                                      width: 2.w))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  provider.setSortType(2);
                },
                child: Ink(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border:
                          Border.all(color: Color.fromRGBO(239, 239, 239, 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dərc olunma - əvvəlcə köhnələri",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      provider.sortType == 2
                          ? SvgPicture.asset(
                              "assets/images/CheckCircleBlue.svg",
                              width: 24.w,
                              height: 24.h,
                              // fit: BoxFit.fill,
                            )
                          : Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color.fromRGBO(239, 239, 239, 1),
                                      width: 2.w))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  provider.setSortType(3);
                },
                child: Ink(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border:
                          Border.all(color: Color.fromRGBO(239, 239, 239, 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sahe - boyukden kichiye",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      provider.sortType == 3
                          ? SvgPicture.asset(
                              "assets/images/CheckCircleBlue.svg",
                              width: 24.w,
                              height: 24.h,
                              // fit: BoxFit.fill,
                            )
                          : Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color.fromRGBO(239, 239, 239, 1),
                                      width: 2.w))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  provider.setSortType(4);
                },
                child: Ink(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border:
                          Border.all(color: Color.fromRGBO(239, 239, 239, 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sahe - kichikden boyuke",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      provider.sortType == 4
                          ? SvgPicture.asset(
                              "assets/images/CheckCircleBlue.svg",
                              width: 24.w,
                              height: 24.h,
                              // fit: BoxFit.fill,
                            )
                          : Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color.fromRGBO(239, 239, 239, 1),
                                      width: 2.w))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  provider.setSortType(5);
                },
                child: Ink(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border:
                          Border.all(color: Color.fromRGBO(239, 239, 239, 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Qiymət - əvvəlcə baha",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      provider.sortType == 5
                          ? SvgPicture.asset(
                              "assets/images/CheckCircleBlue.svg",
                              width: 24.w,
                              height: 24.h,
                              // fit: BoxFit.fill,
                            )
                          : Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color.fromRGBO(239, 239, 239, 1),
                                      width: 2.w))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  provider.setSortType(6);
                },
                child: Ink(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border:
                          Border.all(color: Color.fromRGBO(239, 239, 239, 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Qiymət - əvvəlcə ucuz",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      provider.sortType == 6
                          ? SvgPicture.asset(
                              "assets/images/CheckCircleBlue.svg",
                              width: 24.w,
                              height: 24.h,
                              // fit: BoxFit.fill,
                            )
                          : Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color.fromRGBO(239, 239, 239, 1),
                                      width: 2.w))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () async {
                  provider.pageNumber = 1;
                  provider.pageSize = 10;
                  Navigator.pop(context);

                  provider.getSubscriptionAnnounces(
                      provider.filterId,
                      provider.pageNumber,
                      provider.pageSize,
                      provider.sortType);
                },
                child: Ink(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Color.fromRGBO(34, 186, 104, 1)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    child: Text(
                      "Təsdiqlə",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
