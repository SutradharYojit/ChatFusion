import 'package:chat_fusion_frontend/resources/resources.dart';
import 'package:chat_fusion_frontend/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringManager.myApp,
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "DancingScript",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              UserPreferences().logOutsetData(context);
            },
            icon: Icon(Icons.logout),
          )
        ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutesName.usersScreen);
        },
        child: Image.asset(IconAssets.chatIcon, height: 20.h),
      ),
    );
  }
}
