import 'dart:developer';

import 'package:chat_fusion_frontend/resources/color_manager.dart';
import 'package:chat_fusion_frontend/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../resources/resources.dart';
import '../../widget/widget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorManager.blackColor),
        backgroundColor: ColorManager.rgbWhiteColor,
        title: const Text(
          "You",
          style: TextStyle(
            color: ColorManager.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(),
              Hero(
                tag: "ProfileImage",

                child: Stack(
                  children: [
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(50.w),
                        child: const CacheImage(
                          imgUrl: NetworkImg.demo3,
                          errorWidget: Icon(
                            Icons.abc,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: ColorManager.gradientPurpleColor,
                        radius: 20.w,
                        child: IconButton(
                          onPressed: () {
                            context.push(RoutesName.editProfileScreen);
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 16.h,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "Christopher Brown",
                  style: TextStyle(fontSize: 22.sp),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  "Christopher@gmail.com",
                  style: TextStyle(fontSize: 15.sp,color: ColorManager.grey700Color),
                ),
              ),
              Text(
                "1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letr",
                style: TextStyle(
                  fontSize: 17.sp,
                  color: ColorManager.greyColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
