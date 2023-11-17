import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/resources.dart';
import '../../services/others.dart';
import '../../widget/widget.dart';

class EditUserProfile extends StatelessWidget {
  EditUserProfile({super.key});

  final ImagePicker picker = ImagePicker(); // image picker function to choose photo from gallery
  final ValueNotifier<String> imgUrl = ValueNotifier(""); // get the image url
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorManager.blackColor),
        backgroundColor: ColorManager.rgbWhiteColor,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: ColorManager.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                        size: Size.fromRadius(65.w),
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
                        radius: 22.w,
                        child: IconButton(
                          onPressed: () async {
                            await picker
                                .pickImage(
                              source: ImageSource.gallery,
                            )
                                .then(
                              (image) async {
                                if (image != null) {
                                  loading(context);
                                  // setState(() {
                                  //   imageFile = File(image.path);
                                  // });
                                  // final imageUrl = await OthersServices.uploadImage(imageFile);
                                  // imgUrl.value = imageUrl;
                                  // Navigator.pop(context);
                                }
                              },
                            );
                          },
                          icon: Icon(
                            Icons.camera_enhance_rounded,
                            size: 20.h,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.sp),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.person,
                    color: ColorManager.greyColor,
                    size: 25.h,
                  ),
                  title: Text(
                    "Name",
                    style: TextStyle(color: ColorManager.grey700Color, fontSize: 15.sp),
                  ),
                  subtitle: Text(
                    "Christopher Brown",
                    style: TextStyle(color: ColorManager.blackColor, fontSize: 15.sp),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.sp),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.info_outline,
                    color: ColorManager.greyColor,
                    size: 25.h,
                  ),
                  title: Text(
                    "About",
                    style: TextStyle(color: ColorManager.grey700Color, fontSize: 15.sp),
                  ),
                  subtitle: Text(
                    "Christopher Brown",
                    style: TextStyle(color: ColorManager.blackColor, fontSize: 15.sp),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.sp),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.mail_outline_rounded,
                    color: ColorManager.greyColor,
                    size: 25.h,
                  ),
                  title: Text(
                    "Email",
                    style: TextStyle(color: ColorManager.grey700Color, fontSize: 15.sp),
                  ),
                  subtitle: Text(
                    "Christopher@gmail.com",
                    style: TextStyle(color: ColorManager.blackColor, fontSize: 15.sp),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
