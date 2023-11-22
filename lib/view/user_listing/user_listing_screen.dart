import 'dart:developer';
import 'package:chat_fusion_frontend/resources/resources.dart';
import 'package:chat_fusion_frontend/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserListingScreen extends StatelessWidget {
  const UserListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.peopleTxt),

      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: ColorManager.gradientPurpleColor,
                    radius: 22.w,
                    child: Image.asset(
                      IconAssets.peopleIcon,
                      height: 19.h,
                    ),
                  ),
                  title: Text(
                    StringManager.newGrpTxt,
                    style: TextStyle(
                      fontSize: 17.sp,
                    ),
                  ),
                  onTap: () {
                    context.push(RoutesName.addPeopleScreen);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.r),
                  child: const Text(
                    StringManager.peopleChatFusionTxt,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorManager.greyColor,
                    ),
                  ),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 5.h,
                    );
                  },
                  itemCount: 20,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipOval(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(22.w),
                          child: Image.network(
                            "https://c4.wallpaperflare.com/wallpaper/611/838/413/spiderman-hd-4k-superheroes-wallpaper-thumb.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        log("message");
                      },
                      title: Text(
                        "Ramesh",
                        style: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
