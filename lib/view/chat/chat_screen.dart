import 'package:chat_fusion_frontend/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../services/api_constants.dart';
import '../../services/socket_service.dart';
import '../../services/status_code.dart';
import '../../widget/widget.dart';
import 'chat_listing_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.user});

  final UsersModel user;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> with SingleTickerProviderStateMixin {
  final ScrollController _chatSCtrl = ScrollController();
  final FocusNode myFocusNode = FocusNode();
  final DateTime timeStamp = DateTime.now();
  final TextEditingController _chatTextCtrl = TextEditingController();
  late final userData = widget.user;
  late final AnimationController _animationController = AnimationController(
    vsync: this, // Synchronize the animation with the widget's lifecycle.
    duration: const Duration(milliseconds: 700), // Set the duration for the animation.
  );
  late final Animation<Offset> position = Tween<Offset>(
    begin: const Offset(10, 0), // Define the starting position for the animation.
    end: const Offset(0, 0), // Define the ending position for the animation.
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.linear), // Create a curved animation.
  );

  String formatTime(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm a'); // Format for time only, including AM/PM.
    var outputTime = outputFormat.format(inputDate);
    print(outputTime);
    return outputTime;
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    _chatTextCtrl.dispose();
  }

  @override
  void initState() {
    super.initState();
    ref.read(chatList.notifier).getChats(
      ids: [UserPreferences.userId!, userData.id!],
    );
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
                  child: CacheImage(
                    imgUrl: userData.profileUrl!,
                    errorWidget: Image.asset(ImageAssets.blankProfileImg),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(userData.userName!),
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
                Consumer(
                  builder: (context, ref, child) {
                    final chatData = ref.watch(chatList);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: _chatSCtrl,
                            reverse: true,
                            padding: const EdgeInsets.all(
                              15,
                            ),
                            itemCount: chatData.length,
                            itemBuilder: (context, index) {
                              return UserPreferences.userId == chatData[index].senderId!
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            ChatBox(
                                              color: ColorManager.gradientLightPurpleColor,
                                              bottomLeft: 20,
                                              bottomRight: 0,
                                              message: chatData[index].message!,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 4.r,
                                                right: 10.r,
                                              ),
                                              child: Text(
                                                formatTime(chatData[index].createdAt!),
                                                style: const TextStyle(
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
                                            ChatBox(
                                              color: ColorManager.rgbWhiteColor,
                                              bottomLeft: 0,
                                              bottomRight: 20,
                                              message: chatData[index].message!,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 4.r,
                                                right: 10.r,
                                              ),
                                              child: Text(
                                                formatTime(chatData[index].createdAt!),
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
                                    ref.read(chatList.notifier).sendChats(
                                          receiverId: userData.id!,
                                          message: _chatTextCtrl.text.trim(),
                                        );
                                    /*ApiServices().postApi(
                                      api: "${APIConstants.baseUrl}message/send", // API endpoint URL.
                                      // pass the API arguments
                                      body: {
                                        "senderId": UserPreferences.userId,
                                        "receiverId": userData.id,
                                        "message": _chatTextCtrl.text.trim(),
                                        "messageType": "Text"
                                      },
                                    ).then(
                                      (value) {
                                        if (value.statusCode == ServerStatusCodes.addSuccess) {
                                          toastMessage(toastMessage: "Success");
                                        } else {
                                          toastMessage(toastMessage: "Error");
                                        }
                                      },
                                    );*/
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
                    );
                  },
                ),
                Positioned(
                  // Up scroll animation
                  bottom: 15.h,
                  right: 0.h,
                  child: UpAnimation(position: position, scrollController: _chatSCtrl),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
