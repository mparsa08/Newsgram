import 'package:chat_app/pages/articlescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const deafultfontfamily = 'Avenir';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xff0D253C);
    const secondryTextColor = Color(0xff2D4379);
    const thirdTextColor = Colors.white;
    const forthTextColor = Colors.blue;
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        scrollBehavior: const ScrollBehavior()
            .copyWith(physics: const BouncingScrollPhysics()),
        theme: ThemeData(
          fontFamily: deafultfontfamily,
          useMaterial3: true,
          colorScheme: const ColorScheme.light(
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.5), width: 1),
            ),
          ),
          textTheme: const TextTheme(
            // Title of Posts
            displayLarge: TextStyle(
                fontSize: 18,
                fontFamily: deafultfontfamily,
                color: forthTextColor,
                fontWeight: FontWeight.w700),
            titleMedium: TextStyle(
                fontSize: 18,
                fontFamily: deafultfontfamily,
                color: secondryTextColor,
                fontWeight: FontWeight.w200),
            headlineMedium: TextStyle(
              fontSize: 24,
              fontFamily: deafultfontfamily,
              fontWeight: FontWeight.w700,
              color: primaryTextColor,
            ),
            headlineSmall: TextStyle(
              fontFamily: deafultfontfamily,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: thirdTextColor,
            ),
            bodyMedium: TextStyle(
              fontFamily: deafultfontfamily,
              color: primaryTextColor,
            ),
            bodySmall: TextStyle(
              fontFamily: deafultfontfamily,
              color: primaryTextColor,
            ),
            labelSmall: TextStyle(
                fontFamily: deafultfontfamily,
                color: primaryTextColor,
                fontWeight: FontWeight.w700),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 30,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: forthTextColor,
            selectedIconTheme: IconThemeData(color: Colors.blue),
            unselectedItemColor: Colors.black,
            selectedLabelStyle: TextStyle(
              fontFamily: deafultfontfamily,
              color: primaryTextColor,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: deafultfontfamily,
              color: primaryTextColor,
            ),
          ),
        ),
        home: const ArticleScreen()
        // SplashScreen(),
        );
  }
}
