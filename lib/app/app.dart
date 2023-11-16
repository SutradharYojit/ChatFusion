// Importing necessary packages and resources
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/resources.dart';
import '../routes/route.dart';

// Define the main application class
class MyApp extends StatelessWidget {
  // Constructor for the MyApp class
  const MyApp({super.key});

  // Build method for the application widget
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "PrimaryFonts", // Set the primary font family
            useMaterial3: true,
            scaffoldBackgroundColor: ColorManager.whiteColor,
            appBarTheme: AppBarTheme(
              titleSpacing: 10,
              iconTheme: const IconThemeData(color: ColorManager.whiteColor),
              color: ColorManager.gradientPurpleColor,
              titleTextStyle: TextStyle(
                color: ColorManager.whiteColor,
                fontSize: 17.sp,
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: ColorManager.gradientPurpleColor,

            ),
            dialogTheme: DialogTheme(
              backgroundColor: ColorManager.whiteColor
            )
          ),
          routerConfig: router, // Define the app's router configuration
        );
      },
    );
  }
}
