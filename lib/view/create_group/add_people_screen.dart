import 'dart:developer';
import 'package:chat_fusion_frontend/routes/routes_name.dart';
import 'package:chat_fusion_frontend/widget/tost_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../resources/resources.dart';
import 'add_people_provider.dart';

class AddPeopleScreen extends StatefulWidget {
  const AddPeopleScreen({super.key});

  @override
  State<AddPeopleScreen> createState() => _AddPeopleScreenState();
}

class _AddPeopleScreenState extends State<AddPeopleScreen>with TickerProviderStateMixin {
  final ScrollController _selectedListCtrl = ScrollController();
  late final AnimationController _scaleCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final Animation<double> _scale = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOutQuint),
  );

  int members = 0;


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
            Consumer(
              builder: (context, ref, child) {
                final selectedPeople = ref.watch(selectPeopleList);
                members = selectedPeople.length;
                return Visibility(
                  visible: selectedPeople.isNotEmpty,
                  child: Container(
                    height: 75.h,
                    margin: EdgeInsets.only(top: 15.r),
                    child: ListView.builder(
                      controller: _selectedListCtrl,
                      itemCount: selectedPeople.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  log("remove");
                                  ref.read(selectPeopleList.notifier).removeAt(index);
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
                                selectedPeople[index].split(" ")[0],
                                style: const TextStyle(
                                  color: ColorManager.greyColor,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),

                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final dividerVisible = ref.watch(selectPeopleList);
                return Visibility(
                  visible: dividerVisible.isNotEmpty,
                  child: const Divider(),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final users = ref.watch(usersList);
                final selected = ref.watch(selectPeopleList);
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 15.r),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5.h,
                        );
                      },
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Stack(
                            children: [
                              ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(22.w),
                                  child: Image.network(
                                    "https://c4.wallpaperflare.com/wallpaper/611/838/413/spiderman-hd-4k-superheroes-wallpaper-thumb.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: selected.contains(users[index]),
                                  child: Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 10.w,
                                      backgroundColor: ColorManager.whiteColor,
                                      child: CircleAvatar(
                                        backgroundColor: ColorManager.gradientPurpleColor,
                                        radius: 7.w,
                                        child: Icon(
                                          Icons.done_rounded,
                                          size: 8.h,
                                          color: ColorManager.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          onTap: () {
                            if (selected.contains(users[index])) {
                              log("remove");
                              ref.read(selectPeopleList.notifier).remove(users[index]);
                              _scaleCtrl.reverse();

                            } else {
                              log("insert");
                              _scaleCtrl.forward();
                              ref.read(selectPeopleList.notifier).add(users[index]);
                              Future.delayed(
                                const Duration(milliseconds: 50),
                                () {
                                  _selectedListCtrl.animateTo(
                                    _selectedListCtrl.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                },
                              );
                            }
                          },
                          title: Text(
                            users[index],
                            style: TextStyle(
                              fontSize: 17.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (members > 0) {
            context.push(RoutesName.createGrpScreen);
          } else {
            toastMessage(toastMessage: "At least 1 user must be selected");
          }
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
