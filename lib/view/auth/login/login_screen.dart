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
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(); // To unfocus on the text filled
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
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
                        StringManager.loginTitle,
                        style: TextStyle(fontSize: 15.sp),
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
                      title: StringManager.loginText,
                      onTap: () async {
                        log("press");
                        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                        if (_emailController.text.trim() == "" ||
                            _emailController.text.trim().isEmpty ||
                            _passController.text.trim() == "" ||
                            _passController.text.trim().isEmpty) {
                          requiredAllFilled(context); // through scaffold snackbar
                        } else {
                          loading(context);

                          ApiServices().postApi(
                            api: "${APIConstants.baseUrl}register/login", // API endpoint URL.
                            // pass the API arguments
                            body: {
                              ApiRequestBody.apiEmail: _emailController.text.trim(),
                              ApiRequestBody.apiPassword: _passController.text.trim(),
                            },
                          ).then(
                                (value) {
                              if(value.statusCode==ServerStatusCodes.unAuthorised){
                                Navigator.pop(context);// pop loading screen
                                // toast snackBar message of invalid credentials
                                WarningBar.snackMessage(context,
                                    message: StringManager.invalidCredentialsTxt, color: ColorManager.redColor);
                              }
                              else{
                                // store user token , and userId , logged in bool value
                                userPreferences.saveLoginUserInfo(
                                  value.data["token"],
                                  value.data["success"],
                                  value.data["userId"],
                                );
                                // Navigate to dashboard
                                context.go(RoutesName.homeScreen);
                              }
                            },
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.0.r),
                      child: GestureDetector(
                        onTap: () {
                          context.goNamed(RoutesName.signupName); // navigate to the signup screen
                        },
                        child: const TextRich(
                          firstText: StringManager.noAccountTxt,
                          secText: StringManager.signUpText,
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
