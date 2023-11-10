import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ChatFusion",
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "DancingScript",
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text("Home Screen"),
            )
          ],
        ),
      ),
    );
  }
}
