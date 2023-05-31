import 'package:attend_kor_teacher/reset_password1.dart';
import 'package:attend_kor_teacher/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'home.dart';
import 'home_student.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class OTP2 extends StatefulWidget {
  final String sUsertype;
  final String? mobilenum;
  const OTP2({super.key, required this.sUsertype,this.mobilenum});
  @override
  State<OTP2> createState() => _OTP2State();
}

class _OTP2State extends State<OTP2> with TickerProviderStateMixin {
  late BuildContext ctx;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpCtrl = TextEditingController();
  TextEditingController otpCtrl2 = TextEditingController();
  bool againmob = false;
  bool againemail = false;

  //Animation fade in
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    print(widget.sUsertype);
    animationController = AnimationController(
      duration: Duration(seconds: 2, milliseconds: 30),
      vsync: this,
    );

    animation = Tween(begin: 4.0, end: 2.5).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset('assets/otp.png'),
              Lottie.asset('animations/resetpass.json',
                  // width: MediaQuery.of(ctx).size.width,
                  height: 320,
                  reverse: false,
                  repeat: false,
                  fit: BoxFit.fill),
              SizedBox(
                height: Dim().d20,
              ),
              FadeTransition(
                opacity:
                    animationController.drive(CurveTween(curve: Curves.easeIn)),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'OTP Verification',
                        style: Sty().largeText.copyWith(
                              fontFamily: 'roboto',
                              color: Clr().primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                      ),
                      verifyUserType(widget.sUsertype),
                      Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset('assets/end.svg')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  //Api Method
  void VerifyOTP() async {
    //Input
    FormData body = FormData.fromMap({
      'mobile': widget.mobilenum,
      'type': widget.sUsertype == 'Teacher'? 'teacher' : 'student',
      'otp': otpCtrl.text,
    });
    //Output
    var result = await STM().post(ctx, Str().verifying, widget.sUsertype == 'Teacher' ? 'reset_password_verify_otp' : "verifyotp", body);
    // if (!mounted) return;
    var message = result['message'];
    var success = result['success'];
    if (success) {
      STM().displayToast(message);
      STM().redirect2page(ctx, ResetPassword1(mobilenum: widget.mobilenum));
    } else {
      var message = result['message'];
      STM().errorDialog(ctx, message);
    }
  }

  void resendOTP() async {
    //Input
    FormData body = FormData.fromMap({
      'mobile': widget.mobilenum,
    });
    //Output
    var result = await STM().post(ctx, Str().verifying, "resent_otp", body);
    // if (!mounted) return;
    var message = result['message'];
    var success = result['success'];
    if (success) {
      STM().displayToast(message);

    } else {
      var message = result['message'];
      STM().errorDialog(ctx, message);
    }
  }

  // Verify otp for teacher password and student registration
  Widget verifyUserType(usertype) {
    return usertype == 'Teacher'
        ? Column(
            children: [
              SizedBox(height: Dim().d8),
              mobileVerifyLayout(),
            ],
          )
        : Column(
            children: [
              SizedBox(height: Dim().d8),
              mobileVerifyLayout(),
              SizedBox(height: Dim().d40),
              emailVerifyLayout(),
            ],
          );
  }

  // mobilenumber otp verfiy
  Widget mobileVerifyLayout() {
    return Column(
      children: [
        Text(
          'We’ve sent you the verification code\non ${widget.mobilenum}',
          textAlign: TextAlign.center,
          style: Sty().mediumText.copyWith(
                fontFamily: 'roboto',
                color: Clr().textcolor,
                fontWeight: FontWeight.w400,
              ),
        ),
        SizedBox(height: Dim().d20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d32),
          child: PinCodeTextField(
            controller: otpCtrl,
            appContext: context,
            enableActiveFill: true,
            textStyle: Sty().largeText,
            length: 4,
            obscureText: false,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            animationType: AnimationType.scale,
            cursorColor: Clr().textcolor,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(Dim().d8),
              disabledColor: Clr().textcolor,
              fieldWidth: Dim().d60,
              fieldHeight: Dim().d56,
              selectedFillColor: Clr().transparent,
              activeFillColor: Clr().white,
              inactiveFillColor: Clr().transparent,
              inactiveColor: Clr().grey,
              activeColor: Clr().textcolor,
              selectedColor: Clr().textcolor,
              borderWidth: 1.5,
            ),
            animationDuration: const Duration(milliseconds: 200),
            onChanged: (value) {},
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'(.{4,})').hasMatch(value)) {
                return "";
              } else {
                return null;
              }
            },
          ),
        ),
        SizedBox(
          height: Dim().d16,
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                VerifyOTP();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Clr().textcolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Text(
                'Verify',
                style: TextStyle(
                  // fontFamily: 'Merriweather',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              )),
        ),
        SizedBox(
          height: Dim().d12,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: !againmob,
                child: TweenAnimationBuilder<Duration>(
                    duration: const Duration(seconds: 60),
                    tween: Tween(
                        begin: const Duration(seconds: 60), end: Duration.zero),
                    onEnd: () {
                      // ignore: avoid_print
                      // print('Timer ended');
                      setState(() {
                        againmob = true;
                      });
                    },
                    builder:
                        (BuildContext context, Duration value, Widget? child) {
                      final minutes = value.inMinutes;
                      final seconds = value.inSeconds % 60;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: RichText(
                          text: TextSpan(
                            text: "Resend code in ",
                            style: Sty().smallText.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Clr().accentColor,
                                fontFamily: ''),
                            children: <TextSpan>[
                              TextSpan(
                                text: '$minutes:$seconds',
                                style: Sty().mediumText.copyWith(
                                    color: Clr().textcolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: ''),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        Center(
          child: Visibility(
            visible: againmob,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  againmob = false;
                });
                resendOTP();
                // STM.checkInternet().then((value) {
                //   if (value) {
                //     sendOTP();
                //   } else {
                //     STM.internetAlert(ctx, widget);
                //   }
                // });
              },
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: "Didn’t received code? ",
                    style: Sty().smallText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Clr().accentColor,
                        fontFamily: ''),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Request again',
                        style: Sty().mediumText.copyWith(
                            color: Clr().textcolor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: ''),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // email verify otp
  Widget emailVerifyLayout() {
    return Column(
      children: [
        Text(
          'We’ve sent you the verification code\non user@example.com',
          textAlign: TextAlign.center,
          style: Sty().mediumText.copyWith(
                fontFamily: 'roboto',
                color: Clr().textcolor,
                fontWeight: FontWeight.w400,
              ),
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d32),
          child: PinCodeTextField(
            controller: otpCtrl2,
            appContext: context,
            enableActiveFill: true,
            textStyle: Sty().largeText,
            length: 4,
            obscureText: false,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            animationType: AnimationType.scale,
            cursorColor: Clr().textcolor,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(Dim().d8),
              disabledColor: Clr().textcolor,
              fieldWidth: Dim().d60,
              fieldHeight: Dim().d56,
              selectedFillColor: Clr().transparent,
              activeFillColor: Clr().white,
              inactiveFillColor: Clr().transparent,
              inactiveColor: Clr().grey,
              activeColor: Clr().textcolor,
              selectedColor: Clr().textcolor,
              borderWidth: 1.5,
            ),
            animationDuration: const Duration(milliseconds: 200),
            onChanged: (value) {},
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'(.{4,})').hasMatch(value)) {
                return "";
              } else {
                return null;
              }
            },
          ),
        ),
        SizedBox(
          height: Dim().d16,
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                // permissionHandle();
                STM().redirect2page(ctx, ResetPassword1());
                // STM().redirect2page(ctx, Home(sUsertype: '', ));
                // if (formKey.currentState!.validate()) {
                //   STM().checkInternet(context, widget).then((value) {
                //     if (value) {
                //       sendOTP();
                //     }
                //   });
                // }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Clr().textcolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Text(
                'Verify',
                style: TextStyle(
                  // fontFamily: 'Merriweather',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              )),
        ),
        SizedBox(
          height: Dim().d12,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: !againemail,
                child: TweenAnimationBuilder<Duration>(
                    duration: const Duration(seconds: 60),
                    tween: Tween(
                        begin: const Duration(seconds: 60), end: Duration.zero),
                    onEnd: () {
                      // ignore: avoid_print
                      // print('Timer ended');
                      setState(() {
                        againemail = true;
                      });
                    },
                    builder:
                        (BuildContext context, Duration value, Widget? child) {
                      final minutes = value.inMinutes;
                      final seconds = value.inSeconds % 60;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: RichText(
                          text: TextSpan(
                            text: "Resend code in ",
                            style: Sty().smallText.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Clr().accentColor,
                                fontFamily: ''),
                            children: <TextSpan>[
                              TextSpan(
                                text: '$minutes:$seconds',
                                style: Sty().mediumText.copyWith(
                                    color: Clr().textcolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: ''),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        Center(
          child: Visibility(
            visible: againemail,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  againemail = false;
                });
                // resendOTP();
                // STM.checkInternet().then((value) {
                //   if (value) {
                //     sendOTP();
                //   } else {
                //     STM.internetAlert(ctx, widget);
                //   }
                // });
              },
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: "Didn’t received code? ",
                    style: Sty().smallText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Clr().accentColor,
                        fontFamily: ''),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Request again',
                        style: Sty().mediumText.copyWith(
                            color: Clr().textcolor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: ''),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
