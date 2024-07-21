import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
// import 'package:rieltor_ofis/domain/api_clients/api_client.dart';
import 'package:rieltor_ofis/domain/entity/search/search.dart';
// import 'package:rieltor_ofis/domain/entity/search/searchannounces.dart';
import 'package:rieltor_ofis/ui/screens/search/cities.dart';
import 'package:rieltor_ofis/ui/screens/search/search_model.dart';
import 'package:rieltor_ofis/ui/screens/search/searchannounces/searchannouncesmodel.dart';
import 'package:rieltor_ofis/ui/screens/search/streets.dart';
import 'package:rieltor_ofis/ui/screens/subscriptions/subscriptions.dart';
import 'package:rieltor_ofis/ui/screens/subscriptions/subscriptions_model.dart';
// import 'package:intl/intl.dart';

import 'searchannounces/searchannouncesui.dart';

String city = "Baki";

class Search extends StatefulWidget {
  final bool selectWidget;

  const Search({super.key, required this.selectWidget});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0.h),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16).h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // GestureDetector(
                      // onTap: () {
                      // Navigator.pop(context);
                      // },
                      // child:
                      widget.selectWidget
                          ? Container(
                              height: 40.h,
                              width: 40.h,
                            )
                          : Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(34, 186, 104, 0.1),
                                  shape: BoxShape.circle),
                              child: Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  splashRadius: 0.1.r,
                                  onPressed: () {
                                    parameters.announceType = '2';
                                    parameters.pageNumber = '1';
                                    parameters.kredit = '0';
                                    parameters.document = '0';
                                    parameters.propertyType = '0';
                                    parameters.cityId = '1';
                                    city = "Baki";
                                    parameters.announcer = '0';
                                    provider.controller1.text = "";
                                    provider.controller2.text = "";
                                    provider.controller3.text = "";
                                    provider.controller4.text = "";
                                    parameters.minPrice = '0';
                                    parameters.maxPrice = '2000000000';
                                    parameters.minSpace = '0';
                                    parameters.maxSpace = '100000';
                                    parameters.roomCount.clear();
                                    parameters.metroId.clear();
                                    parameters.markId.clear();
                                    parameters.regionId.clear();
                                    parameters.settlementId.clear();
                                    parameters.isTopFloor = "false";
                                    parameters.noFirstFloor = "false";
                                    parameters.noTopFloor = "false";
                                    parameters.floorCount.clear();
                                    parameters.currentFloor.clear();
                                    Navigator.pop(context);

                                    // setState(() {});
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/images/ArrowLeft.svg",
                                    // color: Colors.transparent,
                                    // fit: BoxFit.scaleDown,
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                ),
                              ),
                            ),
                      widget.selectWidget
                          ? Text(
                              "Axtarış",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18.sp),
                            )
                          : Text(
                              "Abune ol",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18.sp),
                            ),
                      Container(
                        // padding: EdgeInsets.all(5),
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 80, 235, 0.1),
                            shape: BoxShape.circle),
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashRadius: 20.r,
                            onPressed: () {
                              parameters.announceType = '2';
                              parameters.pageNumber = '1';
                              parameters.kredit = '0';
                              parameters.document = '0';
                              parameters.propertyType = '0';
                              parameters.cityId = '1';
                              city = "Baki";
                              parameters.announcer = '0';
                              provider.controller1.text = "";
                              provider.controller2.text = "";
                              provider.controller3.text = "";
                              provider.controller4.text = "";
                              parameters.minPrice = '0';
                              parameters.maxPrice = '2000000000';
                              parameters.minSpace = '0';
                              parameters.maxSpace = '100000';
                              parameters.roomCount.clear();
                              parameters.metroId.clear();
                              parameters.markId.clear();
                              parameters.regionId.clear();
                              parameters.settlementId.clear();
                              parameters.isTopFloor = "false";
                              parameters.noFirstFloor = "false";
                              parameters.noTopFloor = "false";
                              parameters.floorCount.clear();
                              parameters.currentFloor.clear();
                              setState(() {});
                              provider.getCount();
                            },
                            icon: SvgPicture.asset(
                              "assets/images/Group33639.svg",
                              // fit: BoxFit.scaleDown,
                              width: 17.w,
                              height: 17.h,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SellRent(),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
                        child: Container(
                          width: 273.w,
                          height: 1.h,
                          color: Color.fromRGBO(233, 233, 233, 1),
                        ),
                      ),
                      City(),
                      SizedBox(
                        height: 8.h,
                      ),
                      CitiesButton(),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
                        child: Container(
                          width: 273.w,
                          height: 1.h,
                          color: Color.fromRGBO(233, 233, 233, 1),
                        ),
                      ),
                      ListOfBuildings(
                        callback: this.callback,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                        child: Container(
                          width: 273.w,
                          height: 1.h,
                          color: Color.fromRGBO(233, 233, 233, 1),
                        ),
                      ),
                      if (parameters.propertyType == "1" ||
                          parameters.propertyType == "2" ||
                          parameters.propertyType == "6") ...[
                        Floor(),
                        Padding(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: Container(
                            width: 273.w,
                            height: 1.h,
                            color: Color.fromRGBO(233, 233, 233, 1),
                          ),
                        ),
                        FloorCount(),
                        Padding(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: Container(
                            width: 273.w,
                            height: 1.h,
                            color: Color.fromRGBO(233, 233, 233, 1),
                          ),
                        ),
                        NoFirstFloor(),
                        SizedBox(
                          height: 12.h,
                        ),
                        NoTopFloor(),
                        SizedBox(
                          height: 12.h,
                        ),
                        IsTopFloor(),
                        Padding(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: Container(
                            width: 273.w,
                            height: 1.h,
                            color: Color.fromRGBO(233, 233, 233, 1),
                          ),
                        )
                      ] else
                        SizedBox.shrink(),
                      RoomsCount(),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                        child: Container(
                          width: 273.w,
                          height: 1.h,
                          color: Color.fromRGBO(233, 233, 233, 1),
                        ),
                      ),
                      SquareMinMax(),
                      Padding(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: Container(
                            width: 273.w,
                            height: 1.h,
                            color: Color.fromRGBO(233, 233, 233, 1),
                          )),
                      PriceMinMax(),
                      Padding(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: Container(
                            width: 273.w,
                            height: 1.h,
                            color: Color.fromRGBO(233, 233, 233, 1),
                          )),
                      Cixarish(),
                      SizedBox(
                        height: 12.h,
                      ),
                      Ipoteka(),
                      Padding(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: Container(
                            width: 273.w,
                            height: 1.h,
                            color: Color.fromRGBO(233, 233, 233, 1),
                          )),
                      EmlakSahibinden(),
                    ],
                  ),
                ),
              )),
              widget.selectWidget
                  ? KnopkaPodtverjdeniya()
                  : KnopkaPodtverjdeniyaNotifications()
            ],
          ),
        ),
      ),
    );
  }
}

// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

class SellRent extends StatefulWidget {
  const SellRent({super.key});

  @override
  State<SellRent> createState() => _SellRentState();
}

class _SellRentState extends State<SellRent> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Material(
            borderRadius: BorderRadius.circular(8.r),
            color: parameters.announceType == "2"
                ? Color.fromRGBO(34, 186, 104, 1)
                : Colors.white,
            // elevation: 0,
            child: InkWell(
              onTap: () {
                parameters.announceType = "2";
                print(parameters.announceType);
                setState(() {});
                provider.getCount();
              },
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                child: Text(
                  "SATILIR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: parameters.announceType == "2"
                          ? Colors.white
                          : Colors.black),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: parameters.announceType == "2"
                            ? Colors.transparent
                            : Color.fromRGBO(233, 233, 233, 1),
                        width: 1.sp),
                    borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Material(
            borderRadius: BorderRadius.circular(8.r),
            color: parameters.announceType == "1"
                ? Color.fromRGBO(34, 186, 104, 1)
                : Colors.white,
            // elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                parameters.announceType = "1";
                print(parameters.announceType);
                setState(() {});
                provider.getCount();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                child: Text(
                  "KİRAYƏ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: parameters.announceType == "1"
                          ? Colors.white
                          : Colors.black),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: parameters.announceType == "1"
                            ? Colors.transparent
                            : Color.fromRGBO(233, 233, 233, 1),
                        width: 1.sp),
                    borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

class City extends StatefulWidget {
  const City({super.key});

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Text(
            "Şəhər :",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Colors.black),
          ),
          SizedBox(
            width: 16.w,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Cities1()))
                  .then((value) {
                setState(() {});
              });
            },
            child: Row(
              children: [
                Ink(
                  child: Text(
                    city,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: Color.fromRGBO(41, 114, 253, 1)),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                SvgPicture.asset(
                  "assets/images/CaretRight.svg",
                  width: 16.w,
                  height: 16.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CitiesButton extends StatefulWidget {
  const CitiesButton({super.key});

  @override
  State<CitiesButton> createState() => _CitiesButtonState();
}

class _CitiesButtonState extends State<CitiesButton> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return InkWell(
      borderRadius: BorderRadius.circular(9.r),
      onTap: () {
        Navigator.push(
                context, MaterialPageRoute(builder: (context) => Streets()))
            .then((value) {
          setState(() {});
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.r),
            border: Border.all(
                width: 1.w, color: Color.fromRGBO(233, 233, 233, 1))),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rayon, metro, nişangah",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Color.fromRGBO(119, 119, 119, 1)),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child:
                        SvgPicture.asset("assets/images/CaretCircleRight.svg"))
              ],
            )),
      ),
    );
  }
}

// ignore: must_be_immutable
class ListOfBuildings extends StatefulWidget {
  Function callback;
  ListOfBuildings({super.key, required this.callback});

  @override
  State<ListOfBuildings> createState() => _ListOfBuildingsState();
}

List buildings = [
  "Yeni tikili",
  "Kohne tikili",
  "Heyet evi",
  "Bag evi",
  "Villa",
  "Ofis",
  "Obyekt",
  "Magaza",
  "Torpaq",
  "Qarajlar"
];

class _ListOfBuildingsState extends State<ListOfBuildings> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return SizedBox(
      height: 56.h,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
        ),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: buildings.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () {
                parameters.propertyType == (index + 1).toString()
                    ? parameters.propertyType = "0"
                    : parameters.propertyType = (index + 1).toString();
                widget.callback();
                provider.getCount();

                print(parameters.propertyType);
              },
              child: Ink(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                decoration: BoxDecoration(
                    color: parameters.propertyType == "${index + 1}"
                        ? Color.fromRGBO(34, 186, 104, 1)
                        : Colors.white,
                    border: Border.all(color: Color.fromRGBO(233, 233, 233, 1)),
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r)),
                child: Text(
                  buildings[index],
                  style: TextStyle(
                      color: parameters.propertyType == "${index + 1}"
                          ? Colors.white
                          : Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Floor extends StatefulWidget {
  const Floor({super.key});

  @override
  State<Floor> createState() => _FloorState();
}

class _FloorState extends State<Floor> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GetAnnounces>();
    return Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mertebe",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
              height: 56.h,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: provider.floor.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromRGBO(233, 233, 233, 1)),
                      shape: BoxShape.circle,
                      color: parameters.currentFloor.contains("${index + 1}")
                          ? Color.fromRGBO(34, 186, 104, 1)
                          : Colors.white,
                    ),
                    height: 40.h,
                    width: 40.w,
                    child: FloatingActionButton(
                        heroTag: "awds",
                        elevation: 0,
                        highlightElevation: 0,
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          parameters.currentFloor.contains("${index + 1}")
                              ? parameters.currentFloor.remove("${index + 1}")
                              : parameters.currentFloor.add("${index + 1}");
                          setState(() {});
                          provider.getCount();
                        },
                        child: Text(
                          provider.floor[index].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: parameters.currentFloor
                                      .contains("${index + 1}")
                                  ? Colors.white
                                  : Colors.black),
                        )),
                  ),
                ),
              ))
        ]);
  }
}

class FloorCount extends StatefulWidget {
  const FloorCount({super.key});

  @override
  State<FloorCount> createState() => _FloorCountState();
}

class _FloorCountState extends State<FloorCount> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GetAnnounces>();
    return Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mertebe sayi",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
              height: 56.h,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: provider.floor.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromRGBO(233, 233, 233, 1)),
                      shape: BoxShape.circle,
                      color: parameters.floorCount.contains("${index + 1}")
                          ? Color.fromRGBO(34, 186, 104, 1)
                          : Colors.white,
                    ),
                    height: 40.h,
                    width: 40.w,
                    child: FloatingActionButton(
                        heroTag: "awds",
                        elevation: 0,
                        highlightElevation: 0,
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          parameters.floorCount.contains("${index + 1}")
                              ? parameters.floorCount.remove("${index + 1}")
                              : parameters.floorCount.add("${index + 1}");
                          setState(() {});
                          provider.getCount();
                        },
                        child: Text(
                          provider.floor[index].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color:
                                  parameters.floorCount.contains("${index + 1}")
                                      ? Colors.white
                                      : Colors.black),
                        )),
                  ),
                ),
              ))
        ]);
  }
}

class NoFirstFloor extends StatefulWidget {
  const NoFirstFloor({super.key});

  @override
  State<NoFirstFloor> createState() => _NoFirstFloorState();
}

class _NoFirstFloorState extends State<NoFirstFloor> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade300)),
        // height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "1-ci mertebe olmasin",
              style: TextStyle(
                  color: parameters.noFirstFloor == "true"
                      ? Color.fromRGBO(34, 186, 104, 1)
                      : Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            CupertinoSwitch(
              value: bool.parse(parameters.noFirstFloor!),
              onChanged: (value) {
                setState(() {
                  value
                      ? parameters.noFirstFloor = "true"
                      : parameters.noFirstFloor = "false";
                });
                provider.getCount();
              },
            ),
          ],
        ));
  }
}

class IsTopFloor extends StatefulWidget {
  const IsTopFloor({super.key});

  @override
  State<IsTopFloor> createState() => _IsTopFloorState();
}

class _IsTopFloorState extends State<IsTopFloor> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade300)),
        // height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "En ust mertebe",
              style: TextStyle(
                  color: parameters.isTopFloor == "true"
                      ? Color.fromRGBO(34, 186, 104, 1)
                      : Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            CupertinoSwitch(
              value: bool.parse(parameters.isTopFloor!),
              onChanged: (value) {
                setState(() {
                  value
                      ? parameters.isTopFloor = "true"
                      : parameters.isTopFloor = "false";
                });
                provider.getCount();
              },
            ),
          ],
        ));
  }
}

class NoTopFloor extends StatefulWidget {
  const NoTopFloor({super.key});

  @override
  State<NoTopFloor> createState() => _NoTopFloorState();
}

class _NoTopFloorState extends State<NoTopFloor> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade300)),
        // height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "En ust mertebe olmasin",
              style: TextStyle(
                  color: parameters.noTopFloor == "true"
                      ? Color.fromRGBO(34, 186, 104, 1)
                      : Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            CupertinoSwitch(
              value: bool.parse(parameters.noTopFloor!),
              onChanged: (value) {
                setState(() {
                  value
                      ? parameters.noTopFloor = "true"
                      : parameters.noTopFloor = "false";
                });
                provider.getCount();
              },
            ),
          ],
        ));
  }
}

class RoomsCount extends StatefulWidget {
  const RoomsCount({super.key});

  @override
  State<RoomsCount> createState() => _RoomsCountState();
}

class _RoomsCountState extends State<RoomsCount> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: parameters.roomCount.contains("1")
                  ? Color.fromRGBO(34, 186, 104, 1)
                  : Colors.white,
              border: Border.all(color: Color.fromRGBO(233, 233, 233, 1))),
          height: 40.h,
          width: 40.w,
          // padding: EdgeInsets.all(8),
          child: FloatingActionButton(
              heroTag: "awds",
              elevation: 0,
              highlightElevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                parameters.roomCount.contains("1")
                    ? parameters.roomCount.remove("1")
                    : parameters.roomCount.add("1");
                print(parameters.roomCount);
                setState(() {});
                provider.getCount();
              },
              child: Text(
                "1",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: parameters.roomCount.contains("1")
                        ? Colors.white
                        : Colors.black),
              )),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: parameters.roomCount.contains("2")
                  ? Color.fromRGBO(34, 186, 104, 1)
                  : Colors.white,
              border: Border.all(color: Color.fromRGBO(233, 233, 233, 1))),
          height: 40.h,
          width: 40.w,
          child: FloatingActionButton(
              heroTag: "awd",
              elevation: 0,
              highlightElevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                parameters.roomCount.contains("2")
                    ? parameters.roomCount.remove("2")
                    : parameters.roomCount.add("2");
                print(parameters.roomCount);
                setState(() {});
                provider.getCount();
              },
              child: Text(
                "2",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: parameters.roomCount.contains("2")
                        ? Colors.white
                        : Colors.black),
              )),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: parameters.roomCount.contains("3")
                  ? Color.fromRGBO(34, 186, 104, 1)
                  : Colors.white,
              border: Border.all(color: Color.fromRGBO(233, 233, 233, 1))),
          height: 40.h,
          width: 40.w,
          child: FloatingActionButton(
              heroTag: "aw",
              elevation: 0,
              highlightElevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                parameters.roomCount.contains("3")
                    ? parameters.roomCount.remove("3")
                    : parameters.roomCount.add("3");
                print(parameters.roomCount);
                setState(() {});
                provider.getCount();
              },
              child: Text(
                "3",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: parameters.roomCount.contains("3")
                        ? Colors.white
                        : Colors.black),
              )),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: parameters.roomCount.contains("4")
                  ? Color.fromRGBO(34, 186, 104, 1)
                  : Colors.white,
              border: Border.all(color: Color.fromRGBO(233, 233, 233, 1))),
          height: 40.h,
          width: 40.w,
          child: FloatingActionButton(
              heroTag: "a",
              elevation: 0,
              highlightElevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                parameters.roomCount.contains("4")
                    ? parameters.roomCount.remove("4")
                    : parameters.roomCount.add("4");
                print(parameters.roomCount);
                setState(() {});
                provider.getCount();
              },
              child: Text(
                "4",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: parameters.roomCount.contains("4")
                        ? Colors.white
                        : Colors.black),
              )),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              // shape: BoxShape.circle,
              // color: parameters.roomCount.contains("5")
              //     ? Color.fromRGBO(34, 186, 104, 1)
              //     : Colors.white,
              border: Border.all(color: Color.fromRGBO(233, 233, 233, 1))),
          height: 40.h,

          // width: 36.w,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // onPrimary: Colors.transparent,
                  // shadowColor: Colors.white,
                  // primary: Colors.white,
                  // onPrimary: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  backgroundColor: parameters.roomCount.contains("5")
                      ? Color.fromRGBO(34, 186, 104, 1)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r))),
              // elevation: 0,
              // highlightElevation: /0,
              // backgroundColor: Colors.white,
              onPressed: () {
                parameters.roomCount.contains("5")
                    ? parameters.roomCount.remove("5")
                    : parameters.roomCount.add("5");
                print(parameters.roomCount);
                setState(() {});
                provider.getCount();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 43.w),
                child: Text(
                  "5+ otaqlı",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: parameters.roomCount.contains("5")
                          ? Colors.white
                          : Colors.black),
                ),
              )),
        ),
      ],
    );
  }
}

class SquareMinMax extends StatefulWidget {
  const SquareMinMax({super.key});
  @override
  State<SquareMinMax> createState() => _SquareMinMaxState();
}

class _SquareMinMaxState extends State<SquareMinMax> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sahə, m²",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: provider.controller1,
                onSubmitted: (value) {
                  provider.checkSymbols(provider.controller1);
                  provider.controller1.text == ""
                      ? parameters.minSpace = "0"
                      : parameters.minSpace = provider.controller1.text;
                  // print(value);
                  print(parameters.minSpace);
                  provider.getCount();
                },
                keyboardType: TextInputType.number,
                cursorColor: Color.fromRGBO(34, 186, 104, 1),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14.r),
                  hintText: "Min",
                  // iconColor: Colors.green,
                  hoverColor: Color.fromRGBO(34, 186, 104, 1),

                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Color.fromRGBO(51, 51, 51, 0.7)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.w)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.w)),
                  isCollapsed: true,
                ),
              )),
              SizedBox(
                width: 25.w,
              ),
              Expanded(
                  child: TextField(
                keyboardType: TextInputType.number,
                controller: provider.controller2,
                onSubmitted: (value) {
                  provider.checkSymbols(provider.controller2);
                  provider.controller2.text == ""
                      ? parameters.maxSpace = "100000"
                      : parameters.maxSpace = provider.controller2.text;

                  print(parameters.maxSpace);
                  provider.getCount();
                },
                cursorColor: Color.fromRGBO(34, 186, 104, 1),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14.r),
                  hintText: "Max",
                  // iconColor: Colors.green,
                  hoverColor: Color.fromRGBO(34, 186, 104, 1),

                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Color.fromRGBO(51, 51, 51, 0.7)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.w)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.w)),
                  isCollapsed: true,
                ),
              ))
            ],
          )
        ]);
  }
}

class PriceMinMax extends StatefulWidget {
  const PriceMinMax({super.key});

  @override
  State<PriceMinMax> createState() => _PriceMinMaxState();
}

class _PriceMinMaxState extends State<PriceMinMax> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Qiymət, AZN",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                keyboardType: TextInputType.number,
                cursorColor: Color.fromRGBO(34, 186, 104, 1),
                controller: provider.controller3,
                onSubmitted: (value) {
                  provider.checkSymbols(provider.controller3);
                  provider.controller3.text == ""
                      ? parameters.minPrice = "0"
                      : parameters.minPrice = provider.controller3.text;
                  print(parameters.minPrice);
                  provider.getCount();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14.r),
                  hintText: "Min",
                  // iconColor: Colors.green,
                  hoverColor: Color.fromRGBO(34, 186, 104, 1),

                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Color.fromRGBO(51, 51, 51, 0.7)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.w)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.w)),
                  isCollapsed: true,
                ),
              )),
              SizedBox(
                width: 25.w,
              ),
              Expanded(
                  child: TextField(
                controller: provider.controller4,
                onSubmitted: (value) {
                  provider.checkSymbols(provider.controller4);
                  provider.controller4.text == ""
                      ? parameters.maxPrice = "2000000000"
                      : parameters.maxPrice = provider.controller4.text;
                  print(parameters.maxPrice);
                  provider.getCount();
                },
                keyboardType: TextInputType.number,
                cursorColor: Color.fromRGBO(34, 186, 104, 1),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14.r),
                  hintText: "Max",
                  // iconColor: Colors.green,
                  hoverColor: Color.fromRGBO(34, 186, 104, 1),

                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Color.fromRGBO(51, 51, 51, 0.7)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.w)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.w)),
                  isCollapsed: true,
                ),
              ))
            ],
          )
        ]);
  }
}

class Cixarish extends StatefulWidget {
  const Cixarish({super.key});

  @override
  State<Cixarish> createState() => _CixarishState();
}

class _CixarishState extends State<Cixarish> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade300)),
        // height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Çıxarış var",
              style: TextStyle(
                  color: parameters.document == "1"
                      ? Color.fromRGBO(34, 186, 104, 1)
                      : Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            CupertinoSwitch(
              value: parameters.document == "1" ? true : false,
              onChanged: (value) {
                setState(() {
                  value ? parameters.document = "1" : parameters.document = "0";

                  print(parameters.document);
                  provider.getCount();
                });
              },
            ),
          ],
        ));
  }
}

class Ipoteka extends StatefulWidget {
  const Ipoteka({super.key});

  @override
  State<Ipoteka> createState() => _IpotekaState();
}

class _IpotekaState extends State<Ipoteka> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade300)),
        // height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ipoteka var",
              style: TextStyle(
                  color: parameters.kredit == "1"
                      ? Color.fromRGBO(34, 186, 104, 1)
                      : Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            CupertinoSwitch(
              value: parameters.kredit == "1" ? true : false,
              onChanged: (value) {
                setState(() {
                  value ? parameters.kredit = "1" : parameters.kredit = "0";
                });
                provider.getCount();
              },
            ),
          ],
        ));
  }
}

class EmlakSahibinden extends StatefulWidget {
  const EmlakSahibinden({super.key});

  @override
  State<EmlakSahibinden> createState() => _EmlakSahibindenState();
}

class _EmlakSahibindenState extends State<EmlakSahibinden> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade300)),
        // height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Emlak sahibinden",
                style: TextStyle(
                    color: parameters.announcer == "1"
                        ? Color.fromRGBO(34, 186, 104, 1)
                        : Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400)),
            CupertinoSwitch(
              value: parameters.announcer == "1" ? true : false,
              onChanged: (value) {
                setState(() {
                  value
                      ? parameters.announcer = "1"
                      : parameters.announcer = "0";
                });
                provider.getCount();
              },
            ),
          ],
        ));
  }
}

class KnopkaPodtverjdeniya extends StatefulWidget {
  const KnopkaPodtverjdeniya({super.key});

  @override
  State<KnopkaPodtverjdeniya> createState() => _KnopkaPodtverjdeniyaState();
}

class _KnopkaPodtverjdeniyaState extends State<KnopkaPodtverjdeniya> {
  bool _isDisposed = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _initData();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  _initData() async {
    final provider = context.read<GetAnnounces>();
    await provider.getCount();

    if (!_isDisposed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GetAnnounces>();
    final provider1 = context.read<SearchAnnouncesModel>();

    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: InkWell(
        // splashColor: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          provider1.getSearchAnnounces(context).then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchAnnouncesMain(),
              )));
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
                    "${provider.formatter.format(provider.dataCount)} elan goster",
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

class KnopkaPodtverjdeniyaNotifications extends StatefulWidget {
  const KnopkaPodtverjdeniyaNotifications({super.key});

  @override
  State<KnopkaPodtverjdeniyaNotifications> createState() =>
      _KnopkaPodtverjdeniyaNotificationsState();
}

class _KnopkaPodtverjdeniyaNotificationsState
    extends State<KnopkaPodtverjdeniyaNotifications> {
  bool _isDisposed = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _initData();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  _initData() async {
    final provider = context.read<GetAnnounces>();
    await provider.getCount();

    if (!_isDisposed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionModel>();
    final provider1 = context.watch<GetAnnounces>();
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: InkWell(
        // splashColor: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        onTap: () async {
          final bool? shouldRefresh = await showGeneralDialog(
            barrierDismissible: false,
            barrierLabel: "",
            transitionDuration: Duration(milliseconds: 600),
            context: context,
            pageBuilder: (context, animation1, animation2) => Container(),
            transitionBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              ).drive(Tween<Offset>(begin: Offset(0, 1.0), end: Offset.zero)),
              child: FadeTransition(
                  opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
                  child: AddFilter()),
            ),
          );
          provider.errorText = "";
          provider.filterName = "";
          if (shouldRefresh == true) {
            provider.errorText = "";
            provider.filterName = "";
            Navigator.pop(context);
          }
        },
        child: Ink(
            decoration: BoxDecoration(
                color: Color.fromRGBO(34, 186, 104, 1),
                borderRadius: BorderRadius.circular(16.r)),
            padding: EdgeInsets.symmetric(vertical: 17.h),
            width: MediaQuery.of(context).size.width,
            child: provider1.isLoading
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
                    "Elave et: ${provider1.formatter.format(provider1.dataCount)}",
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
