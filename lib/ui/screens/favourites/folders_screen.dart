import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page_model.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_model.dart';
import 'package:rieltor_ofis/ui/screens/favourites/single_folder.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/main_screen/to_modal_bottom_sheet.dart';
import 'package:rieltor_ofis/ui/screens/subscriptions/subscriptions.dart';

class MainFoldersScreen extends StatefulWidget {
  const MainFoldersScreen({super.key});

  @override
  State<MainFoldersScreen> createState() => _MainFoldersScreenState();
}

class _MainFoldersScreenState extends State<MainFoldersScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    final provider = context.read<FoldersModel>();
    provider.getFolders();
    provider.getWishlist(provider.pageNumber, provider.pageSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      body: SafeArea(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
        AppBar1(),
        DefaultTabBar(tabController: tabController),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: TabBarViewStl(tabController: tabController),
        )),
      ])),
    );
  }
}

class AppBar1 extends StatelessWidget {
  const AppBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class DefaultTabBar extends StatelessWidget {
  final tabController;
  const DefaultTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: MediaQuery.of(context).size.width,
      child: TabBar(
        // unselectedLabelColor: Colors.black,
        labelColor: Colors.black,
        // physics: NeverScrollableScrollPhysics(),
        // isScrollable: true,
        // indicatorWeight: 1.w,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelStyle:
            TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        // dividerColor: Colors.green,
        // indicator: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8.r), // Creates border
        //     color: Color.fromRGBO(34, 186, 104, 1)),
        // indicatorPadding: EdgeInsets.symmetric(horizontal: 32.w),

        indicatorColor: Color.fromRGBO(34, 186, 104, 1),
        controller: tabController,
        tabs: [
          Tab(
            text: "Qovluqlar",
          ),
          Tab(
            text: "Umumi",
          )
        ],
      ),
    );
  }
}

class TabBarViewStl extends StatelessWidget {
  final tabController;
  const TabBarViewStl({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: TabBarView(
          controller: tabController, children: [Qovluqlar(), Umumi()]),
    );
  }
}

class Qovluqlar extends StatelessWidget {
  const Qovluqlar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoldersModel>();
    return Column(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: provider.folders == null
              ? SizedBox.shrink()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  // physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.folders!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainSingleFolder(
                                      singleFolderName:
                                          provider.folders![index].listName,
                                      singleFolderId:
                                          provider.folders![index].listId)));
                        },
                        child: Ink(
                          padding: EdgeInsets.all(11.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                  color: Color.fromRGBO(239, 239, 239, 1))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${provider.folders![index].listName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: Colors.black),
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    provider.folders![index].announceCount == 0
                                        ? "elan yoxdur"
                                        : "${provider.folders![index].announceCount} elan",
                                    style: TextStyle(
                                      color: Color.fromRGBO(51, 51, 51, 0.6),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/CaretCircleRight.svg",
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: CreateFolder(),
        )
      ],
    );
  }
}

class Umumi extends StatefulWidget {
  const Umumi({super.key});

  @override
  State<Umumi> createState() => _UmumiState();
}

class _UmumiState extends State<Umumi> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoldersModel>();
    final provider1 = context.read<DetailsPageModel>();

    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        // physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        // padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 64),
        itemCount: provider.wishlist!.length,
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
                    .getdetailspageData(provider.wishlist![index].id, context)
                    .then((_) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            index: index,
                            secGrid: false,
                            elanId: provider.wishlist![index].id,
                          ),
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border:
                        Border.all(color: Color.fromRGBO(233, 233, 233, 1))),
                child: Column(children: [
                  Stack(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 128.h,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              topRight: Radius.circular(8.r)),
                          child: Image.network(
                            'https://d2jcoi69vojtfw.cloudfront.net/' +
                                provider.wishlist![index].cover.toString(),
                            errorBuilder: (context, error, stackTrace) =>
                                Text("the image was not uploaded"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                      right: 10.w,
                      top: 10.h,
                      child: GestureDetector(
                          onTap: () async {
                            provider.announceId = provider.wishlist![index].id;
                            await provider.postAddOrRemoveItemWishlist(
                                provider.announceId);
                            await provider.getWishlist(
                                provider.pageNumber, provider.pageSize);
                            provider.wishlist!.any((element) =>
                                    provider.announceId == element.id)
                                ? provider.wishlistCheck = true
                                : provider.wishlistCheck = false;

                            await dotomodalbottomsheet();
                          },
                          child: provider.wishlist == null
                              ? SvgPicture.asset(
                                  "assets/images/HeartStraight1.svg",
                                  width: 30.w,
                                  height: 30.h,
                                )
                              : provider.wishlist!.any((element) =>
                                      provider.wishlist![index].id ==
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
                    ),
                  ]),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "${provider.wishlist![index].price} AZN",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: Colors.black),
                          ),
                          Text(
                            "${provider.wishlist![index].address}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                          Text(
                            "${provider.wishlist![index].roomCount} otaqli ${provider.wishlist![index].space} m²",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                          Text(
                            "Baki " +
                                provider.formatDateTime(
                                    provider.wishlist![index].announceDate,
                                    "az_AZ"),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(119, 119, 119, 1)),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            )));
  }
}

class CreateFolder extends StatelessWidget {
  const CreateFolder({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FoldersModel>();

    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: InkWell(
        // splashColor: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        onTap: () async {
          final bool? shouldRefresh = await showGeneralDialog(
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
                  opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
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
        child: Ink(
            decoration: BoxDecoration(
                color: Color.fromRGBO(34, 186, 104, 1),
                borderRadius: BorderRadius.circular(16.r)),
            padding: EdgeInsets.symmetric(vertical: 17.h),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Yeni qovluq yarat",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Colors.white),
            )),
      ),
    );
  }
}

class NameFolder extends StatefulWidget {
  const NameFolder({super.key});

  @override
  State<NameFolder> createState() => _NameFolderState();
}

class _NameFolderState extends State<NameFolder> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoldersModel>();
    return AlertDialog(
      backgroundColor: Colors.white,
      // contentPadding: EdgeInsets.all(20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Seçilmişlər papkası",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: TextField(
              onChanged: (value) {
                provider.setFolderName = value;
                provider.setNameCheck();
              },
              cursorColor: provider.errorText == ""
                  ? Color.fromRGBO(34, 186, 104, 1)
                  : Colors.red,
              decoration: InputDecoration(
                  errorText:
                      provider.errorText == "" ? null : provider.errorText,
                  hoverColor: provider.errorText == ""
                      ? Color.fromRGBO(34, 186, 104, 1)
                      : Colors.red,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  hintText: "Ad",
                  hintStyle: TextStyle(
                      color: provider.errorText == ""
                          ? Color.fromRGBO(51, 51, 51, 0.7)
                          : Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp),
                  errorStyle: provider.errorText == ""
                      ? null
                      : TextStyle(
                          color: Colors.red,
                          // fontWeight: FontWeight.w500,
                          fontSize: 14.sp),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  )),
            ),
          ),
          InkWell(
            // splashColor: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            onTap: () async {
              if (provider.folders!.any(
                  (element) => element.listName == provider.setFolderName)) {
                provider.errorText = "Bu adda qovluq movcuddur.";
                setState(() {});
              } else if (provider.setFolderName == "") {
                provider.errorText = "Qovluqun adi bosh ola bilmez.";
                setState(() {});
              } else {
                await provider.postCreateFolder(provider.setFolderName);
                await Navigator.of(context)
                  ..pop(true);
              }
            },
            child: Ink(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(34, 186, 104, 1),
                    borderRadius: BorderRadius.circular(16.r)),
                padding: EdgeInsets.symmetric(vertical: 17.h),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Əlavə et",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
