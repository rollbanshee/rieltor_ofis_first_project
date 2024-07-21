import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rieltor_ofis/ui/screens/authorization/auth_model.dart';
import 'package:rieltor_ofis/ui/screens/details_page/details_page_model.dart';
import 'package:rieltor_ofis/ui/screens/favourites/folders_model.dart';
import 'package:rieltor_ofis/ui/screens/search/search_model.dart';
import 'package:rieltor_ofis/ui/screens/search/searchannounces/searchannouncesmodel.dart';
import 'package:rieltor_ofis/ui/screens/subscriptions/subscriptions_model.dart';
import 'ui/screens/splash_screen/secondmain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // bool authCheck2 = false;
    // WidgetsFlutterBinding.ensureInitialized();
    // Future<void> checkAuth() async {
    //   FlutterSecureStorage secureStorage = FlutterSecureStorage();
    //   String? authCheck = await secureStorage.read(key: 'auth');
    //   if (authCheck != null) {
    //     authCheck2 = bool.parse(authCheck);
    //   }

    // }

    // checkAuth();

    return ScreenUtilInit(
      builder: (context, child) => MultiProvider(
        providers: [
          Provider(
            create: (context) => AuthModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => DetailsPageModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => GetAnnounces(),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchAnnouncesModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => FoldersModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => SubscriptionModel(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
            // useMaterial3: false,
            // splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            // hoverColor: Colors.transparent,
          ),
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
      designSize: const Size(375, 812),
    );
  }
}
