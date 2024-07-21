import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// import 'package:rieltor_ofis/domain/entity/favourites/get_wishlist.dart';
// import 'package:rieltor_ofis/ui/screens/details_page/details_page_model.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_screen.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/to_modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/search/searchannounces/searchannouncesmodel.dart';
import 'package:rieltor_ofis/ui/screens/subscriptions/subscriptions_model.dart';
// import 'package:rieltor_ofis/ui/screens/search/searchannounces/searchannouncesmodel.dart';
// import 'package:rieltor_ofis/ui/screens/search/searchannounces/searchannouncesui.dart';

import '../favourites/folders_model.dart';

modalbottomsheet(
  context1,
) async {
  await showModalBottomSheet(
      context: context1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        bool isLoading = false;
        final provider = context.watch<FoldersModel>();
        return StatefulBuilder(
          builder: (context, setState) => Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
              color: Color.fromRGBO(234, 241, 255, 1),
            ),
            height: 454.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Qovluqlar",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontSize: 16.sp),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final bool? shouldRefresh = await showGeneralDialog(
                          barrierDismissible: true,
                          barrierLabel: "",
                          transitionDuration: Duration(milliseconds: 300),
                          context: context,
                          pageBuilder: (context, animation1, animation2) =>
                              Container(),
                          transitionBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  ScaleTransition(
                            scale: Tween<double>(begin: 0.5, end: 1)
                                .animate(animation),
                            child: FadeTransition(
                                opacity: Tween<double>(begin: 0.5, end: 1)
                                    .animate(animation),
                                child: NameFolder()),
                          ),
                        );
                        provider.errorText = "";
                        provider.setFolderName = '';
                        if (shouldRefresh == true) {
                          provider.errorText = "";
                          provider.setFolderName = '';
                          await provider.getFolders();
                        }
                      },
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(0, 80, 235, 0.1))),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/Folders.svg",
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "Qovluq yarat",
                            style: TextStyle(
                                color: Color.fromRGBO(0, 80, 235, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(41, 114, 253, 0.1),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      highlightColor: Color.fromRGBO(41, 114, 253, 0.1),
                      splashColor: Color.fromRGBO(255, 255, 255, 0.5),
                      onTap: () {
                        provider.wishlistCheck == true
                            ? provider.wishlistCheck = false
                            : provider.wishlistCheck = true;
                        setState(() {});
                      },
                      child: Container(
                        height: 44.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ümumi",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                    fontSize: 16.sp),
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 0.8)),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Eclipse(),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
                Expanded(child: ListViewB()),
                Padding(
                  padding: const EdgeInsets.only(top: 10).h,
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(34, 186, 104, 1),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      highlightColor: Color.fromRGBO(41, 114, 253, 0.1),
                      splashColor: Colors.black.withOpacity(0.1),
                      onTap: () async {
                        isLoading = true;
                        provider.wishlist!.any((element) =>
                                    provider.announceId == element.id) !=
                                provider.wishlistCheck
                            ? await provider.postAddOrRemoveItemWishlist(
                                provider.announceId)
                            : null;
                        await provider.postAddOrRemoveItemFolders(
                            provider.announceId, provider.listId);
                        await provider.getFolders();
                        await provider.getWishlist(
                            provider.pageNumber, provider.pageSize);
                        isLoading = false;
                        if (isLoading == false) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(frommodalbottomsheet(context));
                        }
                      },
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromRGBO(34, 186, 104, 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Əlavə et",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

class Eclipse extends StatelessWidget {
  const Eclipse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoldersModel>();
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 26.h,
          width: 26.w,
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: provider.wishlistCheck == true
                    ? Color.fromRGBO(41, 114, 253, 1)
                    : Color.fromRGBO(51, 51, 51, 0.2),
              ),
              color: Colors.white,
              shape: BoxShape.circle),
        ),
        Container(
          height: 11.h,
          width: 11.w,
          decoration: BoxDecoration(
              color: provider.wishlistCheck == true
                  ? Color.fromRGBO(41, 114, 253, 1)
                  : Color.fromRGBO(51, 51, 51, 0.2),
              shape: BoxShape.circle),
        )
      ],
    );
  }
}

class ListViewB extends StatefulWidget {
  const ListViewB({super.key});

  @override
  State<ListViewB> createState() => _ListViewBState();
}

class _ListViewBState extends State<ListViewB> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoldersModel>();

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: provider.folders!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10).h,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: Colors.white),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(8.r),
              color: Color.fromRGBO(234, 241, 255, 1),
              child: InkWell(
                splashColor: Color.fromRGBO(255, 255, 255, 0.5),
                borderRadius: BorderRadius.circular(8.r),
                highlightColor: Color.fromRGBO(41, 114, 253, 0.1),
                onTap: () {
                  provider.listId.contains(provider.folders![index].listId) ==
                          false
                      ? provider.listId.add(provider.folders![index].listId)
                      : provider.listId.remove(provider.folders![index].listId);

                  setState(() {});
                  print(provider.listId);
                },
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: provider.listId.contains(
                                      provider.folders![index].listId) ==
                                  true
                              ? Color.fromRGBO(41, 114, 253, 0.4)
                              : Colors.white),
                      borderRadius: BorderRadius.circular(8.r)),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${provider.folders![index].listName}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: provider.listId
                                      .contains(provider.folders![index].listId)
                                  ? Color.fromRGBO(41, 114, 253, 0.6)
                                  : Colors.black,
                              fontSize: 14.sp),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${provider.folders![index].announceCount} elan",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(51, 51, 51, 0.8)),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 26.h,
                                  width: 26.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: provider.listId.contains(
                                                  provider
                                                      .folders![index].listId)
                                              ? Color.fromRGBO(41, 114, 253, 1)
                                              : Color.fromRGBO(
                                                  51, 51, 51, 0.2)),
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                ),
                                Container(
                                  height: 11.h,
                                  width: 11.w,
                                  decoration: BoxDecoration(
                                      color: provider.listId.contains(
                                              provider.folders![index].listId)
                                          ? Color.fromRGBO(41, 114, 253, 1)
                                          : Color.fromRGBO(51, 51, 51, 0.2),
                                      shape: BoxShape.circle),
                                )
                              ],
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
