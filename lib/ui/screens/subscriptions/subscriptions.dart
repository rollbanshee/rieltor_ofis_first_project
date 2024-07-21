import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/domain/entity/subscriptions/save_filter.dart';
import 'package:rieltor_ofis/ui/screens/search/search.dart';
import 'package:rieltor_ofis/ui/screens/search/search_model.dart';
import 'package:rieltor_ofis/ui/screens/subscriptions/subscription_announces.dart';
import 'package:rieltor_ofis/ui/screens/subscriptions/subscriptions_model.dart';

class SubscriotionScreen extends StatefulWidget {
  const SubscriotionScreen({super.key});

  @override
  State<SubscriotionScreen> createState() => _SubscriotionScreenState();
}

class _SubscriotionScreenState extends State<SubscriotionScreen> {
  @override
  void initState() {
    final provider = context.read<SubscriptionModel>();
    provider.getFilters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionModel>();

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AppBar2(),
          provider.filters == null
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(34, 186, 104, 1),
                    ),
                  ),
                )
              : provider.filters!.isEmpty
                  ? CreateSubscription()
                  : SubscriotionListScreen()
        ],
      )),
    );
  }
}

class AppBar2 extends StatelessWidget {
  const AppBar2({super.key});

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
            "Bildirişlər",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(51, 51, 51, 1)),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30).r,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Search(selectWidget: false)));
            },
            child: Ink(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(253, 230, 230, 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: SvgPicture.asset(
                  "assets/images/Plus.svg",
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

class CreateSubscription extends StatelessWidget {
  const CreateSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Siz hech bir elani abune etmirsiz.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15.h,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search(selectWidget: false)));
              },
              child: Ink(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Color.fromRGBO(34, 186, 104, 1)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  child: Text(
                    "Abune ol",
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
    );
  }
}

class AddFilter extends StatefulWidget {
  const AddFilter({super.key});

  @override
  State<AddFilter> createState() => _AddFilterState();
}

class _AddFilterState extends State<AddFilter> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionModel>();
    final provider1 = context.watch<GetAnnounces>();
    return AlertDialog(
      // backgroundColor: Colors.white,
      // contentPadding: EdgeInsets.all(20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Abunenin adi",
            // textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: TextField(
              onChanged: (value) {
                provider.filterName = value;
                provider.setFilterNameCheck();
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
              if (provider.filterName != "" &&
                  !(provider.filters!.any((element) =>
                      element.filterName == provider.filterName))) {
                parameters1.filterName = provider.filterName;
                parameters1.announceCount = provider1.dataCount;
                if (!provider.isLoading) {
                  await provider.postSaveFilter();
                  await provider.getFilters();
                  await Navigator.of(context)
                    ..pop(true);
                }
              }
            },
            child: Ink(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(34, 186, 104, 1),
                    borderRadius: BorderRadius.circular(16.r)),
                padding: EdgeInsets.symmetric(vertical: 17.h),
                width: MediaQuery.of(context).size.width,
                child: provider.isLoading
                    ? Center(
                        child: SizedBox(
                          height: 19.h,
                          width: 19.w,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        "Əlavə et",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Colors.white),
                      )),
          ),
          SizedBox(
            height: 20.h,
          ),
          provider.isLoading
              ? SizedBox.shrink()
              : Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Ink(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(34, 186, 104, 1),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          size: 30.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class SubscriotionListScreen extends StatelessWidget {
  const SubscriotionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionModel>();
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RefreshIndicator(
          color: Color.fromRGBO(34, 186, 104, 1),
          onRefresh: provider.getFilters,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                // physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.filters!.length,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: () {
                            provider.filterId = provider.filters![index].id;
                            provider.listFilterName =
                                provider.filters![index].filterName;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SubscriotionAnnounces()));
                          },
                          child: Ink(
                            padding: EdgeInsets.all(15.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: Color.fromRGBO(233, 233, 233, 1))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  provider.filters![index].filterName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 10.h, top: 5.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.formatDateTime(
                                            provider.filters![index].createdAt,
                                            "az_AZ"),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        "${provider.formatDateTimePoints(provider.filters![index].lastSeen, "az_AZ")} : ${provider.filters![index].totalCountOfNewAnnounce} yeni elan",
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(41, 114, 253, 1),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 1.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Color.fromRGBO(239, 239, 239, 1)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            customBorder: CircleBorder(),
                                            onTap: () {},
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromRGBO(
                                                      0, 220, 194, 0.1)),
                                              padding: EdgeInsets.all(8),
                                              child: SvgPicture.asset(
                                                "assets/images/Timer.svg",
                                                width: 24.w,
                                                height: 24.h,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          InkWell(
                                            customBorder: CircleBorder(),
                                            onTap: () {},
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: false
                                                      ? Color.fromRGBO(
                                                          0, 0, 0, 0.1)
                                                      : Color.fromRGBO(
                                                          81, 19, 183, 0.1)),
                                              padding: EdgeInsets.all(8),
                                              child: SvgPicture.asset(
                                                  "assets/images/BellSimpleSlash.svg",
                                                  width: 24.w,
                                                  height: 24.h,
                                                  color: true
                                                      ? Color.fromRGBO(
                                                          81, 19, 183, 1)
                                                      : null),
                                            ),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        customBorder: CircleBorder(),
                                        onTap: () {
                                          provider.deleteFilter(
                                              provider.filters![index].id);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(
                                                  255, 117, 117, 0.1)),
                                          padding: EdgeInsets.all(8),
                                          child: SvgPicture.asset(
                                            "assets/images/Trash.svg",
                                            width: 24.w,
                                            height: 24.h,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
