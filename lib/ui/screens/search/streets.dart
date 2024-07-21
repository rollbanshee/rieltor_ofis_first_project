import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/domain/api_clients/api_client.dart';
import 'package:rieltor_ofis/domain/entity/search/search.dart';
import 'package:rieltor_ofis/ui/screens/search/search_model.dart';

class Streets extends StatefulWidget {
  const Streets({super.key});

  @override
  State<Streets> createState() => _StreetsState();
}

class _StreetsState extends State<Streets> {
  List rayons = [];
  List metros = [];
  List marks = [];
  Future<List> getRegions() async {
    List rayons = await ApiClient().getRegions();
    this.rayons = rayons;
    List metros = await ApiClient().getMetro();
    this.metros = metros;
    List marks = await ApiClient().getMarks();
    this.marks = marks;
    return rayons;
  }

  bool check0 = true;
  bool check1 = false;
  bool check2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0.h),
                child: Column(
                  children: [
                    AppBar(),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              check0 = true;
                              check1 = false;
                              check2 = false;
                              setState(() {});
                            },
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                bottomLeft: Radius.circular(8.r)),
                            child: Ink(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                  color: check0
                                      ? Color.fromRGBO(34, 186, 104, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.r),
                                      bottomLeft: Radius.circular(8.r)),
                                  border: Border.all(
                                      color: check0
                                          ? Color.fromRGBO(34, 186, 104, 1)
                                          : Colors.white,
                                      width: 1.w)),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Rayon",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        check0 ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              check0 = false;
                              check1 = true;
                              check2 = false;
                              setState(() {});
                            },
                            child: Ink(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                  color: check1
                                      ? Color.fromRGBO(34, 186, 104, 1)
                                      : Colors.white,
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                        color: check1
                                            ? Color.fromRGBO(34, 186, 104, 1)
                                            : Colors.white,
                                        width: 1.w),
                                  )),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Metro",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        check1 ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              check0 = false;
                              check1 = false;
                              check2 = true;
                              setState(() {});
                            },
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r)),
                            child: Ink(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                  color: check2
                                      ? Color.fromRGBO(34, 186, 104, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8.r),
                                      bottomRight: Radius.circular(8.r)),
                                  border: Border.all(
                                      color: check2
                                          ? Color.fromRGBO(34, 186, 104, 1)
                                          : Colors.white,
                                      width: 1.w)),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Nişangah",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        check2 ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                        child: FutureBuilder(
                      future: getRegions(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (check0 == true) {
                            // setState(() {});
                            return RayonList(data: rayons);
                          } else if (check1 == true) {
                            // setState(() {});
                            return MetroList(data1: metros);
                          } else if (check2 == true) {
                            return MarksList(data2: marks);
                          } else {
                            return Container();
                          }
                          // return MetroList(
                          //   data1: metros,
                          // );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )),
                    // KnopkaPodtverjdeniya(),
                  ],
                ))));
  }
}

class AppBar extends StatefulWidget {
  const AppBar({super.key});

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 16).h,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Text(
                "Nişangahlar",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              ),
            ),
            SizedBox(
              width: 56.w,
            ),
          ],
        ),
      ),
    );
  }
}

class RayonList extends StatefulWidget {
  final List<dynamic> data;

  const RayonList({Key? key, required this.data});

  @override
  State<RayonList> createState() => _RayonListState();
}

class _RayonListState extends State<RayonList> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: widget.data.length,
      shrinkWrap: true,
      itemBuilder: (context, index1) => Column(children: [
        Material(
          borderRadius: BorderRadius.circular(8.r),
          color: Color.fromRGBO(234, 241, 255, 1),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              parameters.regionId
                      .contains(widget.data[index1].regionId.toString())
                  ? parameters.regionId
                      .remove(widget.data[index1].regionId.toString())
                  : parameters.regionId
                      .add(widget.data[index1].regionId.toString());

              setState(() {});
              print(parameters.regionId);
              print(parameters.settlementId);
              provider.getCount();

              // widget.checklist1[index1] = !widget.checklist1[index1];
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data[index1].regionName,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  parameters.regionId
                          .contains(widget.data[index1].regionId.toString())
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
        ),
        ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.data[index1].settlementDto.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                parameters.settlementId.contains(widget
                        .data[index1].settlementDto[index].settlementId
                        .toString())
                    ? parameters.settlementId.remove(widget
                        .data[index1].settlementDto[index].settlementId
                        .toString())
                    : parameters.settlementId.add(widget
                        .data[index1].settlementDto[index].settlementId
                        .toString());
                setState(() {});
                print(parameters.regionId);
                print(parameters.settlementId);
                provider.getCount();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(239, 239, 239, 1), width: 1.w),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data[index1].settlementDto[index].settlementName,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: parameters.settlementId.contains(widget
                                  .data[index1]
                                  .settlementDto[index]
                                  .settlementId
                                  .toString())
                              ? Color.fromRGBO(41, 114, 253, 1)
                              : Colors.black),
                    ),
                    parameters.settlementId.contains(widget
                            .data[index1].settlementDto[index].settlementId
                            .toString())
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
          ),
        )
      ]),
    );
  }
}

class MetroList extends StatefulWidget {
  List<dynamic> data1 = [];
  MetroList({super.key, required this.data1});

  @override
  State<MetroList> createState() => _MetroListState();
}

class _MetroListState extends State<MetroList> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();

    return ListView.builder(
      // padding: EdgeInsets.symmetric(vertical: 10.h),
      physics: BouncingScrollPhysics(),
      itemCount: widget.data1.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: () {
            parameters.metroId.contains(widget.data1[index].id.toString())
                ? parameters.metroId.remove(widget.data1[index].id.toString())
                : parameters.metroId.add(widget.data1[index].id.toString());
            print(parameters.metroId);
            setState(() {});
            provider.getCount();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(239, 239, 239, 1), width: 1.w),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.data1[index].name,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: parameters.metroId
                                .contains(widget.data1[index].id.toString())
                            ? Color.fromRGBO(41, 114, 253, 1)
                            : Colors.black)),
                parameters.metroId.contains(widget.data1[index].id.toString())
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
      ),
    );
  }
}

class MarksList extends StatefulWidget {
  List<dynamic> data2 = [];
  MarksList({super.key, required this.data2});

  @override
  State<MarksList> createState() => _MarksListState();
}

class _MarksListState extends State<MarksList> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();

    return ListView.builder(
      // padding: EdgeInsets.symmetric(vertical: 10.h),
      physics: BouncingScrollPhysics(),
      itemCount: widget.data2.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: () {
            parameters.markId.contains(widget.data2[index].id.toString())
                ? parameters.markId.remove(widget.data2[index].id.toString())
                : parameters.markId.add(widget.data2[index].id.toString());
            print(parameters.markId);
            setState(() {});
            provider.getCount();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(239, 239, 239, 1), width: 1.w),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.data2[index].name,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: parameters.markId
                                .contains(widget.data2[index].id.toString())
                            ? Color.fromRGBO(41, 114, 253, 1)
                            : Colors.black)),
                parameters.markId.contains(widget.data2[index].id.toString())
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
      ),
    );
  }
}

class KnopkaPodtverjdeniya extends StatefulWidget {
  const KnopkaPodtverjdeniya({super.key});

  @override
  State<KnopkaPodtverjdeniya> createState() => _KnopkaPodtverjdeniyaState();
}

class _KnopkaPodtverjdeniyaState extends State<KnopkaPodtverjdeniya> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: InkWell(
        // splashColor: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          setState(() {});
        },
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(16.r)),
          padding: EdgeInsets.symmetric(vertical: 17.h),
          width: MediaQuery.of(context).size.width,
          child: Text(
            "Tesdiqle",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
