import 'dart:developer';
import 'package:chat_fusion_frontend/resources/resources.dart';
import 'package:chat_fusion_frontend/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import 'user_listing_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(userList.notifier).getUsers();
  }

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
            Consumer(
              builder: (context, ref, child) {
                final users = ref.watch(userList);

                return users.isEmpty
                    ? const Expanded(child: CircularLoading())
                    : Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          padding: EdgeInsets.only(top: 10.r, bottom: 50.r),
                          itemCount: users.length - 1,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                log("move to chat screen");
                                context.push(RoutesName.chatScreen, extra: users[index + 1]);
                              },
                              leading: ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(23.w),
                                  child: CacheImage(
                                    imgUrl: users[index + 1].profileUrl.toString(),
                                    errorWidget: Image.asset(ImageAssets.blankProfileImg),
                                  ),
                                ),
                              ),
                              title: Text(
                                users[index + 1].userName.toString(),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                      );
              },
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
