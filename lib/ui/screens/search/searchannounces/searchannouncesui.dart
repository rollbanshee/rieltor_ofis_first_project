// import 'package:flutter/foundation.dart';q
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/domain/entity/search/search.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page_model.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_model.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/to_modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/search/search_model.dart';
import 'package:rieltor_ofis/ui/screens/search/searchannounces/searchannouncesmodel.dart';

class SearchAnnouncesMain extends StatelessWidget {
  const SearchAnnouncesMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const AppBarSearch(),
          Container(
            width: 273.w,
            height: 1.h,
            color: Color.fromRGBO(233, 233, 233, 1),
          ),
          BetweenRow(),
          Expanded(child: GridAnnounces())
        ],
      )),
    );
  }
}

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context);
                  parameters.pageNumber = "1";
                  parameters.sortType = "1";
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
            "Nəticə",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(51, 51, 51, 1)),
          ),
          Ink(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Padding(
                padding: EdgeInsets.all(8.w),
                child: SizedBox(
                  width: 24.w,
                  height: 24.h,
                )),
          )
        ],
      ),
    );
  }
}

class BetweenRow extends StatelessWidget {
  BetweenRow({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GetAnnounces>();

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Son Elanlar",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black),
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                "(${provider.formatter.format(provider.dataCount)} elan)",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Color.fromRGBO(51, 51, 51, 0.6)),
              ),
            ],
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
                        ScaleTransition(
                  scale: Tween<double>(begin: 0.5, end: 1).animate(animation),
                  child: FadeTransition(
                      opacity:
                          Tween<double>(begin: 0.5, end: 1).animate(animation),
                      child: FilterColumn()),
                ),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(253, 138, 2, 0.1),
              ),
              child: Padding(
                padding: EdgeInsets.all(7.w),
                child: SvgPicture.asset(
                  "assets/images/SlidersHorizontal.svg",
                  width: 22.w,
                  height: 22.h,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GridAnnounces extends StatefulWidget {
  const GridAnnounces({super.key});

  @override
  State<GridAnnounces> createState() => _GridAnnouncesState();
}

class _GridAnnouncesState extends State<GridAnnounces> {
  final controller = ScrollController();
  // int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider2 = context.read<FoldersModel>();
    final provider = context.read<SearchAnnouncesModel>();
    provider2.getWishlist(provider2.pageNumber, provider2.pageSize);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (provider.isLoading == false) {
          parameters.pageNumber =
              (int.parse(parameters.pageNumber!) + 1).toString();
          provider.getSearchAnnounces1();
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final evler = context.watch<SearchAnnouncesModel>().data1;
    final provider = context.watch<SearchAnnouncesModel>();
    final provider1 = context.watch<DetailsPageModel>();
    final provider2 = context.watch<FoldersModel>();

    return Padding(
        padding:
            EdgeInsets.fromLTRB(16.w, 0.h, 16.w, provider.hasMore ? 0.h : 16.h),
        child: CustomScrollView(
          controller: controller,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverGrid.builder(
                itemCount: evler.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.55),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15),
                itemBuilder: (context, index) => Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: () {
                          provider1
                              .getdetailspageData(evler[index].id, context)
                              .then(
                                (value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                              index: 1,
                                              secGrid: false,
                                              elanId: evler[index].id,
                                            ))),
                              );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                  color: Color.fromRGBO(233, 233, 233, 1))),
                          child: Column(children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 128.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.r),
                                        topRight: Radius.circular(8.r)),
                                    child: Image.network(
                                      'https://d2jcoi69vojtfw.cloudfront.net/' +
                                          evler[index].cover.toString(),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 128.h,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.r),
                                              topRight: Radius.circular(8.r)),
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
                                        provider2.announceId = evler[index].id;
                                        await provider2
                                            .postAddOrRemoveItemWishlist(
                                                provider2.announceId);
                                        await provider2.getWishlist(
                                            provider2.pageNumber,
                                            provider2.pageSize);
                                        provider2.wishlist!.any((element) =>
                                                provider2.announceId ==
                                                element.id)
                                            ? provider2.wishlistCheck = true
                                            : provider2.wishlistCheck = false;

                                        await dotomodalbottomsheet();
                                      },
                                      child: evler[index].isInAnyFolders
                                          ? SvgPicture.asset(
                                              "assets/images/HeartStraightRed.svg",
                                              width: 30.w,
                                              height: 30.h,
                                            )
                                          : provider2.wishlist == null
                                              ? SvgPicture.asset(
                                                  "assets/images/HeartStraight1.svg",
                                                  width: 30.w,
                                                  height: 30.h,
                                                )
                                              : provider2.wishlist!.any(
                                                      (element) =>
                                                          evler[index].id ==
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
                                      "${evler[index].price} AZN",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "${evler[index].address}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "${evler[index].roomCount} otaqlı - ${evler[index].space} m²",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "Baki " +
                                          provider.formatDateTime(
                                              provider
                                                  .data1[index].announceDate,
                                              "az_AZ"),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w300,
                                          color:
                                              Color.fromRGBO(119, 119, 119, 1)),
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
                        color: Color.fromRGBO(34, 186, 104, 1))),
              ))
          ],
        ));
  }
}

class FilterColumn extends StatefulWidget {
  const FilterColumn({super.key});

  @override
  State<FilterColumn> createState() => _FilterColumnState();
}

class _FilterColumnState extends State<FilterColumn> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<SearchAnnouncesModel>();

    return Theme(
      data: Theme.of(context).copyWith(useMaterial3: false),
      child: Dialog(

          // contentPadding: EdgeInsets.all(15.w),
          backgroundColor: Colors.white,
          // contentPadding: EdgeInsets.all(64.w),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          insetPadding: EdgeInsets.all(16.w),
          child: Padding(
            // color: Colors.white,
            padding: EdgeInsets.all(16.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      "Siralama",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () {
                    parameters.sortType = "1";
                    setState(() {});
                  },
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: Color.fromRGBO(239, 239, 239, 1))),
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
                        parameters.sortType == "1"
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
                    parameters.sortType = "2";
                    setState(() {});
                  },
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: Color.fromRGBO(239, 239, 239, 1))),
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
                        parameters.sortType == "2"
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
                    parameters.sortType = "3";
                    setState(() {});
                  },
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: Color.fromRGBO(239, 239, 239, 1))),
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
                        parameters.sortType == "3"
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
                    parameters.sortType = "4";
                    setState(() {});
                  },
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: Color.fromRGBO(239, 239, 239, 1))),
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
                        parameters.sortType == "4"
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
                    parameters.sortType = "5";
                    setState(() {});
                  },
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: Color.fromRGBO(239, 239, 239, 1))),
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
                        parameters.sortType == "5"
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
                    parameters.sortType = "6";
                    setState(() {});
                  },
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: Color.fromRGBO(239, 239, 239, 1))),
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
                        parameters.sortType == "6"
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
                  onTap: () {
                    Navigator.pop(context);
                    provider.getSearchAnnounces2();
                  },
                  child: Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Color.fromRGBO(34, 186, 104, 1)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
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
          )),
    );
  }
}
