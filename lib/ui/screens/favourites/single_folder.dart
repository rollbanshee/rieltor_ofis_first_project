import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page_model.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_model.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/to_modal_bottom_sheet.dart';

class MainSingleFolder extends StatefulWidget {
  final String? singleFolderName;
  final int? singleFolderId;

  const MainSingleFolder(
      {super.key,
      required this.singleFolderName,
      required this.singleFolderId});

  @override
  State<MainSingleFolder> createState() => _MainSingleFolderState();
}

class _MainSingleFolderState extends State<MainSingleFolder> {
  @override
  void initState() {
    final provider = context.read<FoldersModel>();
    provider.getWishlist(provider.pageNumber, provider.pageSize);
    provider.getSingleFolder(
        widget.singleFolderId, provider.pageNumber, provider.pageSize);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AppBarSingleFolder(
            singleFolderName: widget.singleFolderName,
            singleFolderId: widget.singleFolderId,
          ),
          GridViewSingleFolder(singleFolderId: widget.singleFolderId)
        ],
      )),
    );
  }
}

class AppBarSingleFolder extends StatelessWidget {
  final String? singleFolderName;
  final int? singleFolderId;

  const AppBarSingleFolder(
      {super.key,
      required this.singleFolderName,
      required this.singleFolderId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoldersModel>();
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
                  provider.singleFoldersAnnounces = null;
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  provider.getFolders();
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
            singleFolderName!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(51, 51, 51, 1)),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30).r,
            onTap: () {
              provider.singleFoldersAnnounces = null;
              Navigator.pop(context);
              provider
                  .deleteFolder(singleFolderId)
                  .then((value) => provider.getFolders());
            },
            child: Ink(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 117, 117, 0.1),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: SvgPicture.asset(
                  "assets/images/Trash.svg",
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

class GridViewSingleFolder extends StatelessWidget {
  final int? singleFolderId;

  const GridViewSingleFolder({super.key, required this.singleFolderId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoldersModel>();
    final provider1 = context.read<DetailsPageModel>();

    return provider.singleFoldersAnnounces == null
        ? Expanded(
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            )),
          )
        : provider.singleFoldersAnnounces!.isEmpty
            ? Expanded(
                child: Center(
                    child: Text(
                  "Elan yoxdur.",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                  //         CupertinoActivityIndicator(
                  //   radius: 15,
                  // )
                )),
              )
            : Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: provider.singleFoldersAnnounces!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.55),
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15),
                      itemBuilder: (context, index) => Material(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8.r),
                              onTap: () async {
                                provider.isInAnyFoldersCheck = true;
                                await provider1
                                    .getdetailspageData(
                                        provider
                                            .singleFoldersAnnounces![index].id,
                                        context)
                                    .then((_) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsPage(
                                            index: index,
                                            secGrid: false,
                                            elanId: provider
                                                .singleFoldersAnnounces![index]
                                                .id,
                                          ),
                                        )));
                                provider.getSingleFolder(singleFolderId,
                                    provider.pageNumber, provider.pageSize);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(233, 233, 233, 1))),
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
                                                  provider
                                                      .singleFoldersAnnounces![
                                                          index]
                                                      .cover
                                                      .toString(),
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Text(
                                                      "the image was not uploaded"),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Positioned(
                                        right: 10.w,
                                        top: 10.h,
                                        child: GestureDetector(
                                            onTap: () async {
                                              provider.announceId = provider
                                                  .singleFoldersAnnounces![
                                                      index]
                                                  .id;
                                              await provider
                                                  .postAddOrRemoveItemWishlist(
                                                      provider.announceId);
                                              await provider.getWishlist(
                                                  provider.pageNumber,
                                                  provider.pageSize);
                                              provider.wishlist!.any(
                                                      (element) =>
                                                          provider.announceId ==
                                                          element.id)
                                                  ? provider.wishlistCheck =
                                                      true
                                                  : provider.wishlistCheck =
                                                      false;
                                              await dotomodalbottomsheet();
                                              provider.getSingleFolder(
                                                  singleFolderId,
                                                  provider.pageNumber,
                                                  provider.pageSize);
                                            },
                                            child: provider.wishlist == null
                                                ? SvgPicture.asset(
                                                    "assets/images/HeartStraight1.svg",
                                                    width: 30.w,
                                                    height: 30.h,
                                                  )
                                                : provider.wishlist!.any(
                                                        (element) =>
                                                            provider
                                                                .singleFoldersAnnounces![
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
                                            "${provider.singleFoldersAnnounces![index].price} AZN",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.sp,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "${provider.singleFoldersAnnounces![index].address}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp),
                                          ),
                                          Text(
                                            "${provider.singleFoldersAnnounces![index].roomCount} otaqlı - ${provider.singleFoldersAnnounces![index].space} m²",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp),
                                          ),
                                          Text(
                                            "Baki " +
                                                provider.formatDateTime(
                                                    provider
                                                        .singleFoldersAnnounces![
                                                            index]
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
                ),
              );
  }
}
