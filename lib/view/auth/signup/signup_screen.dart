import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../resources/resources.dart';
import '../../../routes/routes_name.dart';
import '../../../services/api_constants.dart';
import '../../../services/services.dart';
import '../../../services/status_code.dart';
import '../../../widget/widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

void requiredAllFilled(BuildContext context) {
  final bar = WarningBar();

  final notExist = bar.snack(StringManager.requiredWarningTxt, ColorManager.redColor);
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(notExist);
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final bar = WarningBar();
  final userPreferences = UserPreferences();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus
            ?.unfocus(); // unfocus the text field on tapping gesture deatector
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Image.asset(
                        IconAssets.appIcon,
                        height: 100.h,
                      ),
                    ),
                    Text(
                      StringManager.appTitle,
                      style: TextStyle(
                        fontSize: 34.sp,
                        fontFamily: "DancingScript",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.r),
                      child: Text(
                        StringManager.signUpText,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.r),
                      child: PrimaryTextFilled(
                        controller: _userController,
                        hintText: StringManager.userHintTxt,
                        labelText: StringManager.userLabelTxt,
                        prefixIcon: const Icon(
                          Icons.text_format,
                          color: ColorManager.gradientPurpleColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 15.r),
                      child: PrimaryTextFilled(
                        controller: _emailController,
                        hintText: StringManager.emailHintTxt,
                        labelText: StringManager.emailLabelTxt,
                        prefixIcon: const Icon(
                          Icons.mail_rounded,
                          color: ColorManager.gradientPurpleColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.0.sp),
                      child: PrimaryPassField(
                        textPassCtrl: _passController,
                        hintText: StringManager.passHintTxt,
                        labelText: StringManager.passLabelTxt,
                        prefixIcon: const Icon(
                          Icons.password_rounded,
                          color: ColorManager.gradientPurpleColor,
                        ),
                      ),
                    ),
                    PrimaryButton(
                      title: StringManager.signUpText,
                      onTap: () async {
                        if (_emailController.text.trim() == "" ||
                            _emailController.text.trim().isEmpty ||
                            _passController.text.trim() == "" ||
                            _passController.text.trim().isEmpty) {
                          requiredAllFilled(context);
                        } else {
                          loading(context);
                          await ApiServices().postApi(
                            api: "${APIConstants.baseUrl}register/signUp",
                            body: {
                              ApiRequestBody.apiUserName: _userController.text.trim(),
                              ApiRequestBody.apiEmail: _emailController.text.trim(),
                              ApiRequestBody.apiPassword: _passController.text.trim(),
                            },
                          ).then(
                                (value) {
                              if(value.statusCode==ServerStatusCodes.forBid){
                                Navigator.pop(context);// pop loading screen
                                // toast snackBar message of existing User
                                WarningBar.snackMessage(context,
                                    message: StringManager.userExistTxt, color: ColorManager.redColor);
                              }
                              else{
                                // store user token , and userId , logged in bool value
                                userPreferences.saveLoginUserInfo(
                                  value.data["token"],
                                  value.data["success"],
                                  value.data["userId"],
                                );
                                Navigator.pop(context);// pop loading screen

                                // Navigate to dashboard screen
                                context.go(RoutesName.homeScreen);
                              }
                            },
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0.r),
                      child: GestureDetector(
                        onTap: () {
                          context.go(RoutesName.loginScreen); //navgationto login screen
                        },
                        child: const TextRich(
                          firstText: StringManager.haveAccountTxt,
                          secText: StringManager.loginText,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
