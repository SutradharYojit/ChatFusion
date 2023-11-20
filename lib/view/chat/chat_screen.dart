import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/resources.dart';
import '../../widget/widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _chatSCtrl = ScrollController();
  final FocusNode myFocusNode = FocusNode();
  final DateTime timeStamp = DateTime.now();
  final TextEditingController _chatTextCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    _chatTextCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 52.h,
          title: Row(
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(20.w),
                  child: const CacheImage(
                    imgUrl: NetworkImg.demo1,
                    errorWidget: Icon(Icons.abc),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("Jimmy Suthar"),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageAssets.backgroundImg,
                ),
                repeat: ImageRepeat.repeat,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _chatSCtrl,
                        reverse: true,
                        padding: const EdgeInsets.all(
                          15,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return index.isEven
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const ChatBox(
                                          color: ColorManager.gradientLightPurpleColor,
                                          bottomLeft: 20,
                                          bottomRight: 0,
                                          message: "hello",
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 4.r,
                                            right: 10.r,
                                          ),
                                          child: const Text(
                                            "10.45 PM",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const ChatBox(
                                          color: ColorManager.rgbWhiteColor,
                                          bottomLeft: 0,
                                          bottomRight: 20,
                                          message: "Hyyy",
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 4.r,
                                            right: 10.r,
                                          ),
                                          child: Text(
                                            "07.45 PM",
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 10.r),
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryTextFilled(
                              contentPadding: EdgeInsets.all(13.w),
                              focusNode: myFocusNode,
                              controller: _chatTextCtrl,
                              hintText: "Enter message",
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      buildShowModalBottomSheet(
                                        context,
                                        widget: Padding(
                                          padding: EdgeInsets.all(18.0.w),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: ColorManager.gradientBlueColor,
                                                    radius: 25.w,
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.image_outlined,
                                                        size: 21.h,
                                                        color: ColorManager.whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 4.0.r),
                                                    child: const Text("Gallery"),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15.0),
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: ColorManager.gradientVioletColor,
                                                      radius: 25.w,
                                                      child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.video_camera_back_outlined,
                                                          size: 21.h,
                                                          color: ColorManager.whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 4.0.r),
                                                      child: const Text("Video"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    visualDensity: const VisualDensity(
                                      horizontal: -4,
                                      vertical: 0,
                                    ),
                                    icon: Transform.rotate(
                                      angle: -0.7,
                                      child: const Icon(Icons.attach_file_rounded),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 7),
                                    child: IconButton(
                                      onPressed: () {},
                                      visualDensity: const VisualDensity(
                                        horizontal: -4,
                                        vertical: 0,
                                      ),
                                      icon: const Icon(Icons.camera_alt_rounded),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.r),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                _chatTextCtrl.clear();
                              },
                              child: CircleAvatar(
                                maxRadius: 23.w,
                                backgroundColor: ColorManager.blackColor,
                                child: const Icon(
                                  Icons.send_rounded,
                                  color: ColorManager.whiteColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
