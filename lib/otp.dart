
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'home_student.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class OTP extends StatefulWidget {
  final String sUsertype;

  const OTP({super.key, required this.sUsertype});
//   final String smobileCtrl, snameCtrl, semailCtrl, sType;
//
//   const OTP({
//     super.key,
//     required this.smobileCtrl,
//     required this.snameCtrl,
//     required this.semailCtrl,
//     required this.sType,
//   });
//
  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> with TickerProviderStateMixin{
  late BuildContext ctx;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpCtrl = TextEditingController();
  TextEditingController otpCtrl2 = TextEditingController();

  bool againmob = false;
  bool againemail = false;
  String ?sUsertypeid;

  //Animation fade in
  late Animation animation;
  late AnimationController animationController;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      sUsertypeid = sp.getString('usertype_id').toString() ?? "";
      // isSelected = sp.getString('address_id') != null ? true : false;
    });
    STM().checkInternet(ctx, widget).then((value) {
      if (value) {
        // _refreshData();
      }
    });
  }

  @override
  void initState() {
    print('${sUsertypeid}+ddsgwdsgdsw');
    getSession();
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
            SizedBox(height: Dim().d20,),
            FadeTransition(
              opacity: animationController
                  .drive(CurveTween(curve: Curves.easeIn)),
              child: Container(
                child: Column(
                  children: [
                    Text('OTP Verification',
                      style: Sty().largeText.copyWith(
                        fontFamily: 'roboto',
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),),
                    SizedBox(height: Dim().d8,),
                    Text('We’ve sent you the verification code\non  91632147854',
                      textAlign: TextAlign.center,
                      style: Sty().mediumText.copyWith(
                        fontFamily: 'roboto',
                        color: Clr().textcolor,
                        fontWeight: FontWeight.w400,

                      ),),
                    SizedBox(height: Dim().d20,),
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

                          selectedColor: Clr().textcolor,borderWidth: 1.5,
                        ),
                        animationDuration: const Duration(milliseconds: 200),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'(.{4,})').hasMatch(value)) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: Dim().d16,),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            // permissionHandle();
                            widget.sUsertype == 'Teacher' ? STM().redirect2page(ctx, Home()): STM().redirect2page(ctx,  Home_student(sUsertype: 'Student'));
                            // if (formKey.currentState!.validate()) {
                            //   STM().checkInternet(context, widget).then((value) {
                            //     if (value) {
                            //       sendOTP();
                            //     }
                            //   });
                            // }
                            SharedPreferences sp = await SharedPreferences.getInstance();
                            sp.setString('UserType', widget.sUsertype.toString());
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
                    SizedBox(height: Dim().d12,),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: !againmob,
                            child: TweenAnimationBuilder<Duration>(
                                duration: const Duration(seconds: 60),
                                tween: Tween(
                                    begin: const Duration(seconds: 60),
                                    end: Duration.zero),
                                onEnd: () {
                                  // ignore: avoid_print
                                  // print('Timer ended');
                                  setState(() {
                                    againmob = true;
                                  });
                                },
                                builder: (BuildContext context, Duration value,
                                    Widget? child) {
                                  final minutes = value.inMinutes;
                                  final seconds = value.inSeconds % 60;
                                  return Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                    SizedBox(height: Dim().d40,),

                    Text('We’ve sent you the verification code\non user@example.com',
                      textAlign: TextAlign.center,
                      style: Sty().mediumText.copyWith(
                        fontFamily: 'roboto',
                        color: Clr().textcolor,
                        fontWeight: FontWeight.w400,

                      ),),
                    SizedBox(height: Dim().d20,),
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

                          selectedColor: Clr().textcolor,borderWidth: 1.5,
                        ),
                        animationDuration: const Duration(milliseconds: 200),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'(.{4,})').hasMatch(value)) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: Dim().d16,),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async{
                            // permissionHandle();
                            STM().redirect2page(ctx, Home());
                            // if (formKey.currentState!.validate()) {
                            //   STM().checkInternet(context, widget).then((value) {
                            //     if (value) {
                            //       sendOTP();
                            //     }
                            //   });
                            // }
                            SharedPreferences sp = await SharedPreferences.getInstance();
                            sp.setString('UserType', widget.sUsertype.toString());
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
                    SizedBox(height: Dim().d12,),

                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: !againemail,
                            child: TweenAnimationBuilder<Duration>(
                                duration: const Duration(seconds: 60),
                                tween: Tween(
                                    begin: const Duration(seconds: 60),
                                    end: Duration.zero),
                                onEnd: () {
                                  // ignore: avoid_print
                                  // print('Timer ended');
                                  setState(() {
                                    againemail = true;
                                  });
                                },
                                builder: (BuildContext context, Duration value,
                                    Widget? child) {
                                  final minutes = value.inMinutes;
                                  final seconds = value.inSeconds % 60;
                                  return Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                    Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset('assets/end.svg')),
                  ],
                ),
              ),
            ),

          ],
        ),
      )
    );
  }

  //Api Method
  // void VerifyOTP() async {
  //   //Input
  //   FormData body = FormData.fromMap({
  //     'page_type': widget.sType == 'login' ? 'login' : 'register',
  //     'name': widget.snameCtrl,
  //     'mobile': widget.smobileCtrl,
  //     'email': widget.semailCtrl,
  //     'otp': otpCtrl.text,
  //   });
  //   //Output
  //   var result = await STM().post(ctx, Str().verifying, "verifyotp", body, );
  //   // if (!mounted) return;
  //   var message = result['message'];
  //   var success = result['success'];
  //   if (success) {
  //     STM().redirect2page(ctx, AddNewAddress());
  //     // STM().redirect2page(ctx,
  //     //   // Verification("register", mobileCtrl.text.toString()),
  //     //   Verification(stypeValue!,mobileCtrl.text,
  //     //   ),
  //     // );
  //     STM().displayToast(message);
  //   } else {
  //     var message = result['message'];
  //     STM().errorDialog(ctx, message);
  //   }
  // }

  // void resendOTP() async {
  //   //Input
  //   FormData body = FormData.fromMap({
  //     'mobile': widget.smobileCtrl,
  //   });
  //   //Output
  //   var result = await STM().post(ctx, Str().verifying, "resend_otp", body);
  //   // if (!mounted) return;
  //   var message = result['message'];
  //   var success = result['success'];
  //   if (success) {
  //     // STM().redirect2page(ctx,
  //     //   // Verification("register", mobileCtrl.text.toString()),
  //     //   Verification(stypeValue!,mobileCtrl.text,
  //     //   ),
  //     // );
  //     STM().displayToast(message);
  //   } else {
  //     var message = result['message'];
  //     STM().errorDialog(ctx, message);
  //   }
  // }
}
