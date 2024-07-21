import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/details_page/photos_slider.dart';
import 'package:share_plus/share_plus.dart';

import 'details_page_model.dart';

class Photos extends StatelessWidget {
  const Photos({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsPageModel>();

    return Scaffold(
        body: SafeArea(
            child: provider.detailspageData!.logoImages == null
                ? Center(
                    child: CircularProgressIndicator(
                        color: Color.fromRGBO(34, 186, 104, 1)))
                : Padding(
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
                                      provider.markers = {};

                                      Share.share(provider
                                          .detailspageData!.parserSite!);
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(children: [
                                FirstPhoto(),
                                SizedBox(
                                  height: 15.h,
                                ),
                                GridPhotos(),
                                SizedBox(
                                  height: 15.h,
                                ),
                                LastPhoto()
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ))));
  }
}

class FirstPhoto extends StatelessWidget {
  const FirstPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsPageModel>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 180.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image tapped
            CachedNetworkImage(
              imageUrl: 'https://d2jcoi69vojtfw.cloudfront.net/' +
                  provider.detailspageData!.logoImages![0],
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PhotosSlider(
                      page: 0,
                    );
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridPhotos extends StatelessWidget {
  const GridPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsPageModel>();

    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: provider.detailspageData!.logoImages!.length % 2 == 0
            ? provider.detailspageData!.logoImages!.length - 2
            : provider.detailspageData!.logoImages!.length - 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 3),
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                // width: MediaQuery.of(context).size.width,
                // height: 90.h,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image tapped
                    CachedNetworkImage(
                      imageUrl: 'https://d2jcoi69vojtfw.cloudfront.net/' +
                          provider.detailspageData!.logoImages!
                              .getRange(1,
                                  provider.detailspageData!.logoImages!.length)
                              .toList()[index],
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return PhotosSlider(
                              page: index + 1,
                            );
                          }));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

class LastPhoto extends StatelessWidget {
  const LastPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsPageModel>();

    return provider.detailspageData!.logoImages!.length % 2 == 0
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 180.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image tapped
                  CachedNetworkImage(
                    imageUrl: 'https://d2jcoi69vojtfw.cloudfront.net/' +
                        provider.detailspageData!.logoImages!.last,
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PhotosSlider(
                            page: provider.detailspageData!.logoImages!.length,
                          );
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
