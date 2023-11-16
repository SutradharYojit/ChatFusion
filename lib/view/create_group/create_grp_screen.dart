import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'package:chat_fusion_frontend/resources/assets_manager.dart';
import 'package:chat_fusion_frontend/resources/color_manager.dart';
import 'package:chat_fusion_frontend/routes/routes_name.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/user_preferences.dart';
import '../../widget/loading.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _grpCtrl = TextEditingController();
  final ImagePicker picker = ImagePicker(); // image picker function to choose photo from gallery
  ValueNotifier<String> imgUrl = ValueNotifier(""); // get the image url
  File? imageFile;

  Future<String> uploadImage() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final File? image = imageFile;
      var random = Random.secure();
      var values = List<int>.generate(20, (i) => random.nextInt(255));
      String imageName = base64UrlEncode(values);
      final String imagePath = 'GroupImages/${UserPreferences.userId}/$imageName';
      UploadTask uploadTask = storage.ref().child(imagePath).putFile(image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return "";
    }
  }




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New group"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async{
                      await picker
                          .pickImage(
                        source: ImageSource.gallery,
                      )
                          .then((image) async {
                        if (image != null) {
                          loading(context);
                          setState(() {
                            imageFile = File(image.path);
                          });
                          // final imageUrl = await uploadImage();
                          // imgUrl.value = imageUrl;
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 30.w,
                      backgroundColor: ColorManager.gradientGreyColor,
                      child: Image.asset(IconAssets.cameraIcon, height: 25.h),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: _grpCtrl,
                        decoration: const InputDecoration(hintText: "Group name"),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0.r),
                child: Row(
                  children: [
                    Text(
                      "Participants: ",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: ColorManager.grey500Color,
                      ),
                    ),
                    Text(
                      "1",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorManager.grey500Color,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.r),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            dev.log("message");
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
                        const Text(
                          "Ramesh",
                          style: TextStyle(
                            color: ColorManager.greyColor,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Duration duration = const Duration(seconds: 3);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(20.0).w),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 30.r),
                  child: Row(
                    children: [
                      const CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0.r),
                        child: Text(
                          "Creating Group....",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).timeout(duration,onTimeout: () {
            context.go(RoutesName.homeScreen);
          },);
        },
        child: Icon(
          Icons.done_rounded,
          color: ColorManager.whiteColor,
          size: 21.h,
        ),
      ),
    );
  }
}
