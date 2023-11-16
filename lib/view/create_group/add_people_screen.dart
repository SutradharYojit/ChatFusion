import 'dart:developer';
import 'package:chat_fusion_frontend/resources/color_manager.dart';
import 'package:chat_fusion_frontend/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddPeopleScreen extends StatefulWidget {
  const AddPeopleScreen({super.key});

  @override
  State<AddPeopleScreen> createState() => _AddPeopleScreenState();
}

class _AddPeopleScreenState extends State<AddPeopleScreen> {
  final ValueNotifier<List<String>> dummyNames = ValueNotifier([
    'John Smith',
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
    'Sophia Garcia',
    'Kevin Moore',
    'Grace Lewis',
    'Ryan Carter',
    'Mia Walker',
    'Ethan Wright',
    'Chloe Robinson',
    'Alexander Young',
    'Lily Hall',
    'Nicholas Baker',
    'Zoe Mitchell',
    'Tyler Cooper',
    'Avery Turner',
    'Brandon Garcia',
  ]);

  ValueNotifier<List<String>> selectNames = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New group",
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            Text(
              "Add participants",
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Visibility(
              visible: selectNames.value.isNotEmpty,
              child: Container(
                height: 75.h,
                margin: EdgeInsets.only(top: 15.r),
                child: ValueListenableBuilder(
                  valueListenable: selectNames,
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  log("message");
                                },
                                borderRadius: BorderRadius.circular(30.w),
                                child: Stack(
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(31.w),
                                        child: Image.network(
                                          "https://c4.wallpaperflare.com/wallpaper/611/838/413/spiderman-hd-4k-superheroes-wallpaper-thumb.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 12.5.w,
                                        backgroundColor: ColorManager.whiteColor,
                                        child: CircleAvatar(
                                          backgroundColor: ColorManager.grey700Color,
                                          radius: 10.w,
                                          child: Icon(
                                            Icons.close,
                                            size: 12.h,
                                            color: ColorManager.whiteColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                value[index],
                                style: TextStyle(
                                  color: ColorManager.greyColor,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: selectNames.value.isNotEmpty,
              child: const Divider(

              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: ListView.separated(
                  padding: EdgeInsets.only(top: 15.r),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 5.h,
                    );
                  },
                  itemCount: dummyNames.value.length,
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
                        log("insert");
                        selectNames.value.add(dummyNames.value[index]);
                        log(selectNames.value.length.toString());
                        setState(() {});
                      },
                      title: Text(
                        dummyNames.value[index],
                        style: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutesName.createGrpScreen);
        },
        child: Icon(
          Icons.arrow_forward_rounded,
          color: ColorManager.whiteColor,
          size: 22.h,
        ),
      ),
    );
  }
}
