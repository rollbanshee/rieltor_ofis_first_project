import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/domain/api_clients/api_client.dart';
import 'package:rieltor_ofis/domain/entity/search/search.dart';
import 'package:rieltor_ofis/ui/screens/search/search.dart';
import 'package:rieltor_ofis/ui/screens/search/search_model.dart';

class Cities1 extends StatefulWidget {
  const Cities1({
    super.key,
  });

  @override
  State<Cities1> createState() => _Cities1State();
}

class _Cities1State extends State<Cities1> {
  List cities = [];
  final searchController = TextEditingController();
  List filteredCities = [];
  Future<List> getCities() async {
    List cities = await ApiClient().getCities();
    this.cities = cities;
    filteredCities = cities;
    setState(() {});

    return cities;
  }

  Future<List> forFuture() async {
    if (searchController.text.isNotEmpty) {
      filteredCities = cities.where((city1) {
        return city1.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
      }).toList();
    } else {
      filteredCities = cities;
      setState(() {});
    }

    setState(() {});

    return cities;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    searchController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCities();

    searchController.addListener(forFuture);
  }

  bool check = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GetAnnounces>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0.h),
          child: Column(
            children: [
              AppBar(),
              SizedBox(
                height: 8.h,
              ),
              CitiesTextField(
                searchController: searchController,
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: () {
                            city = filteredCities[index].name;
                            parameters.cityId =
                                filteredCities[index].id.toString();
                            provider.getCount();

                            Navigator.pop(context);
                            setState(() {
                              check = !check;
                              print(parameters.cityId);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 13.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: Color.fromRGBO(239, 239, 239, 1))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  filteredCities[index].name ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    // color: check
                                    //     ? Color.fromRGBO(
                                    //         41, 114, 253, 1)
                                    //     : Color.fromRGBO(
                                    //         51, 51, 51, 1)),
                                  ),
                                  // Container(
                                  //   width: 24.w,
                                  //   height: 24.h,
                                  //   decoration: BoxDecoration(
                                  //       shape: BoxShape.circle,
                                  //       border: Border.all(
                                  //           color: Color.fromRGBO(
                                  //               239, 239, 239, 1),
                                  //           width: 2.w)),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
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
                "Şəhər",
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

class CitiesTextField extends StatefulWidget {
  final searchController;
  const CitiesTextField({
    super.key,
    required this.searchController,
  });

  @override
  State<CitiesTextField> createState() => _CitiesTextFieldState();
}

class _CitiesTextFieldState extends State<CitiesTextField> {
  // List<Cities>

  // textSearch(){

  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   searchController.addListener(() {textSearch() });
  // }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      enabled: true,
      cursorColor: Color.fromRGBO(34, 186, 104, 0.1),
      decoration: InputDecoration(
          hintText: "Axtar",
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Color.fromRGBO(51, 51, 51, 0.7)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                  color: Color.fromRGBO(239, 239, 239, 1), width: 1.w)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                  color: Color.fromRGBO(239, 239, 239, 1), width: 1.w)),
          contentPadding: EdgeInsets.fromLTRB(15.w, 18.h, 13.w, 18.h),
          isCollapsed: true,
          suffixIcon: SvgPicture.asset("assets/images/MagnifyingGlass.svg"),
          suffixIconConstraints:
              BoxConstraints(minWidth: 40.w, minHeight: 24.h)),
    );
  }
}
