import 'package:chat_fusion_frontend/resources/resources.dart';
import 'package:chat_fusion_frontend/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> dummyUser = [
    'Jimmy Suthar',
    'Emily Johnson',
    'Michael Davis',
    'Sarah Miller',
    'Christopher Brown',
    'Jessica Wilson',
    'Brian Taylor',
    'Olivia Anderson',
    'David Martinez',
    'Lauren Thomas',
    'Daniel Jackson',
    'Ava White',
    'Matthew Harris',
    'Emma Turner',
    'Andrew Clark',
  ];
  final List<String> dummyImg = [
    NetworkImg.demo1,
    NetworkImg.demo2,
    NetworkImg.demo3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52.h,
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
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              context.push(RoutesName.userProfileScreen);
            },
            icon: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(20.w),
                child: const CacheImage(
                  imgUrl: NetworkImg.demo3,
                  errorWidget: Icon(Icons.abc),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                padding: EdgeInsets.only(top: 10.r, bottom: 50.r),
                itemCount: dummyUser.length,
                itemBuilder: (context, index) {
                  final img=index%dummyImg.length;
                  return ListTile(
                    leading: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(23.w),
                        child:   CacheImage(
                          imgUrl: dummyImg[img],
                          errorWidget: Icon(Icons.abc),
                        ),
                      ),
                    ),
                    title: Text(
                      dummyUser[index],
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutesName.usersListingScreen);
        },
        child: Image.asset(IconAssets.chatIcon, height: 20.h),
      ),
    );
  }
}
