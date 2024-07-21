import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import 'package:provider/provider.dart';

import 'details_page_model.dart';

class PhotosSlider extends StatefulWidget {
  final page;
  const PhotosSlider({
    super.key,
    this.page,
  });

  @override
  State<PhotosSlider> createState() => _PhotosSliderState();
}

class _PhotosSliderState extends State<PhotosSlider> {
  final DetailsPageModelX c = Get.put(DetailsPageModelX());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.changeIndex(widget.page);
    c.controller = PageController(initialPage: widget.page);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailsPageModel>();

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          // shadowColor: Colors.red,

          iconTheme: IconThemeData(
            size: 25,
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            "${c.currentIndex + 1}/${provider.detailspageData!.logoImages!.length}",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),
          ),

          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: PageView.builder(
            pageSnapping: true,
            controller: c.controller,
            onPageChanged: (value) {
              c.changeIndex(value);
              setState(() {});
              print(c.controller.initialPage);
              // print(value);)
            },
            physics: BouncingScrollPhysics(),
            itemCount: provider.detailspageData!.logoImages!.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(12.w),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    imageUrl: 'https://d2jcoi69vojtfw.cloudfront.net/' +
                        provider.detailspageData!.logoImages![index],
                    imageBuilder: (context, imageProvider) =>
                        PhotoView(imageProvider: imageProvider),
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                            color: Color.fromRGBO(34, 186, 104, 1))),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
